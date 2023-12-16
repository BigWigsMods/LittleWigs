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
		-- Stage 1: Mounted Assault
		255952, -- Charrrrrge
		256056, -- Spawn Parrot
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
	self:Log("SPELL_CAST_SUCCESS", "SpawnParrot", 256056)

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
	self:CDBar(255952, 3.6) -- Charrrrrge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:SpawnParrot(args)
	self:Message(args.spellId, "cyan", CL.percent:format(75, args.spellName))
	self:PlaySound(args.spellId, "long")
	self:StopBar(255952) -- Charrrrrge
	self:CDBar(256005, 2.4) -- Vile Bombardment
	self:CDBar(256106, 5.3) -- Azerite Powder Shot
	if not self:Normal() then
		self:CDBar(272046, 14.0) -- Dive Bomb
	end
end

-- Stage 1: Mounted Assault

function mod:Charrrrrge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	-- between 8.5 and 10.9, seemingly no pattern
	self:CDBar(args.spellId, 8.5)
end

-- Stage 2: Death Rains from Above

do
	local prev = 0
	function mod:VileBombardment(args)
		-- so we don't show another message for the first tick after vile bombardment lands
		prev = args.time
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
		if self:Normal() then
			-- this has a shorter CD in normal because Dive Bomb is Heroic+
			self:CDBar(args.spellId, 10.9)
		else
			self:CDBar(args.spellId, 17.0)
		end
	end

	function mod:VileCoatingDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", "gtfo")
			end
		end
	end
end

function mod:DiveBomb(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.0)
end

function mod:RevitalizingBrew(args)
	-- this ability is only cast if the boss is < 50% health
	self:Message(args.spellId, "red")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning", "interrupt")
	end
	self:CDBar(args.spellId, 20.7)
end

function mod:AzeritePowderShot(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 10.9)
end
