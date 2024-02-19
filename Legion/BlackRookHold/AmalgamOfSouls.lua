--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Amalgam of Souls", 1501, 1518)
if not mod then return end
mod:RegisterEnableMob(98542) -- Amalgam of Souls
mod:SetEncounterID(1832)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local soulgorgeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Stage One: The Amalgam of Souls
		194956, -- Reap Soul
		{195254, "SAY"}, -- Swirling Scythe
		{194966, "SAY"}, -- Soul Echoes
		-- Stage Two: The Call of Souls
		196078, -- Call Souls
		196930, -- Soulgorge
		196587, -- Soul Burst
	}, {
		[194956] = -12241, -- Stage One: The Amalgam of Souls
		[196078] = -12245, -- Stage Two: The Call of Souls
	}
end

function mod:OnBossEnable()
	-- Stage One: The Amalgam of Souls
	self:Log("SPELL_CAST_START", "ReapSoul", 194956)
	self:Log("SPELL_CAST_START", "SwirlingScythe", 195254)
	self:Log("SPELL_CAST_SUCCESS", "SoulEchoes", 194966)
	self:Log("SPELL_AURA_APPLIED", "SoulEchoesApplied", 194966)

	-- Stage Two: The Call of Souls
	self:Log("SPELL_CAST_START", "CallSouls", 196078)
	self:Log("SPELL_AURA_APPLIED", "SoulgorgeApplied", 196930)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SoulgorgeApplied", 196930)
	self:Log("SPELL_CAST_START", "SoulBurst", 196587)
	self:Log("SPELL_CAST_SUCCESS", "SoulBurstSuccess", 196587)
end

function mod:OnEngage()
	soulgorgeCount = 0
	self:SetStage(1)
	self:CDBar(195254, 8.1) -- Swirling Scythe
	self:CDBar(194966, 16.9) -- Soul Echoes
	self:CDBar(194956, 20.2) -- Reap Soul
end

function mod:OnWin()
    local trashMod = BigWigs:GetBossModule("Black Rook Hold Trash", true)
    if trashMod then
        trashMod:Enable()
        trashMod:AmalgamOfSoulsDefeated()
    end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: The Amalgam of Souls

function mod:ReapSoul(args)
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 13.4)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(195254, "yellow", name)
		self:PlaySound(195254, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(195254, nil, nil, "Swirling Scythe")
		end
	end

	function mod:SwirlingScythe(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:CDBar(args.spellId, 20.6)
	end
end

function mod:SoulEchoes(args)
	if self:MobId(args.sourceGUID) ~= 98542 then -- Amalgam of Souls
		-- this is also cast by a trash miniboss
		return
	end
	self:CDBar(args.spellId, 26.7)
end

function mod:SoulEchoesApplied(args)
	if self:MobId(args.sourceGUID) ~= 98542 then -- Amalgam of Souls
		-- this is also cast by a trash miniboss
		return
	end
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Soul Echoes")
	end
end

-- Stage Two: The Call of Souls

function mod:CallSouls(args)
	soulgorgeCount = 0
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "long")
	self:StopBar(195254) -- Swirling Scythe
	self:StopBar(194966) -- Soul Echoes
	self:StopBar(194956) -- Reap Soul
end

function mod:SoulgorgeApplied(args)
	if self:MobId(args.destGUID) ~= 98542 then -- Amalgam of Souls
		-- this is also applied on the adds, ignore those
		return
	end
	soulgorgeCount = args.amount or 1
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, soulgorgeCount))
	self:PlaySound(args.spellId, "alert")
end

function mod:SoulBurst(args)
	if soulgorgeCount > 0 then
		self:Message(args.spellId, "orange", CL.count:format(args.spellName, soulgorgeCount))
	else
		self:Message(args.spellId, "orange")
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:SoulBurstSuccess()
	self:SetStage(1)
	self:CDBar(195254, 9.2) -- Swirling Scythe
	self:CDBar(194966, 18.0) -- Soul Echoes
	self:CDBar(194956, 21.4) -- Reap Soul
end
