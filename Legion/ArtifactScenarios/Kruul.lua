
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
	-- L.warmup_trigger = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!"
	-- L.win_trigger = "So be it. You will not stand in our way any longer."

	-- Engage / Options
	-- L.engage_message = "Highlord Kruul's Challenge Engaged!"

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
		233473, -- Holy Ward

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

	-- Big evul hack to enable the module when entering the scenario
	self:RegisterEvent("SCENARIO_UPDATE")
	if C_Scenario.IsInScenario() then
		self:SCENARIO_UPDATE()
	end
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
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

function mod:OnDisable()
	self:RegisterEvent("SCENARIO_UPDATE")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SCENARIO_UPDATE()
	if self:IsEnabled() then return end
	local _, _, numCriteria = C_Scenario.GetStepInfo()
	for i = 1, numCriteria do
		local criteriaID = select(9, C_Scenario.GetCriteriaInfo(i))
		if criteriaID == 34961 then -- Destroy Highlord Kruul permanently
			mod:Enable()
		end
	end
end

function mod:Warmup(event)
	self:UnregisterEvent(event)
	self:CDBar("warmup", 25, CL.active, "inv_pet_inquisitoreye")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 234428 then -- Summon Tormenting Eye
		self:Message(spellId, "Attention", "Info")
		self:CDBar(spellId, 17)
	elseif spellId == 235110 then -- Nether Aberration
		aberrationCounter = aberrationCounter + 1
		self:Message("nether_aberration", "Attention", "Info", CL.incoming:format(CL.count:format(spellName, aberrationCounter-1)), L.nether_aberration_icon)
		self:CDBar("nether_aberration", 35, CL.count:format(spellName, aberrationCounter), L.nether_aberration_icon)
	elseif spellId == 235112 then -- Smoldering Infernal Summon
		self:Message("smoldering_infernal", "Attention", "Info", CL.incoming:format(L.smoldering_infernal), L.smoldering_infernal_icon)
		self:CDBar("smoldering_infernal", 65, L.smoldering_infernal, L.smoldering_infernal_icon)
	elseif spellId == 234920 then -- Shadow Sweep
		self:Message(spellId, "Attention", "Info", CL.incoming:format(spellName))
		self:Bar(spellId, 20.7)
	elseif spellId == 234673 then -- Netherstomp
		self:Message(spellId, "Urgent", "Alert")
		self:Bar(spellId, 15.8)
	elseif spellId == 233458 then -- Gift of Sargeras
		-- Spoiler: HE EXPLODES!
		self:Win()
	end
end

do
	local prev = 0
	function mod:NetherStorm(args)
		local t = GetTime()
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "Important", "Warning", CL.casting:format(args.spellName))
		end
	end
end

function mod:DrainLife(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 23)
end

function mod:HolyWard(args)
	self:Message(args.spellId, "Positive", "Long", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 8)
	self:CDBar(args.spellId, 35)
end

function mod:AuraOfDecay(args)
	local amount = args.amount or 1
	self:StackMessage(args.spellId, args.destName, amount, "Personal", amount > 3 and "Warning")
end

function mod:Smash(args)
	self:Message(args.spellId, "Important", "Alarm", args.spellName)
end

function mod:KruulIncoming(args)
	self:Message("stages", "Positive", "Long", CL.incoming:format(L.name), "warlock_summon_doomguard")
	self:StopBar(L.smoldering_infernal) -- Smoldering Infernal
	self:StopBar(234423) -- Drain Life
	self:StopBar(234428) -- Summon Tormenting Eye
end

function mod:Annihilate(args)
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(CL.count:format(args.spellName, annihilateCounter)))
end

function mod:AnnihilateSuccess(args)
	annihilateCounter = annihilateCounter + 1
	self:CDBar(args.spellId, 27, CL.count:format(args.spellName, annihilateCounter))
end

function mod:TwistedReflections(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end
