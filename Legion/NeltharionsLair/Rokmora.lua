--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rokmora", 1458, 1662)
if not mod then return end
mod:RegisterEnableMob(91003) -- Rokmora
mod:SetEncounterID(1790)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "Rokmora Active"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		188114, -- Shatter
		192800, -- Choking Dust
		188169, -- Razor Shards
		198024, -- Cystalline Ground
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Shatter", 188114)
	self:Log("SPELL_AURA_APPLIED", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_DAMAGE", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_MISSED", "ChokingDustDamage", 192800)
	self:Log("SPELL_CAST_START", "RazorShards", 188169)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Cystalline Ground
end

function mod:OnEngage()
	if not self:Normal() then
		self:CDBar(198024, 4.4) -- Crystalline Ground
	end
	-- cast at 100 energy, 20s energy gain + ~.4s delay
	self:CDBar(188114, 20.4) -- Shatter
	self:CDBar(188169, 25.3) -- Razor Shards
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:WarmupLong()
	self:Bar("warmup", 18.9, L.warmup_text, "achievement_dungeon_neltharionslair")
end

-- called from trash module
function mod:WarmupShort()
	self:Bar("warmup", 4.95, L.warmup_text, "achievement_dungeon_neltharionslair")
end

function mod:Shatter(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	-- cast at 100 energy, 20s energy gain + 4.3s cast
	self:CDBar(args.spellId, 24.3) -- pull:20.7, 24.4, 24.3, 24.4, 24.3
	-- correct timers
	if self:BarTimeLeft(188169) < 4.87 then -- Razor Shards
		self:CDBar(188169, {4.87, 29.1})
	end
end

do
	local prev = 0
	function mod:ChokingDustDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

function mod:RazorShards(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 29.1) -- pull:25.6, 29.2, 29.2, 29.2, 34.1
	-- correct timers
	if self:BarTimeLeft(188114) < 4.87 then -- Shatter
		self:CDBar(188114, {4.87, 24.3})
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(event, unit, _, spellId)
	if spellId == 198024 then -- Crystalline Ground
		self:StopBar(198024)
		self:Message(198024, "orange")
		self:PlaySound(198024, "alert")
		self:UnregisterUnitEvent(event, unit)
	end
end
