--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gold Elemental", 2826)
if not mod then return end
mod:RegisterEnableMob(
	234932, -- Gold Shaman
	234919 -- Gold Elemental
)
mod:SetEncounterID(3104)
--mod:SetRespawnTime(15) resets, doesn't respawn
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.gold_elemental = "Gold Elemental"
	L.gold_shaman = "Gold Shaman"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.gold_elemental
end

function mod:GetOptions()
	return {
		-- Gold Shaman
		473696, -- Molotov Cocktail
	}, {
		[473696] = L.gold_shaman,
	}
end

function mod:OnBossEnable()
	-- Gold Elemental doesn't actually cast anything, the only abilities are
	-- from the Gold Shaman mobs you need to kill to activate the boss.

	-- Gold Shaman
	self:Log("SPELL_CAST_SUCCESS", "MolotovCocktail", 473696)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:MolotovCocktail(args)
		-- also cast by Flinging Flicker
		if args.time - prev > 2 and self:MobId(args.sourceGUID) == 234932 then -- Gold Shaman
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
