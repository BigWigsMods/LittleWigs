--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharus Trash", 2519)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	189235, -- Overseer Lahar
	189265, -- Qalashi Bonetender
	193293, -- Qalashi Warden
	193291, -- Apex Blazewing
	193944  -- Qalashi Lavamancer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.overseer_lahar = "Overseer Lahar"
	L.qalashi_bonetender = "Qalashi Bonetender"
	L.qalashi_warden = "Qalashi Warden"
	L.apex_blazewing = "Apex Blazewing"
	L.qalashi_lavamancer = "Qalahsi Lavamancer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Overseer Lahar
		395427, -- Burning Roar
		376186, -- Eruptive Crush
		-- Qalashi Bonetender
		372223, -- Mending Clay
		-- Qalashi Warden
		382708, -- Volcanic Guard
		-- Apex Blazewing
		381663, -- Candescent Tempest
		-- Qalashi Lavamancer
		383651, -- Molten Army
	}, {
		[395427] = L.overseer_lahar,
		[372223] = L.qalashi_bonetender,
		[382708] = L.qalashi_warden,
		[381663] = L.apex_blazewing,
		[383651] = L.qalashi_lavamancer,
	}
end

function mod:OnBossEnable()
	-- Overseer Lahar
	self:Log("SPELL_CAST_START", "BurningRoar", 395427)
	self:Log("SPELL_CAST_START", "EruptiveCrush", 376186)
	
	-- Qalashi Bonetender
	self:Log("SPELL_CAST_START", "MendingClay", 372223)
	
	-- Qalashi Warden
	self:Log("SPELL_CAST_START", "VolcanicGuard", 382708)
	
	-- Apex Blazewing
	self:Log("SPELL_AURA_APPLIED", "CandescentTempest", 381663)
	
	-- Qalashi Lavamancer
	self:Log("SPELL_CAST_START", "MoltenArmy", 383651)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Overseer Lahar

function mod:BurningRoar(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:EruptiveCrush(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Qalashi Bonetender

function mod:MendingClay(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Qalashi Warden

function mod:VolcanicGuard(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Apex Blazewing

function mod:CandescentTempest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

-- Qalashi Lavamancer

function mod:MoltenArmy(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
