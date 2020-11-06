
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rixxa Fluxflame", 1594, 2115)
if not mod then return end
mod:RegisterEnableMob(129231)
mod.engageId = 2107
mod.respawnTime = 31

--------------------------------------------------------------------------------
-- Locals
--

local chemicalBurnCount = 0
local azeriteCatalystCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		270028, -- Azerite Catalyst
		259853, -- Chemical Burn
		{260669, "SAY", "FLASH"}, -- Propellant Blast
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "ChemicalBurnSuccess", 259856)
	self:Log("SPELL_AURA_APPLIED", "ChemicalBurnApplied", 259853)
	self:Log("SPELL_CAST_START", "PropellantBlast", 260669)
end

function mod:OnEngage()
	chemicalBurnCount = 0
	azeriteCatalystCount = 0
	self:Bar(270028, 4) -- Azerite Catalyst
	self:Bar(259853, 12.5) -- Chemical Burn
	self:Bar(260669, 31) -- Propellant Blast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 270028 then -- Azerite Catalyst
		azeriteCatalystCount = azeriteCatalystCount + 1
		self:Message(spellId, "red")
		self:PlaySound(spellId, "long", "watchstep")
		-- Cooldown alternates between 15 and 27, starting with 15
		self:Bar(spellId, azeriteCatalystCount % 2 == 1 and 15 or 27)
	end
end

do
	local prev = 0
	function mod:ChemicalBurnSuccess(args)
		local t = args.time
		if t-prev > 2 then -- Ignore second cast
			prev = t
			chemicalBurnCount = chemicalBurnCount + 1
			-- Cooldown alternates between 15 and 27, starting with 15
			self:Bar(259853, chemicalBurnCount % 2 == 1 and 15 or 27)
		end
	end
end

do
	local playerList = mod:NewTargetList()
	function mod:ChemicalBurnApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Me(args.destGUID) or self:Dispeller("magic") then
			self:PlaySound(args.spellId, "alarm", self:Dispeller("magic") and "dispel")
		end
		self:TargetsMessage(args.spellId, "orange", playerList, 2, nil, nil, 1)
	end
end

do
	local prev = 0
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(260669)
			self:Flash(260669)
		end
		self:TargetMessage(260669, "yellow", player)
	end

	function mod:PropellantBlast(args)
		local t = args.time
		if t-prev > 10 then
			prev = t
			self:CastBar(args.spellId, 6)
			self:Bar(args.spellId, 42)
		end
		self:PlaySound(args.spellId, "alert", "watchstep")
		self:GetBossTarget(printTarget, 0.5, args.sourceGUID)
	end
end
