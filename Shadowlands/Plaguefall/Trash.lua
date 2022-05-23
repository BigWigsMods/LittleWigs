
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Plaguefall Trash", 2289)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	168580, -- Plagueborer
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
		-- Plagueborer
		323572, -- Rolling Plague
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
		[323572] = L.plagueborer,
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
		[328475] = L.brood_ambusher,
		[330786] = L.ickor_bileflesh,
		[328016] = L.fungalmancer,
		[327995] = L.pestilent_harvester,
		[328177] = L.fungi_stormer,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RollingPlague", 323572)
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

function mod:FenStingerApplied(args)
	if self:Dispeller("poison", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:CreepyCrawlers(args)
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:WingBuffet(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:BlightbeakApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:StackMessage(args.spellId, args.destName, args.amount, "yellow")
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:BelchPlague(args)
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:BeckonSlime(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:CorrodedClawsApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:StackMessage(args.spellId, args.destName, args.amount, "yellow")
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:FesteringBelch(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:JaggedSpines(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

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

function mod:WitheringFilth(args)
	-- This ability has been bugged since 9.0, currently it seems to put the targeting circle on the player
	-- at the top of the threat table but then it actually leaps to the closest target at the end of the cast.
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTargetMovementDispelOnly(self, name, guid)
		if self:Dispeller("movement") or self:Healer() or self:Me(guid) then
			self:TargetMessage(328429, "yellow", name)
			self:PlaySound(328429, "alert", nil, name)
			if self:Me(guid) then
				self:Say(328429)
			end
		end
	end

	local function printTarget(self, name, guid)
		self:TargetMessage(328429, "yellow", name)
		self:PlaySound(328429, "alert", nil, name)
		if self:Me(guid) then
			self:Say(328429)
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
		local unit = self:GetUnitIdByGUID(args.sourceGUID)
		if t-prev > 1.5 and unit and UnitAffectingCombat(unit) then
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:EnvelopingWebbing(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Stealthlings(args)
	self:Message("summon_stealthlings", "red", CL.spawned:format(args.spellName), args.spellId)
	self:PlaySound("summon_stealthlings", "warning")
end

function mod:OozingCarcass(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:GhostStep(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:WonderGrow(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

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
