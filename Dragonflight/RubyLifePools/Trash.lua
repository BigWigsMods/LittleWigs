--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ruby Life Pools Trash", 2521)
if not mod then return end
mod:SetTrashModule(true)
mod:RegisterEnableMob(
	188244, -- Primal Juggernaut
	187969, -- Deepstone Earthshaper / Flashfrost Earthshaper
	188067, -- Flashfrost Chillweaver
	187897, -- Defier Draghar
	190206, -- Ashseer Flamelasher / Primalist Flamedancer
	190034, -- Blazebound Destroyer
	195119, -- Primalist Shockcaster
	197698, -- Thunderhead
	197697, -- Flamegullet
	198047, -- Tempest Channeler
	197985, -- Flame Channeler
	197535  -- High Channeler Ryvati
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	primal_juggernaut = "Primal Juggernaut",
	flashfrost_earthshaper = "Flashfrost Earthshaper",
	flashfrost_chillweaver = "Flashfrost Chillweaver",
	defier_draghar = "Defier Draghar",
	primalist_flamedancer = "Primalist Flamedancer",
	blazebound_destroyer = "Blazebound Destroyer",
	primalist_shockcaster = "Primalist Shockcaster",
	thunderhead = "Thunderhead",
	flamegullet = "Flamegullet",
	tempest_channeler = "Tempest Channeler",
	flame_channeler = "Flame Channeler",
	high_channeler_ryvati = "High Channeler Ryvati",

	kyrakka_and_erkhart_warmup_trigger = "Your false queen cannot stop us. We are the truth.",
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Primal Juggernaut
		372696, -- Excavating Blast
		-- Flashfrost Earthshaper
		372735, -- Tectonic Slam
		-- Flashfrost Chillweaver
		372743, -- Ice Shield
		-- Defier Draghar
		372087, -- Blazing Rush
		372047, -- Steel Barrage
		-- Primalist Flamedancer
		385536, -- Flame Dance
		373972, -- Blaze of Glory
		-- Blazebound Destroyer
		{373693, "SAY", "SAY_COUNTDOWN"}, -- Living Bomb
		373692, -- Inferno
		373614, -- Burnout
		-- Primalist Shockcaster
		{385313, "DISPEL"}, -- Unlucky Strike
		-- Thunderhead
		392640, -- Rolling Thunder
		391726, -- Storm Breath
		{392395, "TANK_HEALER"}, -- Thunder Jaw
		-- Flamegullet
		391723, -- Flame Breath
		392569, -- Molten Blood
		{392394, "TANK_HEALER"}, -- Fire Maw
		-- Tempest Channeler
		392486, -- Lightning Storm
		-- Flame Channeler
		392451, -- Flashfire
		-- High Channeler Ryvati
		391050, -- Tempest Stormshield
	}, {
		[372696] = L.primal_juggernaut,
		[372735] = L.flashfrost_earthshaper,
		[372743] = L.flashfrost_chillweaver,
		[372087] = L.defier_draghar,
		[385536] = L.primalist_flamedancer,
		[373693] = L.blazebound_destroyer,
		[385313] = L.primalist_shockcaster,
		[392640] = L.thunderhead,
		[391723] = L.flamegullet,
		[392486] = L.tempest_channeler,
		[392451] = L.flame_channeler,
		[391050] = L.high_channeler_ryvati,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Primal Juggernaut
	self:Log("SPELL_CAST_START", "ExcavatingBlast", 372696)

	-- Flashfrost Earthshaper
	self:Log("SPELL_CAST_START", "TectonicSlam", 372735)

	-- Flashfrost Chillweaver
	self:Log("SPELL_CAST_SUCCESS", "IceShield", 372743)

	-- Defier Draghar
	self:Log("SPELL_CAST_START", "BlazingRush", 372087)
	self:Log("SPELL_CAST_START", "SteelBarrage", 372047)
	self:Death("DefierDragharDeath", 187897)

	-- Primalist Flamedancer
	self:Log("SPELL_CAST_SUCCESS", "FlameDance", 385536)
	self:Log("SPELL_AURA_APPLIED", "BlazeOfGloryApplied", 373972)

	-- Blazebound Destroyer
	self:Log("SPELL_AURA_APPLIED", "LivingBombApplied", 373693)
	self:Log("SPELL_AURA_REMOVED", "LivingBombRemoved", 373693)
	self:Log("SPELL_CAST_START", "Inferno", 373692)
	self:Log("SPELL_CAST_START", "Burnout", 373614)

	-- Primalist Shockcaster
	self:Log("SPELL_AURA_APPLIED", "UnluckyStrikeApplied", 385313)

	-- Thunderhead
	self:Log("SPELL_CAST_START", "RollingThunder", 392640)
	self:Log("SPELL_AURA_APPLIED", "RollingThunderApplied", 392641)
	self:Log("SPELL_CAST_START", "StormBreath", 391726)
	self:Log("SPELL_CAST_START", "ThunderJaw", 392395)
	self:Death("ThunderheadDeath", 197698)

	-- Flamegullet
	self:Log("SPELL_CAST_START", "FlameBreath", 391723)
	self:Log("SPELL_CAST_START", "FireMaw", 392394)
	self:Log("SPELL_AURA_APPLIED", "MoltenBlood", 392569)
	self:Death("FlamegulletDeath", 197697)

	-- Tempest Channeler
	self:Log("SPELL_CAST_START", "LightningStorm", 392486)

	-- Flame Channeler
	self:Log("SPELL_CAST_START", "Flashfire", 392451)

	-- High Channeler Ryvati
	self:Log("SPELL_CAST_START", "TempestStormshield", 391050)
end

--------------------------------------------------------------------------------
-- Midnight Auras
--

if mod:Retail() then -- Midnight+
	mod:SetAuraData({
		{1305201, header = 188244, tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(1305201))}, -- Excavating Blast (Primal Juggernaut)
		{1307205, header = 188011, tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1307205))}, -- Earthbound's Imprint (Earthbound Guardian)
		{1305225, header = 187969, soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1305225))}, -- Tectonic Strike (Deepstone Earthshaper)
		{1305234, header = 187894, dispel = "magic", mechanic = "snared", soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1305234))}, -- Cold Claws (Infused Whelp)
		{373593, mechanic = "stunned", tip = CL.debuffFailureNote}, -- Frozen Solid (Infused Whelp)
		{372047, header = 187897, tip = CL.debuffTankAfterCastNote:format(mod:SpellName(372047))}, -- Steel Barrage (Defier Draghar)
		{374927, header = mod:SpellName(374927), soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Wall of Flames (environmental)
		{373693, header = 190207, tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(373693))}, -- Living Bomb (Primalist Cinderweaver)
		{385536, header = 190206, tip = CL.debuffTankAfterCastNote:format(mod:SpellName(385536))}, -- Flaming Barrage (Ashseer Flamelasher)
		{373692, header = 190034, tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(373692))}, -- Inferno (Blazebound Destroyer)
		{395292, header = 197697, tip = CL.debuffTankAfterCastNote:format(mod:SpellName(395292))}, -- Fire Maw (Flamegullet)
		{392641, header = 197698, dispel = "magic", soundOnAppliedDose = "none", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(392641))}, -- Rolling Thunder (Thunderhead)
		{1310599, soundOnAppliedDose = "none", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1310599))}, -- Electrical Discharge (Thunderhead)
		{1307372, header = 190205, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Fiery Demise (Scorchling)
		{1306366, header = 198047, tip = CL.debuffTargetedNote:format(mod:SpellName(1306366))}, -- Lightning Torrent (Tempest Channeler)
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
		}
	end

	function mod:OnBossEnable()
		-- Warmups
		self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if not self:IsSecret(msg) and msg == L.kyrakka_and_erkhart_warmup_trigger then
		-- Kyrakka and Erkhart Stormvein warmup
		local kyrakkaAndErkhartModule = BigWigs:GetBossModule("Kyrakka and Erkhart Stormvein", true)
		if kyrakkaAndErkhartModule then
			kyrakkaAndErkhartModule:Enable()
			kyrakkaAndErkhartModule:Warmup()
			-- don't unregister the event, because if the boss respawns this will happen again
		end
	end
