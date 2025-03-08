--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Prioress Murrpray", 2649, 2573)
if not mod then return end
mod:RegisterEnableMob(207940) -- Prioress Murrpray
mod:SetEncounterID(2848)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		423588, -- Barrier of Light
		423664, -- Embrace the Light
		{444546, "SAY"}, -- Purify
		425556, -- Sanctified Ground
		{444608, "HEALER"}, -- Inner Fire
		451605, -- Holy Flame
		-- Mythic
		{428169, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Blinding Light
	}, {
		[428169] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BarrierOfLight", 423588)
	self:Log("SPELL_AURA_REMOVED", "BarrierOfLightRemoved", 423588)
	self:Log("SPELL_INTERRUPT", "EmbraceTheLightInterrupted", 423664)
	self:Log("SPELL_CAST_SUCCESS", "Purify", 444546)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Purify
	self:Log("SPELL_PERIODIC_DAMAGE", "SanctifiedGroundDamage", 425556)
	self:Log("SPELL_PERIODIC_MISSED", "SanctifiedGroundDamage", 425556)
	self:Log("SPELL_CAST_START", "InnerFire", 444608)
	self:Log("SPELL_CAST_START", "HolyFlame", 451605)

	-- Mythic
	self:Log("SPELL_CAST_START", "BlindingLight", 428169)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(451605, 6.3) -- Holy Flame
	self:CDBar(444546, 13.1) -- Purify
	if self:Mythic() then
		self:CDBar(428169, 13.8) -- Blinding Light
	end
	-- cast at 100 energy: starts at 25 energy. 15s energy gain + delay
	self:CDBar(444608, 15.4) -- Inner Fire
end

function mod:VerifyEnable(unit)
	-- the boss shows up halfway through the dungeon for some RP
	return UnitCanAttack("player", unit)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local barrierOfLightStart = 0

	function mod:BarrierOfLight(args)
		barrierOfLightStart = args.time
		self:StopBar(444546) -- Purify
		self:StopBar(444608) -- Inner Fire
		self:StopBar(451605) -- Holy Flame
		if self:Mythic() then
			self:StopBar(428169) -- Blinding Light
		end
		self:SetStage(2)
		self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
		self:PlaySound(args.spellId, "long")
	end

	function mod:BarrierOfLightRemoved(args)
		local barrierOfLightDuration = args.time - barrierOfLightStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, barrierOfLightDuration))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:EmbraceTheLightInterrupted(args)
	self:Message(423664, "green", CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
	self:SetStage(1)
	if self:Mythic() then
		self:CDBar(451605, 13.4) -- Holy Flame
		-- cast at 100 energy: 20s energy gain
		self:CDBar(444608, 20.0) -- Inner Fire
		self:CDBar(444546, 20.1) -- Purify
		self:CDBar(428169, 23.1) -- Blinding Light
	else -- Normal, Heroic
		self:CDBar(444546, 9.1) -- Purify
		self:CDBar(451605, 9.8) -- Holy Flame
		-- cast at 100 energy: 20s energy gain
		self:CDBar(444608, 20.0) -- Inner Fire
	end
	self:PlaySound(423664, "info")
end

function mod:Purify(args)
	self:Message(args.spellId, "orange", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 28.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg)
	if msg:find("425556", nil, true) then -- Purify
		-- [CHAT_MSG_RAID_BOSS_WHISPER] |TInterface\\ICONS\\Ability_Paladin_TowerofLight.BLP:20|t %s targets you with |cFFFF0000|Hspell:425556|h[Purifying Light]|h|r!#Eternal Flame
		self:PersonalMessage(444546)
		self:Say(444546, nil, nil, "Purify")
		self:PlaySound(444546, "warning")
	end
end

do
	local prev = 0
	function mod:SanctifiedGroundDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:InnerFire(args)
	self:Message(args.spellId, "red")
	-- cast at 100 energy: 2s cast time + 20s energy gain + delay
	self:CDBar(args.spellId, 22.6)
	self:PlaySound(args.spellId, "info")
end

function mod:HolyFlame(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alarm")
end

-- Mythic

function mod:BlindingLight(args)
	self:Message(args.spellId, "red")
	self:CastBar(args.spellId, 4)
	self:CDBar(args.spellId, 24.2)
	self:PlaySound(args.spellId, "warning")
end
