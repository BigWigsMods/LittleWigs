--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Nokhud Offensive Trash", 2516)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	191847, -- Nokhud Plainstomper
	192800 -- Nokhud Lancemaster
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nokhud_plainstomper = "Nokhud Plainstomper"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Nokhud Plainstomper
		384365, -- Disruptive Shout
		384336, -- War Stomp
	}, {
		[384365] = L.nokhud_plainstomper,
	}
end

function mod:OnBossEnable()
	-- Nokhud Plainstomper
	self:Log("SPELL_CAST_START", "DisruptiveShout", 384365)
	self:Log("SPELL_CAST_START", "WarStomp", 384336)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Nokhud Plainstomper

function mod:DisruptiveShout(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:WarStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