end

-- Primal Juggernaut

function mod:ExcavatingBlast(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Flashfrost Earthshaper

function mod:TectonicSlam(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Flashfrost Chillweaver

do
	local prev = 0
	function mod:IceShield(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Defier Draghar

do
	local timer

	function mod:BlazingRush(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("DefierDragharDeath", 30)
	end

	function mod:SteelBarrage(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("DefierDragharDeath", 30)
	end

	function mod:DefierDragharDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(372087) -- Blazing Rush
		self:StopBar(372047) -- Steel Barrage
	end
end

-- Primalist Flamedancer

function mod:FlameDance(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:BlazeOfGloryApplied(args)
	if not self:Player(args.destFlags) then
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "info")
	end
end

-- Blazebound Destroyer

function mod:LivingBombApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Living Bomb")
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:LivingBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:Inferno(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:Burnout(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Primalist Shockcaster

function mod:UnluckyStrikeApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Thunderhead

do
	-- this timer is used to schedule StopBars on abilities, this way if you pull and
	-- reset the mob (or wipe) the bars won't be stuck for the rest of the dungeon.
	local timer

	do
		local playerList = {}

		function mod:RollingThunder(args)
			if timer then
				self:CancelTimer(timer)
			end
			playerList = {}
			self:CDBar(args.spellId, 22)
			timer = self:ScheduleTimer("ThunderheadDeath", 30)
		end

		function mod:RollingThunderApplied(args)
			playerList[#playerList+1] = args.destName
			self:TargetsMessage(392640, "red", playerList, 2)
			self:PlaySound(392640, "alert", nil, playerList)
		end
	end

	function mod:StormBreath(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 14.5)
		timer = self:ScheduleTimer("ThunderheadDeath", 30)
	end

	function mod:ThunderJaw(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 19.3)
		timer = self:ScheduleTimer("ThunderheadDeath", 30)
	end

	function mod:ThunderheadDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(392640) -- Rolling Thunder
		self:StopBar(391726) -- Storm Breath
		self:StopBar(392395) -- Thunder Jaw
	end
end

-- Flamegullet

do
	-- this timer is used to schedule StopBars on abilities, this way if you pull and
	-- reset the mob (or wipe) the bars won't be stuck for the rest of the dungeon.
	local timer

	function mod:FlameBreath(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 14.5)
		timer = self:ScheduleTimer("FlamegulletDeath", 30)
	end

	function mod:FireMaw(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 23.0)
		timer = self:ScheduleTimer("FlamegulletDeath", 30)
	end

	function mod:MoltenBlood(args)
		self:Message(args.spellId, "red", CL.percent:format(50, args.spellName))
		self:PlaySound(args.spellId, "long")
	end

	function mod:FlamegulletDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(391723) -- Flame Breath
		self:StopBar(392394) -- Fire Maw
	end
end

-- Tempest Channeler

function mod:LightningStorm(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Flame Channeler

function mod:Flashfire(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- High Channeler Ryvati

function mod:TempestStormshield(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
