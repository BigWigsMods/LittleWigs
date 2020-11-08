
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Godfrey", 33, 100)
if not mod then return end
mod:RegisterEnableMob(46964)
mod.engageId = 1072
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Locals
--

local cursedBulletsCount = 0

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93629, -- Cursed Bullets
		{93675, "TANK_HEALER"}, -- Mortal Wound
		93707, -- Summon Bloodthirsty Ghouls
		93520, -- Pistol Barrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CursedBullets", 93629)
	self:Log("SPELL_AURA_APPLIED", "CursedBulletsApplied", 93629)
	self:Log("SPELL_AURA_REMOVED", "CursedBulletsRemoved", 93629)
	self:Log("SPELL_AURA_APPLIED", "MortalWound", 93675)
	self:Log("SPELL_AURA_APPLIED_DOSE", "MortalWound", 93675)
	self:Log("SPELL_AURA_APPLIED", "SummonBloodthirstyGhouls", 93707)
	self:Log("SPELL_CAST_START", "PistolBarrage", 93520)
	self:Log("SPELL_DAMAGE", "PistolBarrageDamage", 93564)
	self:Log("SPELL_MISSED", "PistolBarrageDamage", 93564)
end

function mod:OnEngage()
	cursedBulletsCount = 0
	self:CDBar(93629, 19.1) -- Cursed Bullets
	self:CDBar(93707, 5.7) -- Summon Bloodthirsty Ghouls
	self:CDBar(93520, 11.2) -- Pistol Barrage
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:CursedBullets(args)
	cursedBulletsCount = cursedBulletsCount + 1
	self:CDBar(args.spellId, cursedBulletsCount % 2 == 0 and 18.2 or 12.1)
	if self:Interrupter() then
		self:MessageOld(args.spellId, "orange", nil, CL.casting:format(args.spellName))
	end
end

function mod:CursedBulletsApplied(args)
	local canDispel = self:Dispeller("curse")
	if canDispel or self:Me(args.destGUID) or self:Healer() then
		self:TargetMessageOld(args.spellId, args.destName, "orange", canDispel and "alarm", nil, nil, canDispel)
		self:TargetBar(args.spellId, 15, args.destName)
	end
end

function mod:CursedBulletsRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:MortalWound(args)
	local amount = args.amount or 1
	self:StackMessage(args.spellId, args.destName, amount, "yellow")
end

function mod:SummonBloodthirstyGhouls(args)
	self:MessageOld(args.spellId, "cyan", "info")
	self:CDBar(args.spellId, 30.3)
end

function mod:PistolBarrage(args)
	self:MessageOld(args.spellId, "red", "long")
	self:CastBar(args.spellId, 6)
	self:CDBar(args.spellId, 30.3)
end

do
	local prev = 0
	function mod:PistolBarrageDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:MessageOld(93520, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end
