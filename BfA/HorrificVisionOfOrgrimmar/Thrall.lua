--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thrall", 2212)
if not mod then return end
mod:RegisterEnableMob(
	152089, -- Thrall
	234034 -- Thrall (Revisited)
)
mod:SetEncounterID({2332, 3086}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local hopelessnessCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.thrall = "Thrall"
end

----------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		297746, -- Seismic Slam
		297822, -- Surging Darkness
		-- Fallen Servants: Inquisitor Gnshal
		304976, -- Cries of the Void
		-- Fallen Servants: Oblivion Elemental
		297574, -- Hopelessness
		-- Fallen Servants: Vez'okk the Lightless
		306828, -- Defiled Ground
		-- Fallen Servants: Rexxar
		304251, -- Void Quills
	}, {
		[304976] = 306075, -- Fallen Servants: Inquisitor Gnshal
		[297574] = 302259, -- Fallen Servants: Oblivion Elemental
		[306828] = 306685, -- Fallen Servants: Vez'okk the Lightless
		[304251] = 306076, -- Fallen Servants: Rexxar
	}
end

function mod:OnRegister()
	self.displayName = L.thrall
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SeismicSlam", 297746)
	self:Log("SPELL_CAST_START", "SurgingDarkness", 297822)

	-- Fallen Servants: Inquisitor Gnshal
	self:Log("SPELL_CAST_START", "CriesOfTheVoid", 304976)

	-- Fallen Servants: Oblivion Elemental
	self:Log("SPELL_CAST_START", "Hopelessness", 297574)
	self:Log("SPELL_AURA_APPLIED", "HopelessnessApplied", 297574)
	self:Log("SPELL_AURA_REMOVED", "HopelessnessRemoved", 297574)

	-- Fallen Servants: Vez'okk the Lightless
	self:Log("SPELL_CAST_START", "DefiledGround", 306828)

	-- Fallen Servants: Rexxar
	self:Log("SPELL_CAST_START", "VoidQuills", 304251)
end

function mod:OnEngage()
	hopelessnessCount = 1
	local bossUnit = self:GetBossId(234034) or self:GetBossId(152089)
	if bossUnit then
		-- Defiled Ground replaces Seismic Slam
		if self:UnitBuff(bossUnit, 306685) then -- Fallen Servants: Vez'okk the Lightless
			self:CDBar(306828, 4.7) -- Defiled Ground
		else
			self:CDBar(297746, 4.7) -- Seismic Slam
		end
	end
	self:CDBar(297822, 12.0) -- Surging Darkness
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SeismicSlam(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SurgingDarkness(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 20.6)
	self:PlaySound(args.spellId, "long")
end

-- Fallen Servants: Inquisitor Gnshal

function mod:CriesOfTheVoid(args)
	if self:IsEngaged() then -- also in Inquisitor Gnshal's module
		self:Message(args.spellId, "red", CL.percent:format(55, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Fallen Servants: Oblivion Elemental

function mod:Hopelessness(args)
	if self:IsEngaged() then -- also in Oblivion Elemental's module
		if hopelessnessCount == 1 then
			self:Message(args.spellId, "yellow", CL.percent:format(80, CL.casting:format(args.spellName)))
		else
			self:Message(args.spellId, "yellow", CL.percent:format(40, CL.casting:format(args.spellName)))
		end
		hopelessnessCount = hopelessnessCount + 1
	end
end

function mod:HopelessnessApplied(args)
	if self:IsEngaged() and self:Me(args.destGUID) then -- also in Oblivion Elemental's module
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:HopelessnessRemoved(args)
	if self:IsEngaged() and self:Me(args.destGUID) then -- also in Oblivion Elemental's module
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Fallen Servants: Vez'okk the Lightless

function mod:DefiledGround(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alarm")
end

-- Fallen Servants: Rexxar

do
	local prev = 0
	function mod:VoidQuills(args)
		if self:IsEngaged() then -- also in Rexxar's module
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			if args.time - prev > 1.5 then
				prev = args.time
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end
