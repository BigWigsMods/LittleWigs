--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gekkan", 994, 690)
if not mod then return end
mod:RegisterEnableMob(
	61243, -- Gekkan,
	61337, -- Glintrok Ironhide
	61338, -- Glintrok Skulker
	61339, -- Glintrok Oracle
	61340 -- Glintrok Hexxer
)
mod:SetEncounterID(2129) -- note: doesn't fire on Mists Classic
mod:SetRespawnTime(30)

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
		118988, -- Reckless Inspiration
		118963, -- Shank
		118940, -- Cleansing Flame
		{118903, "DISPEL"}, -- Hex of Lethargy
	}, {
		["stages"] = CL.general,
		[118963] = -5920,
		[118940] = -5922,
		[118903] = -5924,
	}, {
		[118940] = mod:SpellName(33144), -- Cleansing Flame (Heal)
		[118903] = mod:SpellName(66054), -- Hex of Lethargy (Hex)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "RecklessInspiration", 118988)
	self:Log("SPELL_CAST_START", "Shank", 118963)
	self:Log("SPELL_AURA_APPLIED", "ShankApplied", 118963)
	self:Log("SPELL_AURA_APPLIED", "HexOfLethargy", 118903)
	self:Log("SPELL_AURA_APPLIED_DOSE", "HexOfLethargy", 118903)
	self:Log("SPELL_CAST_START", "CleansingFlame", 118940)
	self:Death("Deaths", 61243, 61337, 61338, 61339, 61340)
end

function mod:OnEngage()
	deaths = 0
	if self:Classic() then
		self:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- only Gekkan has boss frames, and there are no encounter events in Mists Classic
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RecklessInspiration(args)
	self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
end

function mod:Shank(args)
	if self:MobId(args.sourceGUID) ~= 61338 then return end -- Don't announce casts done by trash mobs
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and self:Tanking(unit) then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:ShankApplied(args)
	if self:MobId(args.sourceGUID) ~= 61338 then return end -- Don't announce casts done by trash mobs
	self:TargetMessage(args.spellId, "yellow", args.destName)
end

function mod:HexOfLethargy(args)
	if self:MobId(args.sourceGUID) ~= 61340 then return end -- Don't announce casts done by trash mobs
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
	end
end

function mod:CleansingFlame(args)
	if self:MobId(args.sourceGUID) ~= 61339 then return end -- Don't announce casts done by trash mobs
	self:Message(args.spellId, "orange", CL.casting:format(self:SpellName(33144)), args.spellId) -- Heal
	self:PlaySound(args.spellId, "alert")
end

function mod:Deaths(args)
	deaths = deaths + 1
	if deaths == 5 then
		deaths = 0
		if self:Classic() then -- no encounter events in Mists Classic
			self:Win()
		end
	else
		self:Message("stages", "green", CL.mob_killed:format(args.destName, deaths, 5), false)
		self:PlaySound("stages", "info")
	end
end
