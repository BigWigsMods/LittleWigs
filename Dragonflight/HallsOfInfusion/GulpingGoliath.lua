if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gulping Goliath", 2527, 2507)
if not mod then return end
mod:RegisterEnableMob(189722) -- Gulping Goliath
mod:SetEncounterID(2616)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		385551, -- Gulp
		385181, -- Overpowering Croak
		385531, -- Belly Slam
		385442, -- Toxic Effluvia
		{374389, "DISPEL"}, -- Gulp Swog Toxin
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Gulp", 385551)
	self:Log("SPELL_CAST_START", "OverpoweringCroak", 385181)
	self:Log("SPELL_CAST_START", "BellySlam", 385531)
	self:Log("SPELL_CAST_START", "ToxicEffluvia", 385442)
	self:Log("SPELL_AURA_APPLIED_DOSE", "GulpSwogToxinApplied", 374389)
end

function mod:OnEngage()
	self:Bar(385181, 8.5) -- Overpowering Croak
	self:CDBar(385551, 18.2) -- Gulp
	self:CDBar(385442, 30.3) -- Toxic Effluvia
	self:CDBar(385531, 38.9) -- Belly Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Gulp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO timer
end

function mod:OverpoweringCroak(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 38.8)
end

function mod:BellySlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	-- TODO timer
end

function mod:ToxicEffluvia(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 27.5)
end

do
	local prev = 0
	function mod:GulpSwogToxinApplied(args)
		if self:MobId(args.sourceGUID) ~= 190366 and args.amount >= 6 and args.amount % 2 == 0
				and (self:Dispeller("poison", nil, args.spellId) or self:Me(args.destGUID)) then
			local t = args.time
			if t - prev > 1 then
				-- Insta-kill at 10 stacks
				self:StackMessage(args.spellId, "red", args.destName, args.amount, 8)
				if args.amount <= 6 then
					self:PlaySound(args.spellId, "alert", nil, args.destName)
				else
					self:PlaySound(args.spellId, "warning", nil, args.destName)
				end
			end
		end
	end
end
