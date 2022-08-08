--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Iron Docks Trash", 1195)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	83025, -- Grom'kar Battlemaster
	84520, -- Pitwarden Gwarnok
	81279, -- Grom'kar Flameslinger
	83026, -- Siegemaster Olugar
	84028, -- Siegemaster Rokra
	83578, -- Ogron Laborer
	83761  -- Ogron Laborer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.gromkar_battlemaster = "Grom'kar Battlemaster"
	L.gromkar_flameslinger = "Grom'kar Flameslinger"
	L.siegemaster_olugar = "Siegemaster Olugar"
	L.ogron_laborer = "Ogron Laborer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Grom'kar Battlemaster
		167233, -- Bladestorm
		-- Grom'kar Flameslinger
		164632, -- Bladestorm
		-- Siegemaster Olugar
		172963, -- Bladestorm
		-- Ogron Laborer
		173135, -- Thundering Stomp
	}, {
		[167233] = L.gromkar_battlemaster,
		[164632] = L.gromkar_flameslinger,
		[172963] = L.siegemaster_olugar,
		[173135] = L.ogron_laborer,
	}
end

function mod:OnBossEnable()
	-- Grom'kar Battlemaster
	self:Log("SPELL_CAST_START", "Bladestorm", 167233)
	self:Log("SPELL_DAMAGE", "BladestormDamage", 167233)
	self:Log("SPELL_MISSED", "BladestormDamage", 167233)
	-- Grom'kar Flameslinger
	self:Log("SPELL_AURA_APPLIED", "BurningArrowsDamage", 164632)
	self:Log("SPELL_PERIODIC_DAMAGE", "BurningArrowsDamage", 164632)
	self:Log("SPELL_PERIODIC_MISSED", "BurningArrowsDamage", 164632)
	-- Siegemaster Olugar
	self:Log("SPELL_AURA_APPLIED", "GatecrasherDamage", 172963)
	self:Log("SPELL_PERIODIC_DAMAGE", "GatecrasherDamage", 172963)
	self:Log("SPELL_PERIODIC_MISSED", "GatecrasherDamage", 172963)
	-- Ogron Laborer
	self:Log("SPELL_CAST_START", "ThunderingStomp", 173135)
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

-- Grom'kar Flameslinger

do
	local prev = 0
	function mod:BurningArrowsDamage(args)
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

-- Siegemaster Olugar

do
	local prev = 0
	function mod:GatecrasherDamage(args)
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

-- Siegemaster Olugar

function mod:ThunderingStomp(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
