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

local azeriteCatalystCount = 1
local propellantBlastCount = 1
local chemicalBurnCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		270042, -- Azerite Catalyst
		{259940, "SAY"}, -- Propellant Blast
		275992, -- Gushing Catalyst
		{259856, "DISPEL"}, -- Chemical Burn
	}, {
		[275992] = CL.mythic,
		[259856] = CL.normal.." / "..CL.heroic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AzeriteCatalyst", 270042)
	self:Log("SPELL_PERIODIC_DAMAGE", "AzeriteCatalystDamage", 259533)
	self:Log("SPELL_PERIODIC_MISSED", "AzeriteCatalystDamage", 259533)
	--self:Log("SPELL_AURA_APPLIED", "AzeriteCatalystApplied", 270042)
	self:Log("SPELL_CAST_START", "PropellantBlast", 259940)

	-- Mythic
	self:Log("SPELL_CAST_SUCCESS", "GushingCatalyst", 275992)

	-- Normal / Heroic
	self:Log("SPELL_CAST_SUCCESS", "ChemicalBurn", 259856) -- XXX removed from journal in 11.1, but still cast in Normal
	self:Log("SPELL_AURA_APPLIED", "ChemicalBurnApplied", 259853) -- XXX removed from journal in 11.1, but still cast in Normal
end

function mod:OnEngage()
	azeriteCatalystCount = 1
	propellantBlastCount = 1
	chemicalBurnCount = 1
	if self:Mythic() then
		self:CDBar(275992, 3.0) -- Gushing Catalyst
		self:CDBar(270042, 10.0) -- Azerite Catalyst
		self:CDBar(259940, 22.0) -- Propellant Blast
	else -- Normal, Heroic
		self:CDBar(270042, 6.0) -- Azerite Catalyst
		self:CDBar(259856, 14.5) -- Chemical Burn
		self:CDBar(259940, 31.0) -- Propellant Blast
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, player, guid)
		self:TargetMessage(270042, "red", player)
		self:PlaySound(270042, "long", nil, player)
	end

	function mod:AzeriteCatalyst(args)
		if self:Mythic() then
			self:CDBar(args.spellId, 53.0)
		else
			azeriteCatalystCount = azeriteCatalystCount + 1
			if azeriteCatalystCount % 2 == 0 then
				self:CDBar(args.spellId, 15.0)
			else
				self:CDBar(args.spellId, 27.0)
			end
		end
		-- takes up to .4s to target sometimes
		self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
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

do
	local function printTarget(self, player, guid)
		self:TargetMessage(259940, "yellow", player, CL.count_amount:format(self:SpellName(259940), (propellantBlastCount - 2) % 3 + 1, 3))
		if self:Me(guid) then
			self:Say(259940, nil, nil, "Propellant Blast")
		end
		self:PlaySound(259940, "alert", nil, player)
	end

	do
		local prev = 0
		function mod:PropellantBlast(args)
			if self:Mythic() then
				local propellantBlastSequence = (propellantBlastCount - 1) % 3 + 1
				propellantBlastCount = propellantBlastCount + 1
				self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
				if propellantBlastSequence == 3 then
					self:CDBar(args.spellId, 31.0)
				else
					self:CDBar(args.spellId, 11.0)
				end
			else -- Normal / Heroic
				-- always cast twice in a row, only start a bar for the first cast
				if args.time - prev > 10 then
					prev = args.time
					self:CDBar(args.spellId, 42.0)
					-- takes up to .3s to target for the first cast, but the second cast seems
					-- to take up to .9s so can't be target scanned.
					-- also sometimes boss changes targets 22 times over 2.3 seconds so disable target scanning for now
					--self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
					self:Message(args.spellId, "yellow", CL.count_amount:format(args.spellName, 1, 2))
					self:PlaySound(args.spellId, "alert")
				else
					self:Message(args.spellId, "yellow", CL.count_amount:format(args.spellName, 2, 2))
					self:PlaySound(args.spellId, "alert")
				end
			end
		end
	end
end

-- Mythic

function mod:GushingCatalyst(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 53.0)
	self:PlaySound(args.spellId, "alarm")
end

-- Normal / Heroic

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
