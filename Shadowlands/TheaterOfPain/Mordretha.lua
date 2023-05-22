--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mordretha, the Endless Empress", 2293, 2417)
if not mod then return end
mod:RegisterEnableMob(165946) -- Mordretha, the Endless Empress
mod:SetEncounterID(2404)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		-- General
		{324079, "TANK_HEALER"}, -- Reaping Scythe
		323608, -- Dark Devastation
		323825, -- Grasping Rift
		{323831, "DISPEL"}, -- Death Grasp
		324449, -- Manifest Death
		-- Mythic
		339573, -- Echoes of Carnage
		{339706, "CASTBAR"}, -- Ghostly Charge
		339550, -- Echo of Battle
	}, {
		[324079] = "general",
		[339573] = "mythic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ReapingScythe", 324079)
	self:Log("SPELL_CAST_START", "DarkDevastation", 323608)
	self:Log("SPELL_CAST_START", "GraspingRift", 323683)
	self:Log("SPELL_CAST_SUCCESS", "ManifestDeath", 324449)
	self:Log("SPELL_CAST_SUCCESS", "EchoesOfCarnage", 339573)
	self:Log("SPELL_CAST_START", "GhostlyCharge", 339706)
	self:Log("SPELL_CAST_START", "EchoOfBattle", 339550)
	self:Log("SPELL_AURA_APPLIED", "DeathGraspApplied", 323831)
end

function mod:OnEngage()
	self:Bar(324079, 8.2) -- Reaping Scythe
	self:Bar(323608, 15.5) -- Dark Devastation
	self:Bar(324449, 21.6) -- Manifest Death
	self:Bar(323825, 22.8) -- Grasping Rift
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 30.8, CL.active, "achievement_dungeon_theatreofpain")
end

function mod:ReapingScythe(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 15.8)
end

function mod:DarkDevastation(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.1)
end

function mod:GraspingRift(args)
	self:Message(323825, "orange")
	self:PlaySound(323825, "alert")
	self:Bar(323825, 25.5)
end

function mod:DeathGraspApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:ManifestDeath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 39)
end

function mod:EchoesOfCarnage(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(339550, 3.2) -- Echo of Battle
	self:Bar(324079, 6.9) -- Reaping Scythe
	self:Bar(339706, 13.5) -- Ghostly Charge
	self:Bar(323608, 14.6) -- Dark Devastation
	self:Bar(324449, 21) -- Manifest Death
	self:Bar(323825, 22.5) -- Grasping Rift
end

do
	local prev = 0
	function mod:GhostlyCharge(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
			self:Bar(args.spellId, 24.3)
			self:CastBar(args.spellId, 3.5)
		end
	end
end

do
	local prev = 0
	function mod:EchoOfBattle(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
			self:Bar(args.spellId, 24.3)
		end
	end
end
