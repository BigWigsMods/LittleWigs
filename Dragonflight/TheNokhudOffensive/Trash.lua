--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Nokhud Offensive Trash", 2516)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	191847, -- Nokhud Plainstomper
	192800, -- Nokhud Lancemaster
	192796, -- Nokhud Hornsounder
	194896, -- Primal Stormshield
	195927, -- Soulharvester Galtmaa
	195928, -- Soulharvester Duuren
	195929, -- Soulharvester Tumen
	195930, -- Soulharvester Mandakh
	199717, -- Nokhud Defender
	193373, -- Nokhud Thunderfist
	193462  -- Batak
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nokhud_plainstomper = "Nokhud Plainstomper"
	L.nokhud_hornsounder = "Nokhud Hornsounder"
	L.primal_stormshield = "Primal Stormshield"
	L.soulharvester_galtmaa = "Soulharvester Galtmaa"
	L.nokhud_defender = "Nokhud Defender"
	L.nokhud_thunderfist = "Nokhud Thunderfist"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Nokhud Plainstomper
		384365, -- Disruptive Shout
		384336, -- War Stomp
		-- Nokhud Hornsounder
		383823, -- Rally the Clan
		-- Primal Stormshield
		{386223, "DISPEL"}, -- Stormshield
		-- Soulharvester Galtmaa
		395035, -- Shatter Soul
		387411, -- Death Bolt Volley
		-- Nokhud Defender
		373395, -- Bloodcurdling Shout
		-- Nokhud Thunderfist
		397394, -- Deadly Thunder
	}, {
		[384365] = L.nokhud_plainstomper,
		[383823] = L.nokhud_hornsounder,
		[386223] = L.primal_stormshield,
		[395035] = L.soulharvester_galtmaa,
		[373395] = L.nokhud_defender,
		[397394] = L.nokhud_thunderfist,
	}
end

function mod:OnBossEnable()
	-- Nokhud Plainstomper
	self:Log("SPELL_CAST_START", "DisruptiveShout", 384365)
	self:Log("SPELL_CAST_START", "WarStomp", 384336)

	-- Nokhud Hornsounder
	self:Log("SPELL_CAST_START", "RallyTheClan", 383823)

	-- Primal Stormshield
	self:Log("SPELL_AURA_APPLIED", "StormshieldApplied", 386223)

	-- Soulharvester Galtmaa
	self:Log("SPELL_AURA_APPLIED", "ShatterSoulApplied", 395035)
	self:Log("SPELL_CAST_START", "DeathBoltVolley", 387411)

	-- Nokhud Defender
	self:Log("SPELL_CAST_START", "BloodcurdlingShout", 373395)

	-- Nokhud Thunderfist
	self:Log("SPELL_CAST_START", "DeadlyThunder", 397394)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Nokhud Plainstomper

function mod:DisruptiveShout(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:WarStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Nokhud Hornsounder

function mod:RallyTheClan(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Primal Stormshield

function mod:StormshieldApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Soulharvester Galtmaa

function mod:ShatterSoulApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "blue", args.destName)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:DeathBoltVolley(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

-- Nokhud Defender

function mod:BloodcurdlingShout(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

-- Nokhud Thunderfist

function mod:DeadlyThunder(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end
