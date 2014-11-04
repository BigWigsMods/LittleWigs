
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sadana Bloodfury", 969, 1139)
if not mod then return end
mod:RegisterEnableMob(75509)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.custom_on_markadd = "Mark the Dark Communion Add"
	L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with a skull, requires promoted or leader."
	L.custom_on_markadd_icon = 8
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		164974, -- Dark Eclipse
		153240, -- Daggerfall
		153153, -- Dark Communion
		"custom_on_markadd", -- Add marker option
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	-- XXX Currently doesn't fire IEEU, rely on the old fashioned engage
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:Log("SPELL_CAST_SUCCESS", "DarkEclipse", 164974)
	self:Log("SPELL_CAST_SUCCESS", "Daggerfall", 153240)
	self:Log("SPELL_CAST_SUCCESS", "DarkCommunion", 153153)

	self:Death("Win", 75509)
end

function mod:OnEngage()
	self:CDBar(164974, 59) -- Dark Eclipse
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkEclipse(args)
	self:Bar(args.spellId, 5, CL.cast:format(args.spellName))
	--self:CDBar(args.spellId, 0) 48.2, 73.9, 51.9, 
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

do
	local function printTarget(self) -- XXX no boss unit available to use... yet
		local bossId = self:GetUnitIdByGUID(75509)
		if not bossId then return end
		local bossTarget = bossId.."target"
		if UnitExists(bossTarget) then
			if UnitIsUnit(bossTarget, "player") then
				self:Flash(153240)
				self:Say(153240)
			end
			self:TargetMessage(153240, self:UnitName(bossTarget), "Attention", "Alert")
		end
	end
	function mod:Daggerfall(args)
		self:ScheduleTimer(printTarget, 0.1, self)
	end
end

do
	local counter, ref = 0, nil
	local function findAdd(self)
		local addId = self:GetUnitIdByGUID(75966) -- Defiled Spirit
		if addId then
			SetRaidTarget(addId, 8)
			self:CancelTimer(ref)
			ref = nil
			return
		end
		counter = counter + 1
		if counter > 20 then
			self:CancelTimer(ref)
			ref = nil
		end
	end
	function mod:DarkCommunion(args)
		self:Message(args.spellId, "Positive", "Info", CL.add_spawned)
		self:Bar(args.spellId, 61, CL.next_add)
		if self.db.profile.custom_on_markadd then
			counter = 0
			ref = self:ScheduleRepeatingTimer(findAdd, 0.5, self)
		end
	end
end

