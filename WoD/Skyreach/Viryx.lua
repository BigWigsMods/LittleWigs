--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Sage Viryx", 1209, 968)
if not mod then return end
mod:RegisterEnableMob(76266)
mod:SetEncounterID(1701)
mod:SetRespawnTime(15)
mod:SetPrivateAuraSounds({
	{153954, sound = "info"}, -- Cast Down
	{1253541, sound = "alert"}, -- Scorching Ray
	{1253543, sound = "none"}, -- Scorching Ray
})

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds_icon = "icon_petfamily_mechanical"
	L.solar_zealot = "Solar Zealot"
	L.construct = "Skyreach Shield Construct" -- NPC ID 76292
end

--------------------------------------------------------------------------------
-- Initialization
--

local solarZealotMarker = mod:AddMarkerOption(true, "npc", 8, "solar_zealot", 8)
function mod:GetOptions()
	return {
		153954, -- Cast Down
		solarZealotMarker,
		"adds",
		154055, -- Shielding
	},nil,{
		["adds"] = L.construct, -- Adds (Skyreach Shield Construct)
	}
end

function mod:OnRegister()
	-- delayed for custom locale
	solarZealotMarker = mod:AddMarkerOption(true, "npc", 8, "solar_zealot", 8)
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
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{153954, "PRIVATE"}, -- Cast Down
			{1253541, "PRIVATE"}, -- Scorching Ray
			{1253543, "PRIVATE"}, -- Scorching Ray
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetOption(solarZealotMarker) then
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
		self:TargetMessage(153954, "yellow", name)
		self:PlaySound(153954, "warning", nil, name)
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if not self:IsSecret(spellId) and spellId == 153954 then -- Cast Down
			self:GetUnitTarget(bossTarget, 0.7, self:UnitGUID(unit))
			self:CDBar(spellId, 37) -- 37-40
		elseif not self:IsSecret(spellId) and spellId == 154049 then -- Call Adds
			self:Message("adds", "red", CL.add_spawned, L.adds_icon) -- Cog icon
			self:CDBar("adds", 58, CL.add, L.adds_icon) -- 57-60
			self:PlaySound("adds", "info")
		end
	end
end

function mod:Shielding(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
end
