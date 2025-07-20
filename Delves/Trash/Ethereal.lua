if not BigWigsLoader.isNext then return end -- XXX remove in 11.2
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ethereal Trash", {2803}) -- Archival Assault -- TODO all delves?
if not mod then return end
mod:RegisterEnableMob(
	244966, -- Vaultwarden Falnora (Archival Assault gossip NPC)
	245067, -- Xeronia (Archival Assault gossip NPC)
	245291, -- Vaultwarden Gandrus (Archival Assault gossip NPC)
	245885, -- Spymaster Casnegosa (Archival Assault gossip NPC)
	244095, -- Failed Aspirant
	244099, -- Prowling Voidstalker
	244138, -- Shadeye Observer
	244101, -- Shadowguard Phasecutter
	244137, -- Shadowguard Arcanotech
	244113, -- Shadowguard Soulbreaker
	244111, -- Shadowguard Void Adept
	244115, -- Shadowguard Null Bastion
	244140, -- Shadowguard Steelsoul
	245098, -- Ethereal Commander
	245053 -- Siphoned Drake
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ethereal_trash = "Ethereal Trash"

	L.shadeye_observer = "Shadeye Observer"
	L.shadowguard_phasecutter = "Shadowguard Phasecutter"
	L.shadowguard_arcanotech = "Shadowguard Arcanotech"
	L.shadowguard_soulbreaker = "Shadowguard Soulbreaker"
	L.shadowguard_steelsoul = "Shadowguard Steelsoul"
	L.siphoned_drake = "Siphoned Drake"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.ethereal_trash
end

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Shadeye Observer
		{1236428, "NAMEPLATE"}, -- Behold!
		-- Shadowguard Phasecutter
		{1236256, "NAMEPLATE"}, -- Vorpal Cleave
		-- Shadowguard Arcanotech
		{1236229, "NAMEPLATE"}, -- Arcano Repulsor
		-- Shadowguard Soulbreaker
		{1236354, "NAMEPLATE"}, -- Soul Siphon
		-- Shadowguard Steelsoul
		{1236770, "NAMEPLATE"}, -- Arcane Geyser
		-- Siphoned Drake
		{1231144, "NAMEPLATE"}, -- Null Breath
	}, {
		[1236428] = L.shadeye_observer,
		[1236256] = L.shadowguard_phasecutter,
		[1236229] = L.shadowguard_arcanotech,
		[1236354] = L.shadowguard_soulbreaker,
		[1236770] = L.shadowguard_steelsoul,
		[1231144] = L.siphoned_drake,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Shadeye Observer
	self:RegisterEngageMob("ShadeyeObserverEngaged", 244138)
	self:Log("SPELL_CAST_SUCCESS", "Behold", 1236428)
	self:Death("ShadeyeObserverDeath", 244138)

	-- Shadowguard Phasecutter
	self:RegisterEngageMob("ShadowguardPhasecutterEngaged", 244101)
	self:Log("SPELL_CAST_START", "VorpalCleave", 1236256)
	self:Log("SPELL_CAST_SUCCESS", "VorpalCleaveSuccess", 1236256)
	self:Death("ShadowguardPhasecutterDeath", 244101)

	-- Shadowguard Arcanotech
	self:RegisterEngageMob("ShadowguardArcanotechEngaged", 244137)
	self:Log("SPELL_CAST_START", "ArcanoRepulsor", 1236229)
	self:Log("SPELL_CAST_SUCCESS", "ArcanoRepulsorSuccess", 1236229)
	self:Death("ShadowguardArcanotechDeath", 244137)

	-- Shadowguard Soulbreaker
	self:RegisterEngageMob("ShadowguardSoulbreakerEngaged", 244113)
	self:Log("SPELL_CAST_START", "SoulSiphon", 1236354)
	self:Log("SPELL_INTERRUPT", "SoulSiphonInterrupt", 1236354)
	self:Log("SPELL_CAST_SUCCESS", "SoulSiphonSuccess", 1236354)
	self:Death("ShadowguardSoulbreakerDeath", 244113)

	-- Shadowguard Steelsoul
	self:RegisterEngageMob("ShadowguardSteelsoulEngaged", 244140, 245098) -- Shadowguard Steelsoul, Ethereal Commander
	self:Log("SPELL_CAST_START", "ArcaneGeyser", 1236770)
	self:Death("ShadowguardSteelsoulDeath", 244140, 245098) -- Shadowguard Steelsoul, Ethereal Commander

	-- Siphoned Drake
	self:RegisterEngageMob("SiphonedDrakeEngaged", 245053)
	self:Log("SPELL_CAST_START", "NullBreath", 1231144)
	self:Log("SPELL_CAST_SUCCESS", "NullBreathSuccess", 1231144)
	self:Death("SiphonedDrakeDeath", 245053)

	-- TODO also enable Rares module depending on season
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(133907) then -- Archival Assault, start Delve (Vaultwarden Falnora)
			-- 133907:|cFF0000FF(Delve)|r I'll recover what I can.
			self:SelectGossipID(133907)
		elseif self:GetGossipID(134070) then -- Archival Assault, start Delve (Xeronia)
			-- 134070:|cFF0000FF(Delve)|r I will save them.
			self:SelectGossipID(134070)
		elseif self:GetGossipID(134016) then -- Archival Assault, start Delve (Vaultwarden Gandrus)
			-- 134016:Cause some damage and thin their numbers. On it!
			self:SelectGossipID(134016)
		elseif self:GetGossipID(134202) then -- Archival Assault, start Delve (Spymaster Casnegosa)
			-- 134202:Gather materials and rebuild the waygates. Got it!
			self:SelectGossipID(134202)
		elseif self:GetGossipID(134281) then -- Archival Assault, continue Delve (Spymaster Casnegosa)
			-- 134281:Destroy the Field Dampeners and reestablish the waygate network. Got it!
			self:SelectGossipID(134281)
		end
	end
end

-- Shadeye Observer

function mod:ShadeyeObserverEngaged(guid)
	self:Nameplate(1236428, 11.3, guid) -- Behold!
end

function mod:Behold(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 13.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ShadeyeObserverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Shadowguard Phasecutter

function mod:ShadowguardPhasecutterEngaged(guid)
	self:Nameplate(1236256, 7.1, guid) -- Vorpal Cleave
end

do
	local prev = 0
	function mod:VorpalCleave(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:VorpalCleaveSuccess(args)
	self:Nameplate(args.spellId, 13.2, args.sourceGUID)
end

function mod:ShadowguardPhasecutterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Shadowguard Arcanotech

function mod:ShadowguardArcanotechEngaged(guid)
	self:Nameplate(1236229, 4.7, guid) -- Arcano Repulsor
end

function mod:ArcanoRepulsor(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:ArcanoRepulsorSuccess(args)
	self:Nameplate(args.spellId, 13.4, args.sourceGUID)
end

function mod:ShadowguardArcanotechDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Shadowguard Soulbreaker

function mod:ShadowguardSoulbreakerEngaged(guid)
	self:Nameplate(1236354, 5.5, guid) -- Soul Siphon
end

function mod:SoulSiphon(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:SoulSiphonInterrupt(args)
	self:Nameplate(1236354, 12.5, args.destGUID)
end

function mod:SoulSiphonSuccess(args)
	self:Nameplate(args.spellId, 12.5, args.sourceGUID)
end

function mod:ShadowguardSoulbreakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Shadowguard Steelsoul

function mod:ShadowguardSteelsoulEngaged(guid)
	self:Nameplate(1236770, 2.5, guid) -- Arcane Geyser
end

function mod:ArcaneGeyser(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 21.9, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ShadowguardSteelsoulDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Siphoned Drake

function mod:SiphonedDrakeEngaged(guid)
	self:Nameplate(1231144, 8.2, guid) -- Null Breath
end

function mod:NullBreath(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:NullBreathSuccess(args)
	self:Nameplate(args.spellId, 20.5, args.sourceGUID)
end

function mod:SiphonedDrakeDeath(args)
	self:ClearNameplate(args.destGUID)
end
