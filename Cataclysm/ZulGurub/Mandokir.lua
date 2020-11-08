-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Bloodlord Mandokir", 859, 176)
if not mod then return end
mod:RegisterEnableMob(52151, 52157) -- Bloodlord Mandokir, Ohgan
mod.engageId = 1179
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		96740, -- Devastating Slam
		96684, -- Decapitate
		96776, -- Bloodletting
		96800, -- Frenzy
		96724, -- Reanimate Ohgan
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DevastatingSlam", 96740)
	self:Log("SPELL_CAST_SUCCESS", "Decapitate", 96684)
	self:Log("SPELL_AURA_APPLIED", "Bloodletting", 96776)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 96800)
	self:Log("SPELL_CAST_START", "ReanimateOhgan", 96724)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:DevastatingSlam(args)
	self:MessageOld(args.spellId, "red", "info")
end

function mod:Decapitate(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alert")
	self:CDBar(args.spellId, 30)
end

function mod:Bloodletting(args)
	self:MessageOld(args.spellId, "yellow", "alert")
	self:TargetBar(args.spellId, 10, args.destName)
	self:CDBar(args.spellId, 25)
end

function mod:Frenzy(args)
	self:MessageOld(args.spellId, "red", "long")
end

function mod:ReanimateOhgan(args)
	self:MessageOld(args.spellId, "yellow", "info", CL.casting:format(args.spellName))
end
