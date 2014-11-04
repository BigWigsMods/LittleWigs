
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Sage Viryx", 989, 968)
if not mod then return end
mod:RegisterEnableMob(76266)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.custom_on_markadd = "Mark the Solar Zealot"
	L.custom_on_markadd_desc = "Mark the Solar Zealot with a skull, requires promoted or leader."
	L.custom_on_markadd_icon = 8
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153954, -- Cast Down
		"custom_on_markadd",
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")

	self:Death("Win", 76266)
end

function mod:OnEngage()
	self:CDBar(153954, 15) -- Cast Down
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	self:CheckBossStatus()
	for i = 1, 5 do
		local unit = ("boss%d"):format(i)
		local guid = UnitGUID(unit)
		if self:MobId(guid) == 76267 then -- Solar Zealot
			local unitName = self:UnitName(unit.."target")
			if unitName then -- XXX Maybe?
				self:TargetMessage(153954, unitName, "Attention", "Warning", nil, nil, true)
			end
			if self.db.profile.custom_on_markadd then
				SetRaidTarget(unit, 8)
			end
			break
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 153954 then -- Cast Down
		self:Message(spellId, "Attention", "Alert", CL.incoming:format(spellName))
		self:CDBar(spellId, 37) -- 37-40
	elseif spellId == 136522 then -- Force Demon Creator to Ride Me
		local unitName = self:UnitName(unit.."target")
		if unitName then -- XXX Maybe?
			self:TargetMessage(153954, unitName, "Attention", "Warning", nil, nil, true)
		end
	end
end

