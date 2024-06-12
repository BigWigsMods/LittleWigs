if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rasha'nan Dawnbreaker", 2662, 2593)
if not mod then return end
mod:RegisterEnableMob(213937) -- Rasha'nan
mod:SetEncounterID(2839)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local throwArathiBombCount = 1
local erosiveSprayCount = 1
local radiantLightOnGroup = false
local acidicEruptionCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.flying_available = "You can fly now"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage 1: The Dawnbreaker
		434655, -- Arathi Bomb
		434407, -- Rolling Acid
		448888, -- Erosive Spray
		448213, -- Expel Webs (Mythic)
		435793, -- Tacky Burst
		-- Intermission: Escape!
		449528, -- Radiant Light
		{449332, "COUNTDOWN"}, -- Encroaching Shadows
		449734, -- Acidic Eruption
		-- Stage 2: The Veneration Grounds
		434089, -- Spinneret's Strands
	}, {
		[434655] = -28814, -- Stage 1: The Dawnbreaker
		[449528] = -29591, -- Intermission: Escape!
		[434089] = -28821, -- Stage 2: The Veneration Grounds
	}, {
		[448213] = CL.mythic, -- Expel Webs (Mythic mode)
		[449528] = L.flying_available, -- Radiant Light (You can fly now)
	}
end

function mod:OnBossEnable()
	-- Stage 1: The Dawnbreaker
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Arathi Bomb, Intermission trigger
	self:Log("SPELL_AURA_APPLIED", "CarryingArathiBomb", 434668)
	self:Log("SPELL_CAST_SUCCESS", "ThrowArathiBomb", 438875)
	self:Log("SPELL_CAST_START", "RollingAcid", 434407)
	-- TODO private aura sound on Rolling Acid?
	self:Log("SPELL_CAST_START", "ErosiveSpray", 448888)
	self:Log("SPELL_CAST_START", "ExpelWebs", 448213)
	self:Log("SPELL_CAST_SUCCESS", "TackyBurst", 435793)

	-- Intermission: Escape!
	self:Log("SPELL_CAST_SUCCESS", "RadiantLight", 449498)
	self:Log("SPELL_AURA_APPLIED", "EncroachingShadowsApplied", 449332)
	self:Log("SPELL_AURA_REMOVED", "EncroachingShadowsRemoved", 449332)
	self:Log("SPELL_CAST_START", "AcidicEruption", 449734)
	self:Log("SPELL_INTERRUPT", "AcidicEruptionInterrupted", "*")

	-- Stage 2: The Veneration Grounds
	self:Log("SPELL_CAST_START", "SpinneretsStrands", 434089)
	-- TODO private aura sound on Spinneret's Strands?
end

function mod:OnEngage()
	throwArathiBombCount = 1
	erosiveSprayCount = 1
	radiantLightOnGroup = false
	acidicEruptionCount = 1
	self:SetStage(1)
	self:CDBar(434407, 9.3) -- Rolling Acid
	self:CDBar(434655, 13.5, CL.spawning:format(self:SpellName(434655))) -- Arathi Bomb
	self:CDBar(448888, 20.0, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
	--if self:Mythic() then
		--TODO self:CDBar(448213, 10) -- Expel Webs
	--end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1: The Dawnbreaker

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("434655", nil, true) then -- Arathi Bomb
		-- |TInterface\\ICONS\\INV_Eng_BombFire.blp:20|t A %s arrives to throw |cFFFF0000|Hspell:434655|h[Arathi Bomb]|h|rs!#Nightfall Bomber
		self:Message(434655, "cyan", CL.spawning:format(self:SpellName(434655)))
		self:PlaySound(434655, "long")
		self:CDBar(434655, 33.3, CL.spawning:format(self:SpellName(434655)))
	elseif msg:find("INV_Icon_wing07b", nil, true) then -- Intermission: Escape!
		-- |TInterface\\ICONS\\INV_Icon_wing07b.BLP:20|t %s begins to flee! |TInterface\\ICONS\\Ability_DragonRiding_DragonRiding01.BLP:20|t Take flight!#Rasha'nan
		self:StopBar(434407) -- Rolling Acid
		self:StopBar(CL.spawning:format(self:SpellName(434655))) -- Arathi Bomb
		self:StopBar(CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
		if self:Mythic() then
			self:StopBar(448213) -- Expel Webs
		end
		self:SetStage(1.5)
		self:Message("stages", "cyan", self:SpellName(-29591), "INV_Icon_wing07b") -- Intermission: Escape!
		self:PlaySound("stages", "long")
	end
end

function mod:CarryingArathiBomb(args)
	if self:Me(args.destGUID) then
		self:Message(434655, "blue", args.spellName)
		self:PlaySound(434655, "info", nil, args.destName)
	end
end

function mod:ThrowArathiBomb(args)
	self:Message(434655, "green", CL.count_amount:format(args.spellName, throwArathiBombCount, 5))
	if self:Me(args.sourceGUID) then
		self:PlaySound(434655, "info", nil, args.sourceName)
	end
	throwArathiBombCount = throwArathiBombCount + 1
end

function mod:RollingAcid(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 20.0)
end

function mod:ErosiveSpray(args)
	self:StopBar(CL.count:format(args.spellName, erosiveSprayCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, erosiveSprayCount))
	self:PlaySound(args.spellId, "alert")
	erosiveSprayCount = erosiveSprayCount + 1
	self:CDBar(args.spellId, 20.0, CL.count:format(args.spellName, erosiveSprayCount))
end

function mod:ExpelWebs(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:CDBar(args.spellId, 20.0) TODO
end

function mod:TackyBurst(args)
	-- spammed when no one is in melee range
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	end
end

-- Intermission: Escape!

function mod:RadiantLight()
	if not radiantLightOnGroup then
		-- this is cast more than once, and allows you to fly. we only care about the very first cast.
		radiantLightOnGroup = true
		self:Message(449528, "green", L.flying_available, "Ability_DragonRiding_DragonRiding01")
		self:PlaySound(449528, "info")
	end
end

function mod:EncroachingShadowsApplied(args)
	if self:Me(args.destGUID) then
		-- if this bar runs out, you die
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:EncroachingShadowsRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellId, args.destName)
	end
end

function mod:AcidicEruption(args)
	-- spammed until interrupted
	self:Message(args.spellId, "yellow", CL.count:format(CL.casting:format(args.spellName), acidicEruptionCount))
	self:PlaySound(args.spellId, "alert")
	acidicEruptionCount = acidicEruptionCount + 1
end

function mod:AcidicEruptionInterrupted(args)
	if args.extraSpellId == 449734 then -- Acidic Eruption
		erosiveSprayCount = 1
		self:Message(449734, "green", CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:PlaySound(449734, "info")
		self:SetStage(2)
		self:CDBar(434407, 4.0) -- Rolling Acid
		self:CDBar(434089, 12.0) -- Spinneret's Strands
		self:CDBar(448888, 20.0, CL.count:format(self:SpellName(448888), erosiveSprayCount)) -- Erosive Spray
		--if self:Mythic() then
			--TODO self:CDBar(448213, 10) -- Expel Webs
		--end
	end
end

-- Stage 2: The Veneration Grounds

function mod:SpinneretsStrands(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 20.0)
end
