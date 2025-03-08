--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mordretha, the Endless Empress", 2293, 2417)
if not mod then return end
mod:RegisterEnableMob(165946) -- Mordretha, the Endless Empress
mod:SetEncounterID(2404)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		{324079, "TANK_HEALER"}, -- Reaping Scythe
		323608, -- Dark Devastation
		323825, -- Grasping Rift
		{323831, "DISPEL"}, -- Death Grasp
		324449, -- Manifest Death
		-- Mythic
		339573, -- Echoes of Carnage
		339706, -- Ghostly Charge
		339550, -- Echo of Battle
	}, {
		[339573] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ReapingScythe", 324079)
	self:Log("SPELL_CAST_START", "DarkDevastation", 323608)
	self:Log("SPELL_CAST_START", "GraspingRift", 323683)
	self:Log("SPELL_CAST_SUCCESS", "ManifestDeath", 324449)

	-- Mythic
	self:Log("SPELL_CAST_SUCCESS", "EchoesOfCarnage", 339573)
	self:Log("SPELL_CAST_START", "GhostlyCharge", 339706)
	self:Log("SPELL_CAST_START", "EchoOfBattle", 339550)
	self:Log("SPELL_AURA_APPLIED", "DeathGraspApplied", 323831)
end

function mod:OnEngage()
	self:StopBar(CL.active)
	self:SetStage(1)
	self:CDBar(324079, 8.2) -- Reaping Scythe
	self:CDBar(323608, 15.5) -- Dark Devastation
	self:CDBar(323825, 24.0) -- Grasping Rift
	self:CDBar(324449, 27.6) -- Manifest Death
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 30.3, CL.active, "achievement_dungeon_theatreofpain")
end

function mod:ReapingScythe(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alert")
end

function mod:DarkDevastation(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 26.7)
	self:PlaySound(args.spellId, "alarm")
end

function mod:GraspingRift(args)
	self:Message(323825, "yellow")
	self:CDBar(323825, 31.6)
	self:PlaySound(323825, "alert")
end

function mod:DeathGraspApplied(args)
	local onMe = self:Me(args.destGUID)
	if onMe or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		if onMe then
			self:PlaySound(args.spellId, "info", nil, args.destName)
		else
			self:PlaySound(args.spellId, "warning", nil, args.destName)
		end
	end
end

function mod:ManifestDeath(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 48.6)
	self:PlaySound(args.spellId, "info")
end

-- Mythic

function mod:EchoesOfCarnage(args)
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
	self:CDBar(339550, 3.2) -- Echo of Battle
	self:CDBar(324079, 6.9) -- Reaping Scythe
	self:CDBar(339706, 14.2) -- Ghostly Charge
	self:CDBar(323608, 16.6) -- Dark Devastation
	self:CDBar(323825, 28.7) -- Grasping Rift
	self:CDBar(324449, 31.6) -- Manifest Death
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:GhostlyCharge(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:CDBar(args.spellId, 24.3)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:EchoOfBattle(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:CDBar(args.spellId, 23.9)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
