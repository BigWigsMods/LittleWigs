--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Beste Glatisant", 2815)
if not mod then return end
mod:RegisterEnableMob(242181) -- Beste Glatisant
mod:SetEncounterID(3210)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.beste_glatisant = "Beste Glatisant"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.beste_glatisant
	self:SetSpellRename(1245846, CL.knockback) -- Crumbling Rubble (Knockback)
end

function mod:GetOptions()
	return {
		1245667, -- Regurgitate Kobold
		1245746, -- Sludgy Flesh
		1245765, -- Fearsome Roar
		1245784, -- Crumbling Slam
		{1245846, "CASTBAR"}, -- Crumbling Rubble
	}, nil, {
		[1245846] = CL.knockback, -- Crumbling Rubble (Knockback)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RegurgitateKobold", 1245667)
	self:Log("SPELL_PERIODIC_DAMAGE", "SludgyFleshDamage", 1245746)
	self:Log("SPELL_PERIODIC_MISSED", "SludgyFleshDamage", 1245746)
	self:Log("SPELL_CAST_START", "FearsomeRoar", 1245765)
	self:Log("SPELL_CAST_START", "CrumblingSlam", 1245784)
	self:Log("SPELL_CAST_SUCCESS", "CrumblingSlamSuccess", 1245784)
end

function mod:OnEngage()
	self:CDBar(1245667, 4.5) -- Regurgitate Kobold
	self:CDBar(1245765, 15.5) -- Fearsome Roar
	self:CDBar(1245784, 25.2) -- Crumbling Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RegurgitateKobold(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 13.3)
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:SludgyFleshDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then -- 1.5s tick rate
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:FearsomeRoar(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 19.4)
	self:PlaySound(args.spellId, "alarm")
end

function mod:CrumblingSlam(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 28.7)
	self:PlaySound(args.spellId, "alarm")
end

function mod:CrumblingSlamSuccess(args)
	-- Crumbling Rubble occurs 4s after Crumbling Slam success
	self:CastBar(1245846, 4, CL.knockback) -- Crumbling Rubble
end
