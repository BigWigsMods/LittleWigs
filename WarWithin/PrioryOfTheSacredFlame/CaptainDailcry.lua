--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Captain Dailcry", 2649, 2571)
if not mod then return end
mod:RegisterEnableMob(207946) -- Captain Dailcry
mod:SetEncounterID(2847)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local isSavageMauling = false
local energyGainedDuringSavageMauling = 0
local nextSavageMauling = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		424419, -- Battle Cry
		447270, -- Hurl Spear
		{424414, "TANK"}, -- Pierce Armor
		447439, -- Savage Mauling
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BattleCry", 424419)
	self:Log("SPELL_CAST_SUCCESS", "BattleCrySuccess", 424419)
	self:Log("SPELL_CAST_START", "HurlSpear", 447270)
	self:Log("SPELL_CAST_START", "PierceArmor", 424414)
	self:Log("SPELL_CAST_SUCCESS", "SavageMauling", 447439)
	self:Log("SPELL_AURA_REMOVED", "SavageMaulingRemoved", 447443)
end

function mod:OnEngage()
	local t = GetTime()
	isSavageMauling = false
	energyGainedDuringSavageMauling = 0
	self:CDBar(424414, 5.2) -- Pierce Armor
	self:CDBar(447270, 8.1) -- Hurl Spear
	self:CDBar(424419, 12.0) -- Battle Cry
	nextSavageMauling = t + 14.4
	self:CDBar(447439, 14.4) -- Savage Mauling
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BattleCry(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 30.3)
	self:PlaySound(args.spellId, "warning")
end

function mod:BattleCrySuccess()
	-- boss and any engaged mini-bosses all gain 50 energy
	local t = GetTime()
	-- Dailcry: subtracts 12.5s from Savage Mauling cooldown
	if not isSavageMauling then
		nextSavageMauling = nextSavageMauling - 12.5
		local savageMaulingTimeLeft = nextSavageMauling - t
		if savageMaulingTimeLeft > 0 then
			self:CDBar(447439, {savageMaulingTimeLeft, 25.7}) -- Savage Mauling
		else
			-- set to very small duration so bar will pause on next frame
			self:CDBar(447439, {0.01, 25.7}) -- Savage Mauling
		end
	else
		-- there is a bug where Dailcry can cast this while he still has the shield, he
		-- gains 50 energy if successful despite his energy gain still being paused.
		energyGainedDuringSavageMauling = energyGainedDuringSavageMauling + 50
	end
	-- TODO the mini-bosses also get cooldown reduced on one of their abilities
end

function mod:HurlSpear(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:PierceArmor(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:SavageMauling(args)
	energyGainedDuringSavageMauling = 0
	self:StopBar(args.spellId)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:SavageMaulingRemoved(args)
	local t = GetTime()
	self:Message(447439, "green", CL.over:format(args.spellName))
	-- Savage Mauling is cast at 100 energy, 25s energy gain starts now
	local timeUntilSavageMauling = 25.7 - energyGainedDuringSavageMauling / 4
	nextSavageMauling = t + timeUntilSavageMauling
	self:CDBar(447439, timeUntilSavageMauling)
	self:PlaySound(447439, "info")
end
