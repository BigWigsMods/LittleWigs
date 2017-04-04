
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kruul", nil, nil, 1698)
if not mod then return end
mod:RegisterEnableMob(117933, 117198) -- Inquisitor Variss, Highlord Kruul
mod.otherMenu = 1021 -- Broken Shore

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

	-- Engage / Options
	L.engage_message = "Highlord Kruul's Challenge Engaged!"

	L.nether_aberration = 235110
	L.nether_aberration_desc = "Summons portals around the room, spawning Nether Aberrations."
	L.nether_aberration_icon = "ability_socererking_summonaberration"

	L.smoldering_infernal = "Smoldering Infernal"
	L.smoldering_infernal_desc = "Summons a Smoldering Infernal."
	L.smoldering_infernal_icon = "inv_infernalmountgreen"
end
mod.displayName = L.name

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"stages",
		"nether_aberration", -- Nether Aberration
		233473, -- Holy Ward
		234423, -- Drain Life
		234422, -- Aura of Decay
		234428, -- Summon Tormenting Eye
		"smoldering_infernal", -- Smoldering Infernal Summon
	},{
		["warmup"] = "general",
		[233473] = L.velen,
		[234423] = L.inquisitor,
		--[123456] = L.name,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "DrainLife", 234423)
	self:Log("SPELL_CAST_START", "HolyWard", 233473)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AuraOfDecay", 234422)

	self:Death("KruulIncoming", 117933) -- Inquisitor Variss
	self:Death("Win", 117198) -- Highlord Kruul, Uncomfirmed
end

function mod:OnEngage()
	self:Message("stages", "Neutral", nil, L.engage_message, "inv_icon_heirloomtoken_weapon01")
	self:CDBar("smoldering_infernal", 35, L.smoldering_infernal, L.smoldering_infernal_icon)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(_, msg)
	if msg == L.warmup_trigger then
		self:Bar("warmup", 25, CL.active, "inv_pet_inquisitoreye")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 234428 then -- Summon Tormenting Eye
		self:Message(spellId, "Attention", "Info")
		self:CDBar(spellId, 18)
	elseif spellId == 235110 then -- Nether Aberration
		self:Message("nether_aberration", "Attention", "Info", CL.incoming:format(spellName), L.nether_aberration_icon)
		self:CDBar("nether_aberration", 35, spellName, L.nether_aberration_icon)
	elseif spellId == 235112 then -- Smoldering Infernal Summon
		self:Message("smoldering_infernal", "Attention", "Info", CL.incoming:format(L.smoldering_infernal), L.smoldering_infernal_icon)
		self:CDBar("smoldering_infernal", 50, L.smoldering_infernal, L.smoldering_infernal_icon)
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
	self:StackMessage(args.spellId, args.destName, amount, "Personal", "Alarm")
end

function mod:KruulIncoming(args)
	self:Message("stages", "Positive", "Long", CL.incoming:format(L.name), "warlock_summon_doomguard")
	self:StopBar(L.smoldering_infernal) -- Smoldering Infernal
	self:StopBar(234423) -- Drain Life
	self:StopBar(234428) -- Summon Tormenting Eye
end
