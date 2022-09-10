
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rokmora", 1458, 1662)
if not mod then return end
mod:RegisterEnableMob(91003)
mod.engageId = 1790

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "Rokmora Active"
	L.warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	L.warmup_trigger_2 = "Either way, I will enjoy every moment of it. Rokmora, crush them!"
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
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "RazorShards", 188169)
	self:Log("SPELL_CAST_START", "Shatter", 188114)

	self:Log("SPELL_AURA_APPLIED", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_DAMAGE", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_MISSED", "ChokingDustDamage", 192800)
end

function mod:OnEngage()
	self:CDBar(188169, 25) -- Razor Shards
	self:CDBar(188169, 20) -- Shatter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 18.9, L.warmup_text, "achievement_dungeon_neltharionslair")
	elseif msg == L.warmup_trigger_2 then
		self:UnregisterEvent(event)
		self:Bar("warmup", 4.95, L.warmup_text, "achievement_dungeon_neltharionslair")
	end
end

function mod:RazorShards(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 29) -- pull:25.6, 29.1, 29.9
end

function mod:Shatter(args)
	self:MessageOld(args.spellId, "yellow", "alert")
	self:CDBar(args.spellId, 24) -- pull:20.7, 24.3, 25.1
end

do
	local prev = 0
	function mod:ChokingDustDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

