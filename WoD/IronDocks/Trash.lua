--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Iron Docks Trash", 1195)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	83025, -- Grom'kar Battlemaster
	84520  -- Pitwarden Gwarnok
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.gromkar_battlemaster = "Grom'kar Battlemaster"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Grom'kar Battlemaster
		167233, -- Bladestorm
	}, {
		[167233] = L.gromkar_battlemaster,
	}
end

function mod:OnBossEnable()
	-- Grom'kar Battlemaster
	self:Log("SPELL_CAST_START", "Bladestorm", 167233)
	self:Log("SPELL_DAMAGE", "BladestormDamage", 167233)
	self:Log("SPELL_MISSED", "BladestormDamage", 167233)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Grom'kar Battlemaster

function mod:Bladestorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:BladestormDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end
