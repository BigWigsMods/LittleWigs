--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cragmaw the Infested", 1841, 2131)
if not mod then return end

mod:RegisterEnableMob(131817) -- Cragmaw the Infested
mod:SetEncounterID(2118)
mod:SetRespawnTime(25)

--------------------------------------------------------------------------------
-- Locals
--

local chargeCount = 1
local tantrumCount = 1
local indigestionCount = 1
local timeAddedToCharge = 0

local chargeTimers = {
        8.5,21.9,29.3,
        23.1,28,21.9,
        29.2,28.4,20.7,
        28,20,28,20,29,
        21,28,21,28,28,
        23,28,21.5,28,22
}
local indigestionTimers = {
    18,52,50,51,50,49,48,55,46,55,51,50
}
local tantrumTimers = {
    45,45,47.5,45,45,46.5,47,45,45,45,45,45,46
}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
    return {
        260292, -- Charge
        260793, -- Indigestion
        260333, -- Tantrum
    }, {
        [260292] = "general",
        [260333] = "heroic",
    }
end

function mod:OnBossEnable()
    self:Log("SPELL_CAST_START", "Charge", 260292)
    self:Log("SPELL_CAST_START", "Indigestion", 260793)

    -- Heroic+
    self:Log("SPELL_CAST_SUCCESS", "Tantrum", 260333)
end

function mod:OnEngage()
    chargeCount = 1
    tantrumCount = 1
    indigestionCount = 1
    timeAddedToCharge = 0
    self:CDBar(260292, chargeTimers[chargeCount]) -- Charge
    self:CDBar(260793, indigestionTimers[indigestionCount]) -- Indigestion
    if not self:Normal() then
        self:CDBar(260333, tantrumTimers[tantrumCount], CL.count:format(self:SpellName(260333), tantrumCount)) -- Charge self:CDBar(260333, 45.0, CL.count:format(self:SpellName(260333), tantrumCount)) -- Tantrum
    end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Charge(args)
    -- timeAddedToCharge = 0
    self:Message(args.spellId, "yellow")
    self:PlaySound(args.spellId, "alert", "watchstep")
    chargeCount = chargeCount + 1
    if chargeTimers[chargeCount] then
        self:CDBar(args.spellId, chargeTimers[chargeCount])
    else
        self:CDBar(args.spellId, 20.6)
	    -- minimum 10.5s before Indigestion after Charge
        if self:BarTimeLeft(260793) < 10.5 then -- Indigestion
            self:CDBar(260793, {10.5, 44.9})
        end
    end
end

function mod:Indigestion(args)
    self:Message(args.spellId, "purple")
    self:PlaySound(args.spellId, "alarm", "mobsoon")
    indigestionCount = indigestionCount + 1
    if indigestionTimers[indigestionCount] then
        self:CDBar(args.spellId, indigestionTimers[indigestionCount]) -- Indigestion
    else
        self:CDBar(args.spellId, 44.9)
        -- minimum 12.15s before Charge after Indigestion
        local chargeTimeLeft = self:BarTimeLeft(260292) -- Charge
        if chargeTimeLeft < 12.15 then -- Charge
            timeAddedToCharge = 12.15 - chargeTimeLeft
            self:CDBar(260292, {12.15, 20.6})
        end
    end
end

function mod:Tantrum(args)
    local tantrumMessage = CL.count:format(args.spellName, tantrumCount)
    self:StopBar(tantrumMessage)
    self:Message(args.spellId, "orange", tantrumMessage)
    self:PlaySound(args.spellId, "long", "mobsoon")
    tantrumCount = tantrumCount + 1
    if tantrumTimers[tantrumCount] then
        self:CDBar(args.spellId, tantrumTimers[tantrumCount], CL.count:format(self:SpellName(260333), tantrumCount))
    else
        self:CDBar(args.spellId, 44.9, CL.count:format(args.spellName, tantrumCount))
        if self:MythicPlus() then
            -- minimum 18.2 seconds before either ability can be cast
            if self:BarTimeLeft(260292) < 18.2 then -- Charge
                self:CDBar(260292, {18.2, 20.6})
            end
            if self:BarTimeLeft(260793) < 18.2 then -- Indigestion
                self:CDBar(260793, {18.2, 44.9})
            end
        else
            -- minimum 7.26 seconds before either ability can be cast, and
            -- additionally 7.26s is added to the Charge timer.
            local chargeTimeLeft = self:BarTimeLeft(260292) -- Charge
            if chargeTimeLeft > .1 and chargeTimeLeft > timeAddedToCharge then
                -- subtract any time added to Charge by Indigestion
                self:CDBar(260292, {chargeTimeLeft - timeAddedToCharge + 7.26, 27.86})
            else
                self:CDBar(260292, {7.26, 20.6})
            end
            if self:BarTimeLeft(260793) < 7.26 then -- Indigestion
                self:CDBar(260793, {7.26, 44.9})
            end
        end
    end
end
