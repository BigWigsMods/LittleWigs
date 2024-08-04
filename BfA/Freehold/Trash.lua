--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Freehold Trash", 1754)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	129743, -- Sharkbait
	129602, -- Irontide Enforcer
	129788, -- Irontide Bonesaw
	126918, -- Irontide Crackshot
	126928, -- Irontide Corsair
	129559, -- Cutwater Duelist
	127111, -- Irontide Oarsman
	129599, -- Cutwater Knife Juggler
	129600, -- Bilge Rat Brinescale
	129529, -- Blacktooth Scrapper
	129547, -- Blacktooth Knuckleduster
	129526, -- Bilge Rat Swabby
	130404, -- Vermin Trapper
	129527, -- Bilge Rat Buccaneer
	129550, -- Bilge Rat Padfoot
	130024, -- Soggy Shiprat
	130400, -- Irontide Crusher
	130011, -- Irontide Buccaneer
	130012, -- Irontide Ravager
	127106, -- Irontide Officer
	126919  -- Irontide Stormcaller
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sharkbait = "Sharkbait"
	L.irontide_enforcer = "Irontide Enforcer"
	L.irontide_bonesaw = "Irontide Bonesaw"
	L.irontide_crackshot = "Irontide Crackshot"
	L.irontide_corsair = "Irontide Corsair"
	L.cutwater_duelist = "Cutwater Duelist"
	L.irontide_oarsman = "Irontide Oarsman"
	L.cutwater_knife_juggler = "Cutwater Knife Juggler"
	L.bilge_rat_brinescale = "Bilge Rat Brinescale"
	L.blacktooth_scrapper = "Blacktooth Scrapper"
	L.blacktooth_knuckleduster = "Blacktooth Knuckleduster"
	L.bilge_rat_swabby = "Bilge Rat Swabby"
	L.vermin_trapper = "Vermin Trapper"
	L.bilge_rat_buccaneer = "Bilge Rat Buccaneer"
	L.bilge_rat_padfoot = "Bilge Rat Padfoot"
	L.soggy_shiprat = "Soggy Shiprat"
	L.irontide_crusher = "Irontide Crusher"
	L.irontide_buccaneer = "Irontide Buccaneer"
	L.irontide_ravager = "Irontide Ravager"
	L.irontide_officer = "Irontide Officer"
	L.irontide_stormcaller = "Irontide Stormcaller"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Sharkbait
		257272, -- Vile Bombardment
		-- Irontide Enforcer
		257426, -- Brutal Backhand
		-- Irontide Bonesaw
		257397, -- Healing Balm
		{258323, "DISPEL"}, -- Infected Wound
		-- Irontide Crackshot
		258672, -- Azerite Grenade
		-- Irontide Corsair
		257436, -- Poisoning Strike
		-- Cutwater Duelist
		274400, -- Duelist Dash
		--Irontide Oarsman
		258777, -- Sea Spout
		-- Cutwater Knife Juggler
		{272402, "SAY"}, -- Ricocheting Throw
		-- Bilge Rat Brinescale
		257784, -- Frost Blast
		-- Blacktooth Scrapper
		257739, -- Blind Rage
		-- Blacktooth Knuckleduster
		257732, -- Shattering Bellow
		-- Bilge Rat Swabby
		274507, -- Slippery Suds
		-- Vermin Trapper
		{274383, "DISPEL"}, -- Rat Traps
		-- Bilge Rat Buccaneer
		257756, -- Goin' Bananas
		-- Bilge Rat Padfoot
		{257775, "DISPEL"}, -- Plague Step
		-- Soggy Shiprat
		274555, -- Scabrous Bite
		-- Irontide Crusher
		258181, -- Boulder Throw
		258199, -- Ground Shatter
		-- Irontide Buccaneer
		257870, -- Blade Barrage
		-- Irontide Ravager
		{257899, "DISPEL"}, -- Painful Motivation
		-- Irontide Officer
		{257908, "DISPEL"}, -- Oiled Blade
		-- Irontide Stormcaller
		257736, -- Thundering Squall
	}, {
		[257272] = L.sharkbait,
		[257426] = L.irontide_enforcer,
		[257397] = L.irontide_bonesaw,
		[258672] = L.irontide_crackshot,
		[257436] = L.irontide_corsair,
		[274400] = L.cutwater_duelist,
		[258777] = L.irontide_oarsman,
		[272402] = L.cutwater_knife_juggler,
		[257784] = L.bilge_rat_brinescale,
		[257739] = L.blacktooth_scrapper,
		[257732] = L.blacktooth_knuckleduster,
		[274507] = L.bilge_rat_swabby,
		[274383] = L.vermin_trapper,
		[257756] = L.bilge_rat_buccaneer,
		[257775] = L.bilge_rat_padfoot,
		[274555] = L.soggy_shiprat,
		[258181] = L.irontide_crusher,
		[257870] = L.irontide_buccaneer,
		[257899] = L.irontide_ravager,
		[257908] = L.irontide_officer,
		[257736] = L.irontide_stormcaller,
	}, {
		[257739] = CL.fixate, -- Blind Rage (Fixate)
	}
