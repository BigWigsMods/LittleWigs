local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rixxa Fluxflame", 1594, 2115)
if not mod then return end
mod:RegisterEnableMob(129231) -- Rixxa Fluxflame
mod:SetEncounterID(2107)
mod:SetRespawnTime(31)

--------------------------------------------------------------------------------
-- Locals
--

local chemicalBurnCount = 1
local azeriteCatalystCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{259856, "DISPEL"}, -- Chemical Burn
		270042, -- Azerite Catalyst
		259940, -- Propellant Blast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ChemicalBurn", 259856)
	self:Log("SPELL_AURA_APPLIED", "ChemicalBurnApplied", 259853)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "AzeriteCatalyst", 270042)
	else
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- XXX remove in 11.1
	end
	self:Log("SPELL_PERIODIC_DAMAGE", "AzeriteCatalystDamage", 259533)
	self:Log("SPELL_PERIODIC_MISSED", "AzeriteCatalystDamage", 259533)
	--self:Log("SPELL_AURA_APPLIED", "AzeriteCatalystApplied", 270042)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "PropellantBlast", 259940)
	else
		self:Log("SPELL_CAST_START", "PropellantBlast", 260669) -- XXX remove in 11.1
	end
end

function mod:OnEngage()
	chemicalBurnCount = 1
	azeriteCatalystCount = 1
	self:CDBar(270042, 6.0) -- Azerite Catalyst
	self:CDBar(259856, 14.5) -- Chemical Burn
	self:CDBar(259940, 31.0) -- Propellant Blast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}
	local prev = 0

	function mod:ChemicalBurn(args)
		if args.time - prev > 3 then -- occasionally cast multiple times in a row
			prev = args.time
			playerList = {}
			chemicalBurnCount = chemicalBurnCount + 1
			if chemicalBurnCount % 2 == 0 then
				self:CDBar(args.spellId, 15.0)
			else
				self:CDBar(args.spellId, 27.0)
			end
		end
	end

	function mod:ChemicalBurnApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, 259856) then
			self:TargetsMessage(259856, "orange", playerList, 2, nil, nil, 1)
			self:PlaySound(259856, "info", nil, playerList)
		end
	end
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(270042, "red", player)
		self:PlaySound(270042, "long", nil, player)
	end

	function mod:AzeriteCatalyst(args)
		azeriteCatalystCount = azeriteCatalystCount + 1
		if azeriteCatalystCount % 2 == 0 then
			self:CDBar(args.spellId, 15.0)
		else
			self:CDBar(args.spellId, 27.0)
		end
		-- takes up to .4s to target sometimes
		self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId) -- XXX remove in 11.1
	if spellId == 270028 then -- Azerite Catalyst
		azeriteCatalystCount = azeriteCatalystCount + 1
		self:Message(270042, "red")
		self:PlaySound(270042, "long")
		-- Cooldown alternates between 15 and 27, starting with 15
		self:CDBar(270042, azeriteCatalystCount % 2 == 1 and 15 or 27)
	end
end

--function mod:AzeriteCatalystApplied(args)
	-- happens too late
	--self:TargetMessage(args.spellId, "red", args.destName)
	--self:PlaySound(args.spellId, "long", nil, args.destName)
--end

do
	local prev = 0
	function mod:AzeriteCatalystDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(270042, "underyou")
			self:PlaySound(270042, "underyou")
		end
	end
end

--do
	--local function printTarget(self, player, guid)
		--self:TargetMessage(259940, "yellow", player, CL.count_amount:format(self:SpellName(259940), 1, 2))
		--if self:Me(guid) then
			--self:Say(259940, nil, nil, "Propellant Blast")
		--end
		--self:PlaySound(259940, "alert", nil, player)
	--end

	do
		local prev = 0
		function mod:PropellantBlast(args)
			-- always cast twice in a row, only start a bar for the first cast
			if args.time - prev > 10 then
				prev = args.time
				self:CDBar(259940, 42.0)
				-- takes up to .3s to target for the first cast, but the second cast seems
				-- to take up to .9s so can't be target scanned.
				-- also sometimes boss changes targets 22 times over 2.3 seconds so disable target scanning for now
				--self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
				self:Message(259940, "yellow", CL.count_amount:format(args.spellName, 1, 2))
				self:PlaySound(259940, "alert")
			else
				self:Message(259940, "yellow", CL.count_amount:format(args.spellName, 2, 2))
				self:PlaySound(259940, "alert")
			end
		end
	end
--end
