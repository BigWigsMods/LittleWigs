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
		188169, -- Razor Shards
		188114, -- Shatter
		192800, -- Choking Dust
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RazorShards", 188169)
	self:Log("SPELL_CAST_START", "Shatter", 188114)

	self:Log("SPELL_AURA_APPLIED", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_DAMAGE", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_MISSED", "ChokingDustDamage", 192800)
end

function mod:OnEngage()
	self:Bar(188114, 20.4) -- Shatter
	self:Bar(188169, 25.3) -- Razor Shards
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

function mod:RazorShards(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 29.1) -- pull:25.6, 29.2, 29.2, 29.2, 34.1
	-- correct timers
	if self:BarTimeLeft(188114) < 4.87 then -- Shatter
		self:Bar(188114, {4.87, 24.3})
	end
end

function mod:Shatter(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 24.3) -- pull:20.7, 24.4, 24.3, 24.4, 24.3
	-- correct timers
	if self:BarTimeLeft(188169) < 4.87 then -- Razor Shards
		self:Bar(188169, {4.87, 29.1})
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
