--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ethereal Trash", 2803) -- Archival Assault
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
	245053, -- Siphoned Drake
	247624 -- Steelsoul Arcanoward
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
	L.steelsoul_arcanoward = "Steelsoul Arcanoward"
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
		-- Steelsoul Arcanoward
		{1230608, "NAMEPLATE"}, -- Dazing Gauntlet
		{1231893, "NAMEPLATE"}, -- Crushing Stomp
		{1231919, "NAMEPLATE"}, -- Corespark Impale
	}, {
		[1236428] = L.shadeye_observer,
		[1236256] = L.shadowguard_phasecutter,
		[1236229] = L.shadowguard_arcanotech,
		[1236354] = L.shadowguard_soulbreaker,
		[1236770] = L.shadowguard_steelsoul,
		[1231144] = L.siphoned_drake,
		[1230608] = L.steelsoul_arcanoward,
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

	-- Steelsoul Arcanoward
	self:RegisterEngageMob("SteelsoulArcanowardEngaged", 247624)
	self:Log("SPELL_CAST_START", "DazingGauntlet", 1230608)
	self:Log("SPELL_CAST_SUCCESS", "DazingGauntletSuccess", 1230608)
	self:Log("SPELL_CAST_START", "CrushingStomp", 1231893)
	self:Log("SPELL_CAST_SUCCESS", "CoresparkImpale", 1231919)
	self:Death("SteelsoulArcanowardDeath", 247624)

	-- also enable the Rares module
	local raresModule = BigWigs:GetBossModule("Ky'veza Rares", true)
	if raresModule then
		raresModule:Enable()
	end
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
	self:Nameplate(1236256, 6.8, guid) -- Vorpal Cleave
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
	if self:MobId(args.sourceGUID) == 247624 then -- Steelsoul Arcanoward
		self:SteelsoulArcanowardArcaneGeyser(args.sourceGUID)
	else
		self:Nameplate(args.spellId, 21.9, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:ShadowguardSteelsoulDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Siphoned Drake

function mod:SiphonedDrakeEngaged(guid)
	self:Nameplate(1231144, 7.9, guid) -- Null Breath
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

-- Steelsoul Arcanoward

do
	local timer

	function mod:SteelsoulArcanowardEngaged(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(1236770, 3.6) -- Arcane Geyser
		self:Nameplate(1236770, 3.6, guid) -- Arcane Geyser
		self:CDBar(1230608, 6.0) -- Dazing Gauntlet
		self:Nameplate(1230608, 6.0, guid) -- Dazing Gauntlet
		self:CDBar(1231893, 8.4) -- Crushing Stomp
		self:Nameplate(1231893, 8.4, guid) -- Crushing Stomp
		self:CDBar(1231919, 15.7) -- Corespark Impale
		self:Nameplate(1231919, 15.7, guid) -- Corespark Impale
		timer = self:ScheduleTimer("SteelsoulArcanowardDeath", 20, nil, guid)
	end

	function mod:SteelsoulArcanowardArcaneGeyser(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(1236770, 24.3)
		self:Nameplate(1236770, 24.3, guid)
		timer = self:ScheduleTimer("SteelsoulArcanowardDeath", 20, nil, guid)
	end

	function mod:DazingGauntlet(args)
		self:Message(args.spellId, "purple")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:DazingGauntletSuccess(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 8.1)
		self:Nameplate(args.spellId, 8.1, args.sourceGUID)
		timer = self:ScheduleTimer("SteelsoulArcanowardDeath", 20, nil, args.sourceGUID)
	end

	function mod:CrushingStomp(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 20.2)
		self:Nameplate(args.spellId, 20.2, args.sourceGUID)
		timer = self:ScheduleTimer("SteelsoulArcanowardDeath", 20, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:CoresparkImpale(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 19.7)
		self:Nameplate(args.spellId, 19.7, args.sourceGUID)
		timer = self:ScheduleTimer("SteelsoulArcanowardDeath", 20, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:SteelsoulArcanowardDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1236770) -- Arcane Geyser
		self:StopBar(1230608) -- Dazing Gauntlet
		self:StopBar(1231893) -- Crushing Stomp
		self:StopBar(1231919) -- Corespark Impale
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end