end

function mod:OnBossEnable()
	-- Sharkbait
	self:Log("SPELL_CAST_SUCCESS", "VileBombardment", 257272)
	self:Log("SPELL_AURA_APPLIED", "VileCoating", 257274)
	self:Log("SPELL_PERIODIC_DAMAGE", "VileCoating", 257274)
	self:Log("SPELL_PERIODIC_MISSED", "VileCoating", 257274)
	-- Irontide Enforcer
	self:Log("SPELL_CAST_START", "BrutalBackhand", 257426)
	-- Irontide Bonesaw
	self:Log("SPELL_CAST_START", "HealingBalm", 257397)
	self:Log("SPELL_AURA_APPLIED", "HealingBalmApplied", 257397)
	self:Log("SPELL_AURA_APPLIED", "InfectedWoundApplied", 258323)
	self:Log("SPELL_AURA_APPLIED_DOSE", "InfectedWoundApplied", 258323)
	-- Irontide Crackshot
	self:Log("SPELL_CAST_START", "AzeriteGrenade", 258672)
	-- Irontide Corsair
	self:Log("SPELL_AURA_APPLIED", "PoisoningStrikeApplied", 257437)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PoisoningStrikeApplied", 257437)
	-- Cutwater Duelist
	self:Log("SPELL_CAST_START", "DuelistDash", 274400)
	-- Irontide Oarsman
	self:Log("SPELL_CAST_SUCCESS", "SeaSpoutSuccess", 258777)
	-- Cutwater Knife Juggler
	self:Log("SPELL_CAST_START", "RicochetingThrow", 272402)
	-- Bilge Rat Brinescale
	self:Log("SPELL_CAST_START", "FrostBlast", 257784)
	-- Blacktooth Scrapper
	self:Log("SPELL_AURA_APPLIED", "BlindRageApplied", 257739)
	-- Blacktooth Knuckleduster
	self:Log("SPELL_CAST_START", "ShatteringBellow", 257732)
	-- Bilge Rat Swabby
	self:Log("SPELL_CAST_START", "SlipperySuds", 274507)
	self:Log("SPELL_AURA_APPLIED", "SlipperySudsApplied", 274507)
	-- Vermin Trapper
	self:Log("SPELL_CAST_SUCCESS", "RatTraps", 274383)
	self:Log("SPELL_AURA_APPLIED", "RatTrapsApplied", 274389)
	-- Bilge Rat Buccaneer
	self:Log("SPELL_CAST_START", "GoinBananas", 257756)
	-- Bilge Rat Padfoot
	self:Log("SPELL_AURA_APPLIED", "PlagueStepApplied", 257775)
	-- Soggy Shiprat
	self:Log("SPELL_AURA_APPLIED", "ScabrousBiteApplied", 274555)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ScabrousBiteApplied", 274555)
	-- Irontide Crusher
	self:Log("SPELL_CAST_START", "BoulderThrow", 258181)
	self:Log("SPELL_CAST_START", "GroundShatter", 258199)
	-- Irontide Buccaneer
	self:Log("SPELL_CAST_START", "BladeBarrage", 257870)
	-- Irontide Ravager
	self:Log("SPELL_CAST_START", "PainfulMotivation", 257899)
	self:Log("SPELL_AURA_APPLIED", "PainfulMotivationApplied", 257899)
	-- Irontide Officer
	self:Log("SPELL_CAST_START", "OiledBlade", 257908)
	self:Log("SPELL_AURA_APPLIED", "OiledBladeApplied", 257908)
	-- Irontide Stormcaller
	self:Log("SPELL_CAST_START", "ThunderingSquall", 257736)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Sharkbait

function mod:VileBombardment(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 16.0)
end

