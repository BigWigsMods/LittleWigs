--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skycap'n Kragg", 1754, 2102)
if not mod then return end
mod:RegisterEnableMob(126832) -- Skycap'n Kragg
mod:SetEncounterID(2093)
mod:SetRespawnTime(25)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage 1: Mounted Assault
		255952, -- Charrrrrge
		-- Stage 2: Death Rains from Above
		256005, -- Vile Bombardment
		256016, -- Vile Coating
		272046, -- Dive Bomb
		256060, -- Revitalizing Brew
		256106, -- Azerite Powder Shot
	}, {
		[255952] = -17143, -- Stage: Mounted Assault
		[256005] = -17146, -- Stage: Death Rains from Above
	}
end

function mod:OnBossEnable()
	-- Stages
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	-- Stage 1: Mounted Assault
	self:Log("SPELL_CAST_START", "Charrrrrge", 255952)

	-- Stage 2: Death Rains from Above
	self:Log("SPELL_CAST_SUCCESS", "VileBombardment", 256005)
	self:Log("SPELL_AURA_APPLIED", "VileCoatingDamage", 256016)
	self:Log("SPELL_PERIODIC_DAMAGE", "VileCoatingDamage", 256016)
	self:Log("SPELL_PERIODIC_MISSED", "VileCoatingDamage", 256016)
	self:Log("SPELL_CAST_START", "DiveBomb", 272046)
	self:Log("SPELL_CAST_SUCCESS", "RevitalizingBrew", 256060)
	self:Log("SPELL_CAST_START", "AzeritePowderShot", 256106)
end

function mod:OnEngage()
	self:CDBar(255952, 4.5) -- Charrrrrge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 256056 then -- Spawn Parrot
		self:StopBar(255952) -- Charrrrrge
		self:Message("stages", "cyan", CL.percent:format(75, CL.stage:format(2)), false)
		self:PlaySound("stages", "long", "stage2")

		self:CDBar(256005, 6.1) -- Vile Bombardment
		self:CDBar(256106, 5.3) -- Azerite Powder Shot
		if not self:Normal() then
			self:Bar(272046, 17.7) -- Dive Bomb
		end
	end
end

-- Stage 1: Mounted Assault

function mod:Charrrrrge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:Bar(args.spellId, 8.5)
end

-- Stage 2: Death Rains from Above

do
	local prevBombardment = 0
	local prevDamage = 0
	function mod:VileBombardment(args)
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
		if self:Normal() then
			self:Bar(args.spellId, 6.0)
		else
			local t = args.time
			if t - prevBombardment > 8 then
				self:Bar(args.spellId, 6.0)
			else
				self:Bar(args.spellId, 10.9)
			end
			prevBombardment = t
		end
	end

	function mod:VileCoatingDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			-- Don't show message for the first tick after vile bombardment lands
			if t - prevDamage > 2 and t - prevBombardment > 2 then
				prevDamage = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", "gtfo")
			end
		end
	end
end

function mod:DiveBomb(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 17.0)
end

function mod:RevitalizingBrew(args)
	-- this ability is only cast if the boss is < 50% health
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "interrupt")
	self:CDBar(args.spellId, 21.9)
end

function mod:AzeritePowderShot(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 10.9)
end
