--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Candle King", 2651, 2560)
if not mod then return end
mod:RegisterEnableMob(208745) -- The Candle King
mod:SetEncounterID(2787)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		420659, -- Eerie Molds
		{422648, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Darkflame Pickaxe
		426145, -- Paranoid Mind
		420696, -- Throw Darkflame
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
	self:Log("SPELL_CAST_SUCCESS", "ThrowDarkflame", 420696)
	self:Log("SPELL_AURA_APPLIED", "ThrowDarkflameApplied", 420696)
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
		self:CDBar(args.spellId, 23.1)
	else -- Normal, Heroic
		self:CDBar(args.spellId, 31.5)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:DarkflamePickaxe(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Mythic() then
		self:CDBar(args.spellId, 23.1)
	else -- Normal, Heroic
		self:CDBar(args.spellId, 17.0)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Darkflame Pickaxe")
		self:SayCountdown(args.spellId, 6)
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
	else -- Normal, Heroic
		self:CDBar(args.spellId, 20.6)
	end
	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:PlaySound(args.spellId, "warning")
	end
end

do
	local playerList = {}

	function mod:ThrowDarkflame(args)
		playerList = {}
		if self:Mythic() then
			self:CDBar(args.spellId, 24.3)
		else -- Normal, Heroic
			self:CDBar(args.spellId, 17.0)
		end
	end

	function mod:ThrowDarkflameApplied(args)
		playerList[#playerList + 1] = args.destName
		if self:Mythic() or self:Heroic() then
			self:TargetsMessage(args.spellId, "orange", playerList, 3)
		else -- Normal
			self:TargetsMessage(args.spellId, "orange", playerList, 2)
		end
		self:PlaySound(args.spellId, "alert", nil, playerList)
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
