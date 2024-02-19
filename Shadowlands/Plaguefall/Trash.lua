--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Plaguefall Trash", 2289)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	168580, -- Plagueborer
	168579, -- Fen Hatchling
	168361, -- Fen Hornet
	163882, -- Decaying Flesh Giant
	168153, -- Plagueroc
	168393, -- Plaguebelcher
	168396, -- Plaguebelcher
	163892, -- Rotting Slimeclaw
	163894, -- Blighted Spinebreaker
	168627, -- Plaguebinder
	164707, -- Congealed Slime
	168022, -- Slime Tentacle
	168907, -- Slime Tentacle (CC immune version)
	163862, -- Defender of Many Eyes
	167493, -- Venomous Sniper
	164737, -- Brood Ambusher
	169861, -- Ickor Bileflesh
	168578, -- Fungalmancer
	168574, -- Pestilent Harvester
	168572 -- Fungi Stormer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.plagueborer = "Plagueborer"
	L.fen_hatchling = "Fen Hatchling"
	L.fen_hornet = "Fen Hornet"
	L.decaying_flesh_giant = "Decaying Flesh Giant"
	L.plagueroc = "Plagueroc"
	L.plaguebelcher = "Plaguebelcher"
	L.rotting_slimeclaw = "Rotting Slimeclaw"
	L.blighted_spinebreaker = "Blighted Spinebreaker"
	L.plaguebinder = "Plaguebinder"
	L.congealed_slime = "Congealed Slime"
	L.slime_tentacle = "Slime Tentacle"
	L.defender_of_many_eyes = "Defender of Many Eyes"
	L.venomous_sniper = "Venomous Sniper"
	L.brood_ambusher = "Brood Ambusher"
	L.ickor_bileflesh = "Ickor Bileflesh"
	L.fungalmancer = "Fungalmancer"
	L.pestilent_harvester = "Pestilent Harvester"
	L.fungi_stormer = "Fungi Stormer"

	L.summon_stealthlings = 328400
	L.summon_stealthlings_desc = "Show a warning when the Stealthlings spawn."
	L.summon_stealthlings_icon = 328400
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Environment
		330069, -- Concentrated Plague
		330092, -- Plaguefallen
		-- Plagueborer
		323572, -- Rolling Plague
		-- Fen Hatchling
		335882, -- Clinging Infestation
		-- Fen Hornet
		{327515, "DISPEL"}, -- Fen Stinger
		-- Decaying Flesh Giant
		329239, -- Creepy Crawlers
		-- Plagueroc
		330403, -- Wing Buffet
		{327882, "DISPEL"}, -- Blightbeak
		-- Plaguebelcher
		327233, -- Belch Plague
		327584, -- Beckon Slime
		-- Rotting Slimeclaw
		{320512, "DISPEL"}, -- Corroded Claws
		-- Blighted Spinebreaker
		318949, -- Festering Belch
		320517, -- Jagged Spines
		-- Plaguebinder
		{328180, "DISPEL"}, -- Gripping Infection
		-- Congealed Slime
		321935, -- Withering Filth
		-- Slime Tentacle
		{328429, "SAY"}, -- Crushing Embrace
		319898, -- Vile Spit
		-- Defender of Many Eyes
		336451, -- Bulwark of Maldraxxus
		-- Venomous Sniper
		328338, -- Call Venomfang
		-- Brood Ambusher
		328475, -- Enveloping Webbing
		"summon_stealthlings", -- Stealthlings
		-- Ickor Bileflesh
		330786, -- Oozing Carcass
		330816, -- Ghost Step
		-- Fungalmancer
		328016, -- Wonder Grow
		-- Pestilent Harvester
		327995, -- Doom Shroom
		-- Fungi Stormer
		328177, -- Fungistorm
	}, {
		[330069] = CL.general,
		[323572] = L.plagueborer,
		[335882] = L.fen_hatchling,
		[327515] = L.fen_hornet,
		[329239] = L.decaying_flesh_giant,
		[330403] = L.plagueroc,
		[327233] = L.plaguebelcher,
		[320512] = L.rotting_slimeclaw,
		[318949] = L.blighted_spinebreaker,
		[328180] = L.plaguebinder,
		[321935] = L.congealed_slime,
		[328429] = L.slime_tentacle,
		[336451] = L.defender_of_many_eyes,
		[328338] = L.venomous_sniper,
		[328475] = L.brood_ambusher,
		[330786] = L.ickor_bileflesh,
		[328016] = L.fungalmancer,
		[327995] = L.pestilent_harvester,
		[328177] = L.fungi_stormer,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "ConcentratedPlagueApplied", 330069)
	self:Log("SPELL_AURA_APPLIED", "PlaguefallenApplied", 330092)
	self:Log("SPELL_AURA_REMOVED", "PlaguefallenRemoved", 330092)
	self:Log("SPELL_CAST_START", "RollingPlague", 323572)
	self:Log("SPELL_AURA_APPLIED", "ClingingInfestationApplied", 335882)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ClingingInfestationApplied", 335882)
	self:Log("SPELL_PERIODIC_DAMAGE", "ClingingInfestationDamage", 335882)
	self:Log("SPELL_AURA_REMOVED", "ClingingInfestationRemoved", 335882)
	self:Log("SPELL_AURA_APPLIED", "FenStingerApplied", 327515)
	self:Log("SPELL_CAST_START", "CreepyCrawlers", 329239)
	self:Log("SPELL_CAST_START", "WingBuffet", 330403)
	self:Log("SPELL_AURA_APPLIED", "BlightbeakApplied", 327882)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlightbeakApplied", 327882)
	self:Log("SPELL_CAST_START", "BelchPlague", 327233)
	self:Log("SPELL_CAST_START", "BeckonSlime", 327584)
	self:Log("SPELL_AURA_APPLIED", "CorrodedClawsApplied", 320512)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CorrodedClawsApplied", 320512)
	self:Log("SPELL_CAST_START", "FesteringBelch", 318949)
	self:Log("SPELL_CAST_SUCCESS", "JaggedSpines", 320517)
	self:Log("SPELL_CAST_START", "GrippingInfection", 328180)
	self:Log("SPELL_AURA_APPLIED", "GrippingInfectionApplied", 328180)
	self:Log("SPELL_CAST_START", "WitheringFilth", 321935)
	self:Log("SPELL_CAST_START", "CrushingEmbrace", 328429)
	self:Log("SPELL_CAST_START", "VileSpit", 319898)
	self:Log("SPELL_CAST_SUCCESS", "BulwarkOfMaldraxxus", 336451)
	self:Log("SPELL_CAST_START", "CallVenomfang", 328338)
	self:Log("SPELL_CAST_START", "EnvelopingWebbing", 328475)
	self:Log("SPELL_CAST_SUCCESS", "Stealthlings", 328400)
	self:Log("SPELL_CAST_START", "OozingCarcass", 330786)
	self:Log("SPELL_CAST_START", "GhostStep", 330816)
	self:Log("SPELL_CAST_START", "WonderGrow", 328016)
	self:Log("SPELL_CAST_SUCCESS", "DoomShroom", 327995)
	self:Log("SPELL_CAST_SUCCESS", "Fungistorm", 328177)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Environment
