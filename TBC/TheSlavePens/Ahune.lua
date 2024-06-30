--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ahune", 547)
if not mod then return end
mod:RegisterEnableMob(
	40446, -- Skar'this the Summoner
	25740, -- Ahune
	25865, -- Frozen Core
	25697 -- Luma Skymother
)
mod:SetStage(1)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ahune = "Ahune"
	L.warmup_trigger = "The Ice Stone has melted!"
	L.warmup_icon = "spell_frost_summonwaterelemental"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.ahune
end

local autotalk = mod:AddAutoTalkOption(true, "boss")
function mod:GetOptions()
	return {
		autotalk,
		"warmup",
		45954, -- Ahune's Shield
	}, nil, {
		[45954] = CL.shield, -- Ahune's Shield (Shield)
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:Log("SPELL_AURA_APPLIED", "AhunesShieldApplied", 45954)
	self:Log("SPELL_AURA_REMOVED", "AhunesShieldRemoved", 45954)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 25740)
end

function mod:OnEngage()
	self:StopBar(CL.active)
	self:SetStage(1)
	-- Ahune's Shield is cast on pull
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) and self:GetGossipID(36888) then
		-- 36888:Disturb the stone and summon Lord Ahune.
		self:SelectGossipID(36888)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Message("warmup", "cyan", CL.spawning:format(self.displayName), L.warmup_icon)
		self:PlaySound("warmup", "info")
		self:Bar("warmup", 8.1, CL.active, L.warmup_icon)
	end
end

do
	local prev = 0
	function mod:AhunesShieldApplied(args)
		-- can be double cast, ignore the second cast
		local t = args.time
		if t - prev > 5 then
			prev = t
			self:StopBar(CL.removed:format(CL.shield))
			self:SetStage(1)
			self:Message(args.spellId, "red", CL.onboss:format(CL.shield))
			self:PlaySound(args.spellId, "long")
			self:Bar(args.spellId, 95.1, CL.onboss:format(CL.shield))
		end
	end
end

function mod:AhunesShieldRemoved(args)
	self:StopBar(CL.onboss:format(CL.shield))
	self:SetStage(2)
	self:Message(args.spellId, "green", CL.removed:format(CL.shield))
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 40.8, CL.removed:format(CL.shield))
end
