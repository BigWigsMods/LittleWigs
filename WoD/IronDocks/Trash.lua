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
	87252, -- Unruly Ogron
	83578, -- Ogron Laborer
	83761, -- Ogron Laborer
	83390, -- Thunderlord Wrangler
	83392, -- Rampaging Clefthoof
	83389  -- Ironwing Flamespitter
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
	L.thunderlord_wrangler = "Thunderlord Wrangler"
	L.rampaging_clefthoof = "Rampaging Clefthoof"
	L.ironwing_flamespitter = "Ironwing Flamespitter"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Grom'kar Battlemaster
		167233, -- Bladestorm
		-- Grom'kar Flameslinger
		164632, -- Burning Arrows
		-- Siegemaster Olugar
		172963, -- Gatecrasher
		-- Ogron Laborer
		173135, -- Thundering Stomp
		-- Thunderlord Wrangler
		167815, -- Rending Cleave
		173324, -- Jagged Caltrops
		-- Rampaging Clefthoof
		173384, -- Trampling Stampede
		158337, -- Frenzy
		-- Ironwing Flamespitter
		173514, -- Lava Blast
		173480, -- Lava Barrage
	}, {
		[167233] = L.gromkar_battlemaster,
		[164632] = L.gromkar_flameslinger,
		[172963] = L.siegemaster_olugar,
		[173135] = L.ogron_laborer,
		[167815] = L.thunderlord_wrangler,
		[173384] = L.rampaging_clefthoof,
		[173514] = L.ironwing_flamespitter,
	}
end

function mod:OnBossEnable()
	-- Grom'kar Battlemaster
	self:Log("SPELL_CAST_SUCCESS", "Bladestorm", 167233)
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
	-- Thunderlord Wrangler
	self:Log("SPELL_CAST_START", "RendingCleave", 167815)
	self:Log("SPELL_AURA_APPLIED", "JaggedCaltropsDamage", 173324)
	self:Log("SPELL_PERIODIC_DAMAGE", "JaggedCaltropsDamage", 173324)
	self:Log("SPELL_PERIODIC_MISSED", "JaggedCaltropsDamage", 173324)
	-- Rampaging Clefthoof
	self:Log("SPELL_CAST_START", "TramplingStampede", 173384)
	self:Log("SPELL_AURA_APPLIED", "FrenzyApplied", 158337)
	-- Ironwing Flamespitter
	self:Log("SPELL_CAST_START", "LavaBlast", 173514)
	self:Log("SPELL_CAST_START", "LavaBarrage", 173480)
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

-- Thunderlord Wrangler
do
	local prev = 0
	function mod:RendingCleave(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:JaggedCaltropsDamage(args)
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

-- Rampaging Clefthoof

function mod:TramplingStampede(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:FrenzyApplied(args)
	if self:Tank() or self:Healer() or self:Dispeller("enrage", true) then
		self:Message(args.spellId, "orange", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Ironwing Flamespitter

function mod:LavaBlast(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:LavaBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end
