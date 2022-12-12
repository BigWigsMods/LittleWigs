--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharus Trash", 2519)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	189235, -- Overseer Lahar
	189265, -- Qalashi Bonetender
	193293  -- Qalashi Warden
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.overseer_lahar = "Overseer Lahar"
	L.qalashi_bonetender = "Qalashi Bonetender"
	L.qalashi_warden = "Qalashi Warden"
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
	}, {
		[395427] = L.overseer_lahar,
		[372223] = L.qalashi_bonetender,
		[382708] = L.qalashi_warden,
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
