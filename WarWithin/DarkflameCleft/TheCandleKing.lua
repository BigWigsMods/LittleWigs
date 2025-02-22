local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Candle King", 2651, 2560)
if not mod then return end
mod:RegisterEnableMob(208745) -- The Candle King
mod:SetEncounterID(2787)
mod:SetRespawnTime(30)
if not isElevenDotOne then
	mod:SetPrivateAuraSounds({
		420696, -- Throw Darkflame
	})
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		420659, -- Eerie Molds
		{422648, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Darkflame Pickaxe
		426145, -- Paranoid Mind
		{420696, "PRIVATE"}, -- Throw Darkflame
		421067, -- Molten Wax
		-- Mythic
		421653, -- Cursed Wax
	}, {
		[421653] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "EerieMolds", 420659)
	self:Log("SPELL_CAST_SUCCESS", "DarkflamePickaxe", 422648)
	self:Log("SPELL_AURA_REMOVED", "DarkflamePickaxeRemoved", 422648)
	self:Log("SPELL_CAST_START", "ParanoidMind", 426145)
	if isElevenDotOne then
		self:Log("SPELL_CAST_SUCCESS", "ThrowDarkflame", 420696)
		self:Log("SPELL_AURA_APPLIED", "ThrowDarkflameApplied", 420696)
	else -- XXX remove in 11.1
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Throw Darkflame
	end
	self:Log("SPELL_PERIODIC_DAMAGE", "MoltenWaxDamage", 421067)
	self:Log("SPELL_PERIODIC_MISSED", "MoltenWaxDamage", 421067)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "CursedWaxApplied", 421653)
end

function mod:OnEngage()
	self:CDBar(420659, 6.0) -- Eerie Molds
	self:CDBar(426145, 10.5) -- Paranoid Mind
	self:CDBar(422648, 13.2) -- Darkflame Pickaxe
	self:CDBar(420696, 19.3) -- Throw Darkflame
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EerieMolds(args)
	self:Message(args.spellId, "cyan")
	if self:Mythic() then
		self:CDBar(args.spellId, 21.8)
	else -- Normal
		self:CDBar(args.spellId, 31.5)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:DarkflamePickaxe(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	if self:Mythic() then
		self:CDBar(args.spellId, 21.8)
	else -- Normal
		self:CDBar(args.spellId, 17.0)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Darkflame Pickaxe")
		-- TODO what is the cast time in heroic?
		if self:Mythic() then
			self:SayCountdown(args.spellId, 4)
		else -- Normal
			self:SayCountdown(args.spellId, 6)
		end
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:DarkflamePickaxeRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:ParanoidMind(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Mythic() then
		self:CDBar(args.spellId, 10.9)
	else -- Normal
		self:CDBar(args.spellId, 20.6)
	end
	self:PlaySound(args.spellId, "alert")
end

do
	local playerList = {}

	function mod:ThrowDarkflame(args)
		playerList = {}
		if self:Mythic() then
			self:CDBar(args.spellId, 21.8)
		else -- Normal
			self:CDBar(args.spellId, 17.0)
		end
	end

	function mod:ThrowDarkflameApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "orange", playerList, 3) -- TODO how many targets in Normal/Heroic?
		self:PlaySound(args.spellId, "alert", nil, playerList)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId) -- XXX remove in 11.1
	if spellId == 420696 then -- Throw Darkflame
		self:Message(spellId, "orange")
		self:CDBar(spellId, 17.0) -- TODO often delayed
		--self:PlaySound(spellId, "alarm") private aura sound
	end
end

do
	local prev = 0
	function mod:MoltenWaxDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Mythic

function mod:CursedWaxApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
	end
end
