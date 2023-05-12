--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Decatriarch Wratheye", 2520, 2474)
if not mod then return end
mod:RegisterEnableMob(186121) -- Decatriarch Wratheye
mod:SetEncounterID(2569)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local rotburstTotemCount = 1
local decaystrikeCount = 1
local lastRotburstTotemCD = 15.5

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373960, -- Decaying Strength
		373944, -- Rotburst Totem
		376170, -- Choking Rotcloud
		{373917, "TANK_HEALER"}, -- Decaystrike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DecayingStrength", 373960)
	self:Log("SPELL_CAST_START", "RotburstTotem", 373942)
	self:Log("SPELL_CAST_START", "ChokingRotcloud", 376170)
	self:Log("SPELL_CAST_START", "Decaystrike", 373912)
end

function mod:OnEngage()
	rotburstTotemCount = 1
	decaystrikeCount = 1
	lastRotburstTotemCD = 15.5
	self:CDBar(376170, 5.8) -- Choking Rotcloud
	self:CDBar(373917, 10.6) -- Decaystrike
	self:CDBar(373944, 15.5) -- Rotburst Totem
	-- 40s energy gain, ~.1s delay
	self:CDBar(373960, 40.1) -- Decaying Strength
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DecayingStrength(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	-- 4s cast + 40s energy gain + .9s delay
	self:CDBar(373960, 44.9) -- Decaying Strength
end

function mod:RotburstTotem(args)
	self:Message(373944, "yellow")
	self:PlaySound(373944, "warning")
	rotburstTotemCount = rotburstTotemCount + 1
	if rotburstTotemCount % 2 == 0 then
		lastRotburstTotemCD = 17.8
		self:CDBar(373944, 17.8) -- 17.8 to 18.2
	else
		lastRotburstTotemCD = 26.7
		self:CDBar(373944, 26.7) -- 26.7 to 27.1
	end
end

function mod:ChokingRotcloud(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 42.5)
end

function mod:Decaystrike(args)
	self:Message(373917, "purple")
	self:PlaySound(373917, "alert")
	decaystrikeCount = decaystrikeCount + 1
	if decaystrikeCount % 2 == 0 then
		self:CDBar(373917, 19.4)
	else
		self:CDBar(373917, 25.5)
	end
	-- Rotburst Totem follows this at a minimum of 3.62s later
	if self:BarTimeLeft(373944) < 3.62 then -- Rotburst Totem
		self:CDBar(373944, {3.62, lastRotburstTotemCD})
	end
end