do
	local prev = 0
	function mod:VileCoating(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(257272, "underyou")
				self:PlaySound(257272, "underyou", "gtfo")
			end
		end
	end
end

-- Irontide Enforcer

function mod:BrutalBackhand(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

-- Irontide Bonesaw

function mod:HealingBalm(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	--self:Nameplate(args.spellId, 25.5, args.sourceGUID)
end

function mod:HealingBalmApplied(args)
	-- filter out Spellsteal
	if not self:Player(args.destFlags) and self:Dispeller("magic", true) then
		self:Message(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local prev = 0
	function mod:InfectedWoundApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:StackMessage(args.spellId, "yellow", args.destName, args.amount, 1)
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

-- Irontide Crackshot

function mod:AzeriteGrenade(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 23.0, args.sourceGUID)
end

-- Irontide Corsair

function mod:PoisoningStrikeApplied(args)
	if self:Me(args.destGUID) then
		self:StackMessage(257436, "blue", args.destName, args.amount, 1)
		self:PlaySound(257436, "alert", nil, args.destName)
	end
end

-- Cutwater Duelist

function mod:DuelistDash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 17.0, args.sourceGUID)
end

-- Irontide Oarsman

function mod:SeaSpoutSuccess(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 17.0, args.sourceGUID)
end

-- Cutwater Knife Juggler

do
	local prev = 0
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:Say(272402, nil, nil, "Ricocheting Throw")
				self:TargetMessage(272402, "blue", name)
				self:PlaySound(272402, "alert", nil, name)
			end
		else
			self:TargetMessage(272402, "orange", name)
			self:PlaySound(272402, "alert", nil, name)
		end
	end

	function mod:RicochetingThrow(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		--self:Nameplate(args.spellId, 8.5, args.sourceGUID)
	end
end

-- Bilge Rat Brinescale

do
	local prev = 0
	function mod:FrostBlast(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
		--self:Nameplate(args.spellId, 27.9, args.sourceGUID)
	end
end

-- Blacktooth Scrapper

do
	local prev = 0
	function mod:BlindRageApplied(args)
		if not self:Tank() and self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, nil, CL.fixate)
				self:PlaySound(args.spellId, "warning")
			end
		end
		--self:Nameplate(args.spellId, 30.3, args.sourceGUID)
	end
end

-- Blacktooth Knuckleduster

function mod:ShatteringBellow(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 27.9, args.sourceGUID)
end

-- Bilge Rat Swabby

do
	local prev = 0
	function mod:SlipperySuds(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
		--self:Nameplate(args.spellId, 20.7, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:SlipperySudsApplied(args)
		local t = args.time
		if self:Me(args.destGUID) and t - prev > 2 then
			prev = t
			self:PersonalMessage(args.spellId)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Vermin Trapper

function mod:RatTraps(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 20.6, args.sourceGUID)
end

function mod:RatTrapsApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("movement", nil, 274383) then
		self:TargetMessage(274383, "yellow", args.destName)
		self:PlaySound(274383, "info", nil, args.destName)
	end
end

-- Bilge Rat Buccaneer

function mod:GoinBananas(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 17.0, args.sourceGUID)
end

-- Bilge Rat Padfoot

function mod:PlagueStepApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	-- if nameplate CD bars are uncommented, this should move to SUCCESS
	--self:Nameplate(args.spellId, 20.6, args.sourceGUID)
end

-- Soggy Shiprat

do
	local prev = 0
	function mod:ScabrousBiteApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				local amount = args.amount or 1
				self:StackMessage(args.spellId, "blue", args.destName, amount, 3)
				if amount >= 5 then
					self:PlaySound(args.spellId, "warning", nil, args.destName)
				else
					self:PlaySound(args.spellId, "alert", nil, args.destName)
				end
			end
		end
	end
end

-- Irontide Crusher

function mod:BoulderThrow(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 19.4, args.sourceGUID)
end

function mod:GroundShatter(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 19.4, args.sourceGUID)
end

-- Irontide Buccaneer

do
	local prev = 0
	function mod:BladeBarrage(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

-- Irontide Ravager

do
	local prev = 0
	function mod:PainfulMotivation(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		--self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:PainfulMotivationApplied(args)
		if self:Dispeller("enrage", true, args.spellId) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:Message(args.spellId, "red", CL.other:format(args.spellName, args.destName))
				self:PlaySound(args.spellId, "info")
			end
		end
	end
end

-- Irontide Officer

function mod:OiledBlade(args)
	if self:Tank() then
		-- alerting on cast start because this can be spell reflected
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
	--self:Nameplate(args.spellId, 13.3, args.sourceGUID)
end

function mod:OiledBladeApplied(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

-- Irontide Stormcaller

do
	local prev = 0
	function mod:ThunderingSquall(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
		--self:Nameplate(args.spellId, 21.8, args.sourceGUID)
	end
end
