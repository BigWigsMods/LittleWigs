-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Epoch Hunter", 560, 540)
if not mod then return end
mod:RegisterEnableMob(
	18096, -- Epoch Hunter,
	18092, -- Infinite Slayer disguised as Tarren Mill Guardsman
	18093, -- Infinite Saboteur disguised as Tarren Mill Protector
	18094, -- Infinite Defiler disguised as Tarren Mill Lookout
	18170, -- Infinite Slayer
	18171, -- Infinite Defiler
	18172 -- Infinite Saboteur
)
mod.engageId = 1906
-- mod.respawnTime = 0 -- you have to talk to Taretha again if you wipe

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so... you and your troublesome friends must die!
	L.trash_warmup_trigger = "troublesome friends"
	-- Enough, I will erase your very existence!
	L.boss_warmup_trigger = "very existence!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"warmup",
		{33834, "DISPEL"}, -- Magic Disruption Aura
		31914 -- Sand Breath
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:Log("SPELL_AURA_APPLIED", "MagicDisruptionAura", 33834)
	self:Log("SPELL_AURA_REMOVED", "MagicDisruptionAuraRemoved", 33834)
	self:Log("SPELL_AURA_APPLIED", "SandBreath", 31914)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg:find(L.trash_warmup_trigger, nil, true) then
		self:Bar("warmup", 22.6, CL.active, "inv_sword_01")
	elseif msg:find(L.boss_warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 2.7, CL.active, "inv_sword_01")
	end
end


function mod:MagicDisruptionAura(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:MessageOld(args.spellId, "orange", "alert")
		self:Bar(args.spellId, 15)
	end
end

function mod:MagicDisruptionAuraRemoved(args)
	self:StopBar(args.spellName)
end

function mod:SandBreath(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "warning")
	end
end
