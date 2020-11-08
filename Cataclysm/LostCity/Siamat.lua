
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Siamat", 755, 122)
if not mod then return end
mod:RegisterEnableMob(44819)
mod.engageId = 1055
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local addsLeft = 3

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.servant = "Summon Servant"
	L.servant_desc = "Warn when a Servant of Siamat is summoned."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"servant",
		"stages",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "Servant", 84547, 84553, 84554) -- 1st add, 2nd, 3rd. WTF?
	self:Death("ServantDied", 45259, 45268, 45269) -- 1st add, 2nd, 3rd
end

function mod:OnEngage()
	addsLeft = 3
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Servant(args)
	self:MessageOld("servant", "red", "alert", CL.spawned:format(self:SpellName(-2477)), args.spellId)
	if args.spellId ~= 84554 then -- 1st & 2nd adds
		self:CDBar("servant", 45, CL.next_add, args.spellId)
	else -- last add
		self:StopBar(CL.next_add)
	end
end

function mod:ServantDied()
	addsLeft = addsLeft - 1
	if addsLeft > 0 then
		self:MessageOld("stages", "cyan", nil, CL.add_remaining:format(addsLeft), false)
	else
		self:MessageOld("stages", "green", "info", CL.stage:format(2), false)
	end
end

