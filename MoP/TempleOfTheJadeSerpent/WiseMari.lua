
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Wise Mari", 960, 672)
if not mod then return end
mod:RegisterEnableMob(56448)
mod.engageId = 1418
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-6327, -- Call Water
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallWater", 106526)
	self:Log("SPELL_CAST_START", "BubbleBurst", 106612)
	self:Death("AddDeath", 56511)
end

function mod:OnEngage()
	deaths = 0
	self:Message("stages", "Positive", "Info", CL.stage:format(1), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallWater(args)
	self:DelayedMessage(-6327, 5, "Important", CL.count:format(CL.add_spawned, deaths+1), args.spellId, "Alert")
	self:Bar(-6327, 5, CL.next_add, args.spellId)
end

function mod:BubbleBurst(args)
	local text = CL.stage:format(2)
	self:DelayedMessage("stages", 4, "Positive", text, false, "Info")
	self:Bar("stages", 4, text, args.spellId)
end

function mod:AddDeath()
	deaths = deaths + 1
	self:Message(-6327, "Attention", nil, CL.add_killed:format(deaths, 4), 106526)
end
