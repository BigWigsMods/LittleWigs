--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Iron Docks Trash", 1195)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	83025, -- Grom'kar Battlemaster
	81279, -- Grom'kar Flameslinger
	81432, -- Grom'kar Technician
	83763, -- Grom'kar Technician
	83026, -- Siegemaster Olugar
	84520, -- Pitwarden Gwarnok
	84028, -- Siegemaster Rokra
	87252, -- Unruly Ogron
	83578, -- Ogron Laborer
	83761, -- Ogron Laborer
	86526, -- Grom'kar Chainmaster
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
	L.gromkar_technician = "Grom'kar Technician"
	L.siegemaster_olugar = "Siegemaster Olugar"
	L.pitwarden_gwarnok = "Pitwarden Gwarnok"
	L.ogron_laborer = "Ogron Laborer"
	L.gromkar_chainmaster = "Grom'kar Chainmaster"
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
		-- Grom'kar Technician
		172636, -- Slippery Grease
		-- Siegemaster Olugar
		172982, -- Shattering Strike
		172952, -- Throw Gatecrasher
		172963, -- Gatecrasher
		-- Pitwarden Gwarnok
		172943, -- Brutal Inspiration
		-- Ogron Laborer
		173135, -- Thundering Stomp
		-- Grom'kar Chainmaster
		173105, -- Whirling Chains
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
		[172636] = L.gromkar_technician,
		[172982] = L.siegemaster_olugar,
		[172943] = L.pitwarden_gwarnok,
		[173135] = L.ogron_laborer,
		[173105] = L.gromkar_chainmaster,
		[167815] = L.thunderlord_wrangler,
		[173384] = L.rampaging_clefthoof,
		[173514] = L.ironwing_flamespitter,
	}
end

function mod:OnBossEnable()
	-- Grom'kar Battlemaster
	self:Log("SPELL_AURA_APPLIED", "Bladestorm", 167232)
	self:Log("SPELL_DAMAGE", "BladestormDamage", 167233)
	self:Log("SPELL_MISSED", "BladestormDamage", 167233)
	-- Grom'kar Flameslinger
	self:Log("SPELL_AURA_APPLIED", "BurningArrowsDamage", 164632)
	self:Log("SPELL_PERIODIC_DAMAGE", "BurningArrowsDamage", 164632)
	self:Log("SPELL_MISSED", "BurningArrowsDamage", 164632)
	-- Grom'kar Flameslinger
	self:Log("SPELL_AURA_APPLIED", "SlipperyGreaseApplied", 172636, 172631) -- Slippery Grease, Knocked Down
	-- Siegemaster Olugar
	self:Log("SPELL_CAST_START", "ShatteringStrike", 172982)
	self:Log("SPELL_CAST_START", "ThrowGatecrasher", 172952)
	self:Log("SPELL_AURA_APPLIED", "GatecrasherDamage", 172963)
	self:Log("SPELL_PERIODIC_DAMAGE", "GatecrasherDamage", 172963)
	self:Log("SPELL_MISSED", "GatecrasherDamage", 172963)
	-- Pitwarden Gwarnok
	self:Log("SPELL_AURA_APPLIED", "BrutalInspiration", 172943)
	-- Ogron Laborer
	self:Log("SPELL_CAST_START", "ThunderingStomp", 173135)
	-- Grom'kar Chainmaster
	self:Log("SPELL_AURA_APPLIED", "WhirlingChains", 173108)
	self:Log("SPELL_AURA_APPLIED", "WhirlingChainsDamage", 173105)
	self:Log("SPELL_PERIODIC_DAMAGE", "WhirlingChainsDamage", 173105)
	self:Log("SPELL_MISSED", "WhirlingChainsDamage", 173105)
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
	self:Log("SPELL_AURA_APPLIED", "LavaBarrageDamage", 173489)
	self:Log("SPELL_AURA_REFRESH", "LavaBarrageDamage", 173489)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Grom'kar Battlemaster

function mod:Bladestorm(args)
	self:Message(167233, "red")
	self:PlaySound(167233, "alarm")
end

do
	local prev = 0
	function mod:BladestormDamage(args)
		if self:Me(args.destGUID) and not self:Tank() then
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

-- Grom'kar Technician

do
	local prev = 0
	function mod:SlipperyGreaseApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(172636, "blue", CL.underyou:format(self:SpellName(172636)))
				self:PlaySound(172636, "underyou")
			end
		end
	end
end

-- Siegemaster Olugar

function mod:ShatteringStrike(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ThrowGatecrasher(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end

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

-- Pitwarden Gwarnok

function mod:BrutalInspiration(args)
	if self:MobId(args.destGUID) == 172943 then -- Pitwarden Gwarnok, to avoid spam on this AOE buff
		self:Message(args.spellId, "purple", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Ogron Laborer

function mod:ThunderingStomp(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Grom'kar Chainmaster

do
	local prev = 0
	function mod:WhirlingChains(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(173105, "yellow")
			self:PlaySound(173105, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:WhirlingChainsDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(173105, "near")
				self:PlaySound(173105, "underyou")
			end
		end
	end
end

-- Thunderlord Wrangler

do
	local prev = 0
	function mod:RendingCleave(args)
		local t = args.time
		if t - prev > 2.5 then
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

do
	local prev = 0
	function mod:LavaBarrageDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(173480, "near")
				self:PlaySound(173480, "underyou")
			end
		end
	end
end
