--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grimroot", 2784)
if not mod then return end
mod:RegisterEnableMob(226923) -- Grimroot
mod:SetEncounterID(3023)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.grimroot = "Grimroot"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.grimroot
end

function mod:GetOptions()
	return {
		460509, -- Corrupted Tears
		{460703, "DISPEL"}, -- Tender's Rage
		{460727, "CASTBAR"}, -- Gloom
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CorruptedTears", 460509)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorruptedTearsDamage", 460515) -- no alert on APPLIED, doesn't damage right away
	self:Log("SPELL_PERIODIC_MISSED", "CorruptedTearsDamage", 460515)
	self:Log("SPELL_CAST_SUCCESS", "TendersRage", 460703)
	self:Log("SPELL_CAST_START", "Gloom", 460727)
end

function mod:OnEngage()
	self:CDBar(460509, 5.2) -- Corrupted Tears
	self:CDBar(460703, 22.2) -- Tender's Rage
	self:CDBar(460727, 31.1) -- Gloom
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CorruptedTears(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 11.3)
end

do
	local prev = 0
	function mod:CorruptedTearsDamage(args)
		local t = args.time
		if self:Me(args.destGUID) and t - prev > 1.5 then
			prev = t
			self:PersonalMessage(460509, "underyou")
			self:PlaySound(460509, "underyou")
		end
	end
end

function mod:TendersRage(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.onboss:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 34.0)
end

function mod:Gloom(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 8)
	self:CDBar(args.spellId, 30.7)
end
