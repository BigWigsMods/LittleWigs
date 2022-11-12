--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Algeth'ar Academy Trash", 2526)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	196974, -- Black Dragonflight Recruiter
	196977, -- Bronze Dragonflight Recruiter
	196978, -- Blue Dragonflight Recruiter
	196979, -- Green Dragonflight Recruiter
	196981 -- Red Dragonflight Recruiter
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.recruiter_autotalk = "Autotalk"
	L.recruiter_autotalk_desc = "Instantly pledge to the Dragonflight Recruiters for a buff."
	L.critical_strike = "+5% Critical Strike"
	L.haste = "+5% Haste"
	L.mastery = "+Mastery"
	L.versatility = "+5% Versatility"
	L.healing_taken = "+10% Healing taken"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"recruiter_autotalk",
		389516, -- Black Dragonflight Pledge Pin
		389512, -- Bronze Dragonflight Pledge Pin
		389521, -- Blue Dragonflight Pledge Pin
		389536, -- Green Dragonflight Pledge Pin
		389501, -- Red Dragonflight Pledge Pin
	}, {
		["recruiter_autotalk"] = CL.general,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "BlackPledgeApplied", 389516)
	self:Log("SPELL_AURA_APPLIED", "BronzePledgeApplied", 389512)
	self:Log("SPELL_AURA_APPLIED", "BluePledgeApplied", 389521)
	self:Log("SPELL_AURA_APPLIED", "GreenPledgeApplied", 389536)
	self:Log("SPELL_AURA_APPLIED", "RedPledgeApplied", 389501)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Auto-gossip

function mod:GOSSIP_SHOW(event)
	if self:GetOption("recruiter_autotalk") then
		if self:GetGossipID(107065) then
			-- Black Dragonflight Recruiter (+Critical Strike)
			self:SelectGossipID(107065)
		elseif self:GetGossipID(107081) then
			-- Bronze Dragonflight Recruiter (+Haste)
			self:SelectGossipID(107081)
		elseif self:GetGossipID(107082) then
			-- Blue Dragonflight Recruiter (+Mastery)
			self:SelectGossipID(107082)
		elseif self:GetGossipID(107083) then
			-- Green Dragonflight Recruiter (+Healing Taken)
			self:SelectGossipID(107083)
		elseif self:GetGossipID(107088) then
			-- Red Dragonflight Recruiter (+Versatility)
			self:SelectGossipID(107088)
		end
	end
end

-- Dragonflight Pledge Pins

function mod:BlackPledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.critical_strike)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:BronzePledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.haste)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:BluePledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.mastery)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:GreenPledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.healing_taken)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:RedPledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.versatility)
		self:PlaySound(args.spellId, "info")
	end
end
