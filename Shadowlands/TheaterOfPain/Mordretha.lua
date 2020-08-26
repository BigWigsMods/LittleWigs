
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mordretha, the Endless Empress", 2293, 2417)
if not mod then return end
mod:RegisterEnableMob(165946)
mod.engageId = 2404
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		324079, -- Reaping Scythe
		323608, -- Dark Devastation
		323683, -- Grasping Rift
		324449, -- Manifest Death
		-- Mythic
		339573, -- Echoes of Carnage
		339706, -- Ghostly Charge
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
	self:Log("SPELL_CAST_START", "EchoesOfCarnage", 339573)
	self:Log("SPELL_CAST_START", "GhostlyCharge", 339706)
end

function mod:OnEngage()
	self:Bar(324079, 8.2) -- Reaping Scythe
	self:Bar(323608, 15.5) -- Dark Devastation
	self:Bar(324449, 21.6) -- Manifest Death
	self:Bar(323683, 22.8) -- Grasping Rift
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ReapingScythe(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 15.8)
end

function mod:DarkDevastation(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 24)
end

function mod:GraspingRift(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 25.5)
end

function mod:ManifestDeath(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 39)
end

function mod:EchoesOfCarnage(args)
	self:Message2(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(324079, 6.9) -- Reaping Scythe
	self:Bar(339706, 13.5) -- Ghostly Charge
	self:Bar(323608, 14.6) -- Dark Devastation
	self:Bar(323683, 22.5) -- Grasping Rift
end

do
	local prev = 0
	function mod:GhostlyCharge(args)
		local t = args.time
		if t-prev > 1.5 then
			self:Message2(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
			self:Bar(args.spellId, 24.3)
			self:CastBar(args.spellId, 2)
		end
	end
end
