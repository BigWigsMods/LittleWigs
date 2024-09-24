--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kruul", 1698) -- The Highlord's Return
if not mod then return end
mod:RegisterEnableMob(117933, 117198) -- Inquisitor Variss, Highlord Kruul
mod.otherMenu = 1716 -- Broken Shore Mage Tower

--------------------------------------------------------------------------------
-- Locals
--

local aberrationCounter = 1
local annihilateCounter = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- NPC Names
	L.name = "Highlord Kruul"
	L.inquisitor = "Inquisitor Variss"
	L.velen = "Prophet Velen"

	-- Triggers
	L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	L.win_trigger = "So be it. You will not stand in our way any longer."

	L.nether_aberration = 235110
	L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."
	L.nether_aberration_icon = "ability_socererking_summonaberration"

	L.smoldering_infernal = "Smoldering Infernal"
	L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
	L.smoldering_infernal_icon = "inv_infernalmountgreen"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"stages",
		"nether_aberration", -- Nether Aberration
		240790, -- Nether Storm

		--[[ Prophet Velen ]]--
		{233473, "CASTBAR"}, -- Holy Ward

		--[[ Inquisitor Variss ]]--
		234423, -- Drain Life
		234422, -- Aura of Decay
		234428, -- Summon Tormenting Eye
		"smoldering_infernal", -- Smoldering Infernal Summon
		234631, -- Smash

		--[[ Highlord Kruul ]]--
		236572, -- Annihilate
		234920, -- Shadow Sweep
		234673, -- Nether Stomp
		234676, -- Twisted Reflections
	},{
		["warmup"] = "general",
		[233473] = L.velen,
		[234423] = L.inquisitor,
		[236572] = L.name,
	}
end

function mod:OnRegister()
	self.displayName = L.name
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "SayTriggers")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_START", "NetherStorm", 240790)
	self:Log("SPELL_CAST_START", "DrainLife", 234423)
	self:Log("SPELL_CAST_START", "HolyWard", 233473)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AuraOfDecay", 234422)
	self:Log("SPELL_CAST_START", "Smash", 234631)
	self:Log("SPELL_CAST_START", "Annihilate", 236572)
	self:Log("SPELL_CAST_SUCCESS", "AnnihilateSuccess", 236572)
	self:Log("SPELL_CAST_START", "TwistedReflections", 234676)

	self:Death("KruulIncoming", 117933) -- Inquisitor Variss
end

function mod:OnEngage()
	aberrationCounter = 1
	annihilateCounter = 1
	self:CDBar(234428, 3) -- Summon Tormenting Eye
	self:CDBar("nether_aberration", 10, CL.count:format(self:SpellName(L.nether_aberration), aberrationCounter), L.nether_aberration_icon) -- Nether Aberration
	self:CDBar("smoldering_infernal", 35, L.smoldering_infernal, L.smoldering_infernal_icon) -- Smoldering Infernal Summon
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SayTriggers(_, msg)
	if msg == L.warmup_trigger then
		self:Bar("warmup", 25, CL.active, "inv_pet_inquisitoreye")
	elseif msg == L.win_trigger then
		self:Win()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 234428 then -- Summon Tormenting Eye
		self:Message(spellId, "yellow")
		self:CDBar(spellId, 17)
		self:PlaySound(spellId, "info")
	elseif spellId == 235110 then -- Nether Aberration
		self:StopBar(CL.count:format(self:SpellName(spellId), aberrationCounter))
		self:Message("nether_aberration", "cyan", CL.count:format(CL.incoming:format(self:SpellName(spellId)), aberrationCounter), L.nether_aberration_icon)
		aberrationCounter = aberrationCounter + 1
		self:CDBar("nether_aberration", 35, CL.count:format(self:SpellName(spellId), aberrationCounter), L.nether_aberration_icon)
		self:PlaySound("nether_aberration", "info")
	elseif spellId == 235112 then -- Smoldering Infernal Summon
		self:Message("smoldering_infernal", "yellow", CL.incoming:format(L.smoldering_infernal), L.smoldering_infernal_icon)
		self:CDBar("smoldering_infernal", 65, L.smoldering_infernal, L.smoldering_infernal_icon)
		self:PlaySound("smoldering_infernal", "info")
	elseif spellId == 234920 then -- Shadow Sweep
		self:Message(spellId, "yellow", CL.incoming:format(self:SpellName(spellId)))
		self:Bar(spellId, 20.7)
		self:PlaySound(spellId, "info")
	elseif spellId == 234673 then -- Netherstomp
		self:Message(spellId, "orange")
		self:Bar(spellId, 15.8)
		self:PlaySound(spellId, "alert")
	elseif spellId == 233458 then -- Gift of Sargeras
		-- Spoiler: HE EXPLODES!
		self:Win()
	end
end

do
	local prev = 0
	function mod:NetherStorm(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:DrainLife(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 23)
	self:PlaySound(args.spellId, "alert")
end

function mod:HolyWard(args)
	self:Message(args.spellId, "green", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 8)
	self:CDBar(args.spellId, 35)
	self:PlaySound(args.spellId, "long")
end

function mod:AuraOfDecay(args)
	local amount = args.amount or 1
	self:StackMessage(args.spellId, "blue", args.destName, amount, 3)
	if amount > 3 then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:Smash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:KruulIncoming(args)
	self:Message("stages", "green", CL.incoming:format(L.name), "warlock_summon_doomguard")
	self:StopBar(L.smoldering_infernal) -- Smoldering Infernal
	self:StopBar(234423) -- Drain Life
	self:StopBar(234428) -- Summon Tormenting Eye
	self:PlaySound("stages", "long")
end

function mod:Annihilate(args)
	self:Message(args.spellId, "red", CL.casting:format(CL.count:format(args.spellName, annihilateCounter)))
	self:PlaySound(args.spellId, "alarm")
end

function mod:AnnihilateSuccess(args)
	self:StopBar(CL.count:format(args.spellName, annihilateCounter))
	annihilateCounter = annihilateCounter + 1
	self:CDBar(args.spellId, 27, CL.count:format(args.spellName, annihilateCounter))
end

function mod:TwistedReflections(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end
