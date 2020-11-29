
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Manastorms", 2291, 2409)
if not mod then return end
mod:RegisterEnableMob(164556, 164555) -- Millhouse Manastorm, Millificent Manastorm
mod.engageId = 2394
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		320787, -- Summon Power Crystal
		{323877, "SAY"}, -- Echo Finger Laser X-treme
		320823, -- Experimental Squirrel Bomb
		321061, -- Aerial Rocket Chicken Barrage
	}, {
		[320787] = CL.stage:format(1),
		[320823] = CL.stage:format(2),
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SummonPowerCrystal", 320787)
	self:Log("SPELL_AURA_APPLIED", "EchoFingerLaserXtreme", 323877)

	self:Log("SPELL_CAST_SUCCESS", "ExperimentalSquirrelBomb", 320823)
	self:Log("SPELL_CAST_START", "AerialRocketChickenBarrage", 321061)
end

function mod:OnEngage()
	self:CDBar(320787, 9) -- Summon Power Crystal
	self:CDBar(323877, 17) -- Echo Finger Laser X-treme
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonPowerCrystal(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 9) -- pull:9.0, 8.0, 16.0
end

do
	local playerList = mod:NewTargetList()
	function mod:EchoFingerLaserXtreme(args)
		local laser = self:SpellName(143444)
		playerList[#playerList+1] = args.destName
		if #playerList == 2 then
			self:Bar(args.spellId, 15)
		end
		self:TargetsMessage(args.spellId, "red", playerList, 2, laser)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning")
			self:Say(args.spellId, laser)
			self:TargetBar(args.spellId, 5, args.destName, laser)
		end
	end
end

function mod:ExperimentalSquirrelBomb(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 8)
end

function mod:AerialRocketChickenBarrage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end
