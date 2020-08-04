
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
	163891, -- Rotmarrow Slime
	168627, -- Plaguebinder
	164707, -- Congealed Slime
	163862, -- Defender of Many Eyes
	167493, -- Venomous Sniper
	164737, -- Brood Ambusher
	169861 -- Ickor Bileflesh
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
	L.rotmarrow_slime = "Rotmarrow Slime"
	L.plaguebinder = "Plaguebinder"
	L.congealed_slime = "Congealed Slime"
	L.defender_of_many_eyes = "Defender of Many Eyes"
	L.venomous_sniper = "Venomous Sniper"
	L.brood_ambusher = "Brood Ambusher"
	L.ickor_bileflesh = "Ickor Bileflesh"
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
		-- Rotting Slimeclaw
		{320512, "DISPEL"}, -- Corroded Claws
		-- Blighted Spinebreaker
		318949, -- Festering Belch
		320517, -- Jagged Spines
		-- Rotmarrow Slime
		319070, -- Corrosive Gunk
		-- Plaguebinder
		{328180, "DISPEL"}, -- Gripping Infection
		-- Congealed Slime
		{321935, "SAY"}, -- Withering Filth
		-- Defender of Many Eyes
		336451, -- Bulwark of Maldraxxus
		-- Venomous Sniper
		{328395, "SAY"}, -- Venompiercer
		-- Brood Ambusher
		328475, -- Enveloping Webbing
		-- Ickor Bileflesh
		330786, -- Oozing Carcass
		330816, -- Ghost Step
	}, {
		[323572] = L.plagueborer,
		[327515] = L.fen_hornet,
		[329239] = L.decaying_flesh_giant,
		[330403] = L.plagueroc,
		[327233] = L.plaguebelcher,
		[320512] = L.rotting_slimeclaw,
		[318949] = L.blighted_spinebreaker,
		[319070] = L.rotmarrow_slime,
		[328180] = L.plaguebinder,
		[321935] = L.congealed_slime,
		[336451] = L.defender_of_many_eyes,
		[328395] = L.venomous_sniper,
		[328475] = L.brood_ambusher,
		[330786] = L.ickor_bileflesh,
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
	self:Log("SPELL_AURA_APPLIED", "CorrodedClawsApplied", 320512)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CorrodedClawsApplied", 320512)
	self:Log("SPELL_CAST_START", "FesteringBelch", 318949)
	self:Log("SPELL_CAST_SUCCESS", "JaggedSpines", 320517)
	self:Log("SPELL_CAST_START", "CorrosiveGunk", 319070)
	self:Log("SPELL_CAST_START", "GrippingInfection", 328180)
	self:Log("SPELL_AURA_APPLIED", "GrippingInfectionApplied", 328180)
	self:Log("SPELL_CAST_START", "WitheringFilth", 321935)
	self:Log("SPELL_CAST_SUCCESS", "BulwarkOfMaldraxxus", 336451)
	self:Log("SPELL_CAST_START", "Venompiercer", 328395)
	self:Log("SPELL_CAST_START", "EnvelopingWebbing", 328475)
	self:Log("SPELL_CAST_START", "OozingCarcass", 330786)
	self:Log("SPELL_CAST_START", "GhostStep", 330816)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RollingPlague(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:FenStingerApplied(args)
	if self:Dispeller("poison", nil, args.spellId) then
		self:TargetMessage2(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:CreepyCrawlers(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:WingBuffet(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:BlightbeakApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:StackMessage(args.spellId, args.destName, args.amount, "yellow")
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:BelchPlague(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:CorrodedClawsApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:StackMessage(args.spellId, args.destName, args.amount, "yellow")
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:FesteringBelch(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:JaggedSpines(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:CorrosiveGunk(args)
		local t = args.time
		if t-prev > 1 then
			self:Message2(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:GrippingInfection(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:GrippingInfectionApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage2(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

do
	local function printTarget(self, name, guid)
		local isOnMe = self:Me(guid)
		self:TargetMessage2(321935, isOnMe and "red" or "yellow", name)
		self:PlaySound(321935, isOnMe and "alarm" or "info", nil, name)
		if isOnMe then
			self:Say(321935)
		end
	end
	
	function mod:WitheringFilth(args)
		-- XXX check if the mob actually changes target
		self:GetUnitTarget(printTarget, 0.6, args.sourceGUID)
	end
end

function mod:BulwarkOfMaldraxxus(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(328395, "orange", name)
		self:PlaySound(328395, "alert", nil, name)
		if self:Me(guid) then
			self:Say(328395)
		end
	end
	
	function mod:Venompiercer(args)
		self:GetUnitTarget(printTarget, 0.6, args.sourceGUID)
	end
end

function mod:EnvelopingWebbing(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:OozingCarcass(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:GhostStep(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