do
	local plaguefallen = false

	function mod:ConcentratedPlagueApplied(args)
		if self:Me(args.destGUID) and args.amount > 5 then
			self:StackMessageOld(args.spellId, args.destName, args.amount, "yellow")
			if (args.amount ~= 10 or plaguefallen) then
				self:PlaySound(args.spellId, args.amount > 7 and "warning" or "alert", nil, args.destName)
			end
		end
	end
	function mod:PlaguefallenApplied(args)
		if self:Me(args.destGUID) then
			plaguefallen = true
		end
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "long", nil, args.destName)
	end
	function mod:PlaguefallenRemoved(args)
		if self:Me(args.destGUID) then
			plaguefallen = false
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Plagueborer
do
	local prev = 0
	function mod:RollingPlague(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Fen Hatchling
do
	local prev = 0
	function mod:ClingingInfestationApplied(args)
		if self:Me(args.destGUID) then
			prev = args.time
			local stacks = args.amount or 1
			self:StackMessageOld(args.spellId, args.destName, stacks, "yellow")
			self:PlaySound(args.spellId, stacks > 3 and "warning" or "alert")
		end
	end
	function mod:ClingingInfestationDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 4 then
				prev = args.time
				self:PersonalMessage(args.spellId)
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
	function mod:ClingingInfestationRemoved(args)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Fen Hornet
function mod:FenStingerApplied(args)
	if self:Dispeller("poison", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Decaying Flesh Giant
function mod:CreepyCrawlers(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Plagueroc
function mod:WingBuffet(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
function mod:BlightbeakApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:StackMessageOld(args.spellId, args.destName, args.amount, "yellow")
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Plaguebelcher
function mod:BelchPlague(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
	end
end
function mod:BeckonSlime(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Rotting Slimeclaw
do
	local prev = 0
	function mod:CorrodedClawsApplied(args)
		local t = args.time
		if t-prev > 2 and self:Dispeller("disease", nil, args.spellId) then
			self:StackMessageOld(args.spellId, args.destName, args.amount, "yellow")
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

-- Blighted Spinebreaker
function mod:FesteringBelch(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
function mod:JaggedSpines(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Plaguebinder
function mod:GrippingInfection(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
function mod:GrippingInfectionApplied(args)
	if self:Dispeller("disease", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

-- Congealed Slime
function mod:WitheringFilth(args)
	-- This ability has been bugged since 9.0, currently it seems to put the targeting circle on the player
	-- at the top of the threat table but then it actually leaps to the closest target at the end of the cast.
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Defender of Maldraxxus
do
	local function printTargetMovementDispelOnly(self, name, guid)
		if self:Dispeller("movement") or self:Healer() or self:Me(guid) then
			self:TargetMessage(328429, "yellow", name)
			self:PlaySound(328429, "alert", nil, name)
			if self:Me(guid) then
				self:Say(328429, nil, nil, "Crushing Embrace")
			end
		end
	end

	local function printTarget(self, name, guid)
		self:TargetMessage(328429, "yellow", name)
		self:PlaySound(328429, "alert", nil, name)
		if self:Me(guid) then
			self:Say(328429, nil, nil, "Crushing Embrace")
		end
	end

	function mod:CrushingEmbrace(args)
		-- depending on source NPC id it is either CCable or only can be stopped by movement dispellers
		local movementDispelOnly = self:MobId(args.sourceGUID) == 168907

		if movementDispelOnly then
			self:GetUnitTarget(printTargetMovementDispelOnly, 0.5, args.sourceGUID)
		else
			self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
		end
	end
end

function mod:VileSpit(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by priests
		return
	end
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:BulwarkOfMaldraxxus(args)
		local t = args.time
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if t-prev > 1.5 and unit and UnitAffectingCombat(unit) then
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Venomous Sniper
function mod:CallVenomfang(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
	end
end

-- Brood Ambusher
function mod:EnvelopingWebbing(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
function mod:Stealthlings(args)
	self:Message("summon_stealthlings", "red", CL.spawned:format(args.spellName), args.spellId)
	self:PlaySound("summon_stealthlings", "warning")
end

-- Ickor Bileflesh
function mod:OozingCarcass(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end
function mod:GhostStep(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

-- Fungalmancer
function mod:WonderGrow(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Pestilent Harvester
do
	local prev = 0
	function mod:DoomShroom(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Fungi Stormer
do
	local prev = 0
	function mod:Fungistorm(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end
