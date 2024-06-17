
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Sage Viryx", 1209, 968)
if not mod then return end
mod:RegisterEnableMob(76266)
mod.engageId = 1701
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_markadd = "Mark the Solar Zealot"
	L.custom_on_markadd_desc = "Mark the Solar Zealot with {rt8}, requires promoted or leader."
	L.custom_on_markadd_icon = 8

	L.adds_icon = "icon_petfamily_mechanical"
	L.construct = "Skyreach Shield Construct" -- NPC ID 76292
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153954, -- Cast Down
		"custom_on_markadd",
		"adds",
		154055, -- Shielding
	},nil,{
		["adds"] = L.construct, -- Adds (Skyreach Shield Construct)
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3")

	self:Log("SPELL_CAST_START", "Shielding", 154055)
end

function mod:OnEngage()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:CDBar(153954, 15) -- Cast Down
	self:Bar("adds", 32, CL.add, L.adds_icon)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetOption("custom_on_markadd") then
		for i = 1, 5 do
			local unit = ("boss%d"):format(i)
			local guid = self:UnitGUID(unit)
			if self:MobId(guid) == 76267 then -- Solar Zealot
				self:CustomIcon(false, unit, 8)
				break
			end
		end
	end
end

do
	local function bossTarget(self, name)
		self:TargetMessageOld(153954, name, "yellow", "warning", nil, nil, true)
	end
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if spellId == 153954 then -- Cast Down
			self:GetUnitTarget(bossTarget, 0.7, self:UnitGUID(unit))
			self:CDBar(spellId, 37) -- 37-40
		elseif spellId == 154049 then -- Call Adds
			self:MessageOld("adds", "red", "info", CL.add_spawned, L.adds_icon) -- Cog icon
			self:CDBar("adds", 58, CL.add, L.adds_icon) -- 57-60
		end
	end
end

function mod:Shielding(args)
	self:MessageOld(args.spellId, "orange", "long")
end
