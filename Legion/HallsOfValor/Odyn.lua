--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Odyn", 1477, 1489)
if not mod then return end
mod:RegisterEnableMob(95676) -- Odyn
mod:SetEncounterID(1809)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local spearOfLightCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
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

local autotalk = mod:AddAutoTalkOption(true, "boss")
function mod:GetOptions()
	return {
		"warmup",
		autotalk,
		197961, -- Runic Brand
		200988, -- Spear of Light
		198077, -- Shatter Spears
		198263, -- Radiant Tempest
		201215, -- Summon Stormforged Obliterator
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterMessage("BigWigs_BossComm")

	self:Log("SPELL_CAST_START", "RunicBrand", 197961)
	self:Log("SPELL_AURA_APPLIED", "RunicBrandApplied", 197963, 197964, 197965, 197966, 197967)
	self:Log("SPELL_CAST_START", "RadiantTempest", 198263)
	self:Log("SPELL_CAST_SUCCESS", "SpearOfLight", 198396)
	self:Log("SPELL_CAST_START", "ShatterSpears", 198077)
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Summon Stormforged Obliterator
end

function mod:OnEngage()
	spearOfLightCount = 1
	self:Bar(200988, 8, CL.count_amount:format(self:SpellName(200988), spearOfLightCount, 3)) -- Spear of Light
	self:Bar(198263, self:Normal() and 8 or 24) -- Radiant Tempest
	self:Bar(198077, 40) -- Shatter Spears
	self:Bar(197961, 44) -- Runic Brand
	if self:Heroic() or self:Mythic() then
		self:Bar(201215, 56) -- Summon Stormforged Obliterator
	end
end

function mod:VerifyEnable(unit)
	return UnitCanAttack("player", unit) or self:GetHealth(unit) > 80
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

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) and self:GetGossipID(44910) then
		self:SelectGossipID(44910, true) -- auto-confirm it
		self:Sync("odyn")
	end
end

do
	local prev = 0
	function mod:BigWigs_BossComm(_, msg)
		local t = GetTime()
		if msg == "odyn" and t - prev > 3 then
			prev = t
			local name = self:BossName(1489) -- Odyn
			self:Message("warmup", "cyan", CL.incoming:format(name), false)
			self:PlaySound("warmup", "info")
			self:Bar("warmup", 2.7, name, "achievement_boss_odyn")
		end
	end
end

function mod:RunicBrand(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 56) -- m pull:44.0, 56.0
end

function mod:RunicBrandApplied(args)
	if self:Me(args.destGUID) then
		self:Message(197961, "orange", L[args.spellId], args.spellId)
		self:PlaySound(197961, "warning")
	end
end

function mod:RadiantTempest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, self:Normal() and 80 or 56) -- normal pull:8.0 / heroic & mythic: pull:24.0, 56.0
end

function mod:SpearOfLight(args)
	self:StopBar(CL.count_amount:format(self:SpellName(200988), spearOfLightCount, 3))
	self:Message(200988, "orange", CL.count_amount:format(self:SpellName(200988), spearOfLightCount, 3))
	self:PlaySound(200988, "alert")
	spearOfLightCount = spearOfLightCount % 3 + 1
	if spearOfLightCount == 2 then
		self:Bar(200988, 8, CL.count_amount:format(self:SpellName(200988), spearOfLightCount, 3))
	elseif spearOfLightCount == 3 then
		self:Bar(200988, 20, CL.count_amount:format(self:SpellName(200988), spearOfLightCount, 3))
	elseif spearOfLightCount == 1 then
		self:Bar(200988, 28, CL.count_amount:format(self:SpellName(200988), spearOfLightCount, 3))
	end
end

function mod:ShatterSpears(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 56) -- m pull:40.0, 56.0
end

function mod:EncounterEvent(args) -- Summon Stormforged Obliterator
	self:Message(201215, "yellow")
	self:PlaySound(201215, "info")
	self:Bar(201215, 56)
end
