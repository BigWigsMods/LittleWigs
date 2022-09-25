--------------------------------------------------------------------------------
-- Module Declaration
--

--TO DO List
--Tested everything except post phase 2 timers and soulgorge stacks warnings
--All timers were correct on hc and normal runs
--Test if Soul Echoes say works
local mod, CL = BigWigs:NewBoss("Amalgam of Souls", 1501, 1518)
if not mod then return end
mod:RegisterEnableMob(98542)

--------------------------------------------------------------------------------
-- Locals
--

local gorgeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		196078, -- Call Souls
		194956, -- Reap Soul
		196587, -- Soul Burst
		{194966, "SAY"}, -- Soul Echoes
		195254, -- Swirling scythe
		196930, -- Soulgorge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallSouls", 196078)
	self:Log("SPELL_CAST_SUCCESS", "SoulEchoes", 194966) --27.5
	self:Log("SPELL_CAST_START", "SoulBurstStart", 196587)
	self:Log("SPELL_CAST_SUCCESS", "SoulBurstSuccess", 196587)
	self:Log("SPELL_CAST_START", "ReapSoul", 194956) -- 14.6
	self:Log("SPELL_CAST_SUCCESS", "SwirlingScythe", 195254) -- 20 SEC CD
	self:Log("SPELL_AURA_APPLIED", "SoulEchoesApplied", 194966)
	self:Log("SPELL_AURA_APPLIED", "Soulgorge", 196930)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 98542)
end

function mod:OnEngage()
	gorgeCount = 0
	self:Bar(195254, 8.5) -- Swirling scythe
	self:Bar(194966, 15.7) -- Soul Echoes
	self:Bar(194956, 20.4) -- Reap Soul
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Soulgorge()
	gorgeCount = gorgeCount + 1
end

function mod:SoulBurstStart(args)
	if gorgeCount == 2 then
		self:MessageOld(args.spellId, "yellow", "alert", CL.incoming:format(args.spellName))
	elseif gorgeCount >= 3 then
		self:MessageOld(args.spellId, "red", "warning", CL.incoming:format(args.spellName))
	end
end

function mod:SoulBurstSuccess()
	self:CDBar(195254, 8.5) -- Swirling scythe
	self:CDBar(194966, 15.6) -- Soul Echoes
	self:CDBar(194956, 20.4) -- Reap Soul
	gorgeCount = 0
end

function mod:CallSouls()
	self:CDBar(196587, 27.5) -- Soul Burst
	self:StopBar(195254) -- Swirling scythe
	self:StopBar(194966) -- Soul Echoes
	self:StopBar(194956) -- Reap Soul
end

function mod:ReapSoul(args)
	self:Bar(args.spellId, 13.4)
	if self:Tank() then
		self:MessageOld(args.spellId, "yellow", "warning", CL.incoming:format(args.spellName))
	end
end

function mod:SwirlingScythe(args)
	self:MessageOld(args.spellId, "yellow")
	self:Bar(args.spellId, 21.2)
end

function mod:SoulEchoes(args)
	self:Bar(args.spellId, 26.7)
end

function mod:SoulEchoesApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

