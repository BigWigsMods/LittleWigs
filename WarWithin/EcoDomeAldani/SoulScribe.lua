--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Soul-Scribe", 2830, 2677)
if not mod then return end
mod:RegisterEnableMob(234935) -- Soul-Scribe
mod:SetEncounterID(3109)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local whispersOfFateCount = 1
local eternalWeaveCount = 1
local dreadOfTheUnknownCount = 1
local ceremonialDaggerCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1224793, "OFF"}, -- Whispers of Fate
		1224865, -- Fatebound
		1226444, -- Wounded Fate
		1236703, -- Eternal Weave
		1225218, -- Dread of the Unknown
		1225174, -- Ceremonial Dagger
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "WhispersOfFate", 1224793)
	self:Log("SPELL_AURA_APPLIED", "Fatebound", 1224865)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Fatebound", 1224865)
	self:Log("SPELL_AURA_APPLIED", "WoundedFate", 1226444)
	self:Log("SPELL_AURA_APPLIED_DOSE", "WoundedFate", 1226444)
	self:Log("SPELL_CAST_START", "EternalWeave", 1236703)
	self:Log("SPELL_CAST_START", "DreadOfTheUnknown", 1225218)
	self:Log("SPELL_CAST_START", "CeremonialDagger", 1225174)
end

function mod:OnEngage()
	whispersOfFateCount = 1
	eternalWeaveCount = 1
	dreadOfTheUnknownCount = 1
	ceremonialDaggerCount = 1
	self:CDBar(1224793, 6.2, CL.count:format(self:SpellName(1224793), whispersOfFateCount)) -- Whispers of Fate
	self:CDBar(1225174, 9.8, CL.count:format(self:SpellName(1225174), ceremonialDaggerCount)) -- Ceremonial Dagger
	self:CDBar(1225218, 28.1, CL.count:format(self:SpellName(1225218), dreadOfTheUnknownCount)) -- Dread of the Unknown
	self:CDBar(1236703, 56.1, CL.count:format(self:SpellName(1236703), eternalWeaveCount)) -- Eternal Weave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WhispersOfFate(args)
	-- this cast just precedes every Dread of the Unknown and Ceremonial Dagger
	self:StopBar(CL.count:format(args.spellName, whispersOfFateCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, whispersOfFateCount))
	whispersOfFateCount = whispersOfFateCount + 1
	if whispersOfFateCount % 3 ~= 1 then -- 2, 3, 5, 6, 8, 9...
		self:CDBar(args.spellId, 18.2, CL.count:format(args.spellName, whispersOfFateCount))
	else -- 4, 7, 10...
		self:CDBar(args.spellId, 49.5, CL.count:format(args.spellName, whispersOfFateCount))
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:Fatebound(args)
	if self:Me(args.destGUID) then
		local amount = args.amount or 1
		self:Message(args.spellId, "green", CL.stackyou:format(amount, args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:WoundedFate(args)
	if self:Me(args.destGUID) then
		local amount = args.amount or 1
		self:StackMessage(args.spellId, "blue", args.destName, amount, 1)
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:EternalWeave(args)
	self:StopBar(CL.count:format(args.spellName, eternalWeaveCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, eternalWeaveCount))
	eternalWeaveCount = eternalWeaveCount + 1
	self:CDBar(args.spellId, 87.2, CL.count:format(args.spellName, eternalWeaveCount))
	self:PlaySound(args.spellId, "long")
end

function mod:DreadOfTheUnknown(args)
	self:StopBar(CL.count:format(args.spellName, dreadOfTheUnknownCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, dreadOfTheUnknownCount))
	dreadOfTheUnknownCount = dreadOfTheUnknownCount + 1
	self:CDBar(args.spellId, 87.2, CL.count:format(args.spellName, dreadOfTheUnknownCount))
	self:PlaySound(args.spellId, "alarm")
end

function mod:CeremonialDagger(args)
	self:StopBar(CL.count:format(args.spellName, ceremonialDaggerCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, ceremonialDaggerCount))
	ceremonialDaggerCount = ceremonialDaggerCount + 1
	if ceremonialDaggerCount % 2 == 0 then
		self:CDBar(args.spellId, 36.5, CL.count:format(args.spellName, ceremonialDaggerCount))
	else
		self:CDBar(args.spellId, 49.5, CL.count:format(args.spellName, ceremonialDaggerCount))
	end
	self:PlaySound(args.spellId, "alarm")
end
