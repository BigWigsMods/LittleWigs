
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Odyn", 1477, 1489)
if not mod then return end
mod:RegisterEnableMob(95676)
mod.engageId = 1809
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip option to start the fight."

	L.gossip_available = "Gossip available"
	L.gossip_trigger = "Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand."

	L[197963] = "|cFF800080Top Right|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Purple
	L[197964] = "|cFFFFA500Bottom Right|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Orange
	L[197965] = "|cFFFFFF00Bottom Left|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Yellow
	L[197966] = "|cFF0000FFTop Left|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Blue
	L[197967] = "|cFF008000Top|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Green
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		"warmup",
		197961, -- Runic Brand
		198263, -- Radiant Tempest
		200988, -- Spear of Light
		198077, -- Shatter Spears
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "RunicBrand", 197961)
	self:Log("SPELL_AURA_APPLIED", "RunicBrandYou", 197963, 197964, 197965, 197966, 197967)
	self:Log("SPELL_CAST_START", "RadiantTempest", 198263)
	self:Log("SPELL_CAST_START", "ShatterSpears", 198077)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterMessage("BigWigs_BossComm")
end

function mod:OnEngage()
	self:Bar(198263, self:Mythic() and 8 or 24) -- Radiant Tempest
	self:Bar(198077, 40) -- Shatter Spears
	self:Bar(197961, 44) -- Runic Brand
end

function mod:VerifyEnable(unit)
	return UnitCanAttack("player", unit) or (UnitHealth(unit) / UnitHealthMax(unit) > 0.8)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.gossip_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 28.2, L.gossip_available, "achievement_boss_odyn")
	end
end

function mod:RunicBrand(args)
	self:MessageOld(args.spellId, "yellow", "alarm", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 56) -- m pull:44.0, 56.0
end

function mod:RunicBrandYou(args)
	if self:Me(args.destGUID) then
		self:MessageOld(197961, "orange", "warning", L[args.spellId], args.spellId)
	end
end

function mod:RadiantTempest(args)
	self:MessageOld(args.spellId, "red", "long")
	self:CDBar(args.spellId, self:Mythic() and 80 or 56) -- hc pull:24.0 / m pull:8.0, 80.0
end

function mod:ShatterSpears(args)
	self:MessageOld(args.spellId, "red", "alert", CL.incoming:format(args.spellName))
	self:Bar(args.spellId, 56) -- m pull:40.0, 56.0
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 198396 then -- Spear of Light
		self:MessageOld(200988, "orange", "alert")
	end
end

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 95676 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1, true) -- auto confirm it
			mod:Sync("odyn")
		end
	end
end

function mod:BigWigs_BossComm(_, msg)
	if msg == "odyn" then
		local name = self:BossName(1489) -- Odyn
		self:MessageOld("warmup", "cyan", "info", CL.incoming:format(name), false)
		self:CDBar("warmup", 2.7, name, "achievement_boss_odyn")
	end
end
