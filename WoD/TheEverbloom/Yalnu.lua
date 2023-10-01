--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yalnu", 1279, 1210)
if not mod then return end
mod:RegisterEnableMob(83846) -- Yalnu
mod:SetEncounterID(1756)
--mod:SetRespawnTime(0) -- wiping teleports you out, then you can retry immediately

--------------------------------------------------------------------------------
-- Locals
--

local colossalBlowCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kirin_tor = "Kirin Tor"
	L.warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		-- Yalnu
		169179, -- Colossal Blow
		169120, -- Font of Life
		{169613, "CASTBAR"}, -- Genesis
		169240, -- Entanglement (Kirin Tor)
		170132, -- Entanglement (Player)
		-- Vicious Mandragora
		169878, -- Noxious Breath
		-- Gnarled Ancient
		169929, -- Lumbering Swipe
	}, {
		[169179] = self.displayName, -- Yalnu
		[169878] = -10535, -- Vicious Mandragora
		[169929] = -10537, -- Gnarled Ancient
	}, {
		[169240] = L.kirin_tor, -- Entanglement (Kirin Tor)
	}
end

function mod:OnBossEnable()
	-- Warmup
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	-- Yalnu
	self:Log("SPELL_CAST_START", "ColossalBlow", 169179)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Font of Life
	-- TODO add spawns (Font of Life) have no summon events
	self:Log("SPELL_CAST_START", "Genesis", 169613)
	self:Log("SPELL_CAST_SUCCESS", "EntanglementKirinTor", 169251) -- aura is 169240
	self:Log("SPELL_AURA_APPLIED", "EntanglementPlayer", 170132) -- cast is 170124

	-- Vicious Mandragora
	self:Log("SPELL_CAST_START", "NoxiousBreath", 169878)

	-- Gnarled Ancient
	self:Log("SPELL_CAST_START", "LumberingSwipe", 169929)
end

function mod:OnEngage()
	colossalBlowCount = 1
	self:CDBar(169179, 5.3) -- Colossal Blow
	self:CDBar(169240, 12.4, CL.other:format(self:SpellName(169240), L.kirin_tor)) -- Entanglement (Kirin Tor)
	self:CDBar(169120, 15.0) -- Font of Life
	self:CDBar(169613, 25.6) -- Genesis
	if self:MythicPlus() then
		-- dungeon journal says "In Heroic and Challenge difficulty" but only observed in M+
		self:CDBar(170132, 53.8) -- Entanglement (Player)
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:Warmup(event, msg)
	-- [CHAT_MSG_MONSTER_YELL] The portal is lost! We must stop this beast before it can escape!#Lady Baihu
	if msg == L.warmup_trigger then
		self:Bar("warmup", 8.0, CL.active, "inv_enchant_shaperessence")
		self:UnregisterEvent(event)
	end
end

-- Yalnu

function mod:ColossalBlow(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	colossalBlowCount = colossalBlowCount + 1
	-- TODO timer is different in other difficulties? (this is from M+)
	if colossalBlowCount % 2 == 0 then
		self:CDBar(args.spellId, 40.1)
	else
		self:CDBar(args.spellId, 20.6)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 169120 then -- Font of Life
		-- this summons either 1 Gnarled Ancient, 2 Vicious Mandragoras, or 8 Swift Sproutlings
		self:Message(spellId, "cyan")
		self:PlaySound(spellId, "alert")
		self:CDBar(spellId, 15.0)
	end
end

function mod:Genesis(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 17) -- 2s cast + 15s channel
	self:CDBar(args.spellId, 60.7)
end

function mod:EntanglementKirinTor(args)
	self:Message(169240, "red", CL.other:format(args.spellName, L.kirin_tor))
	self:PlaySound(169240, "info")
	-- TODO timer is lower in other difficulties? (this is from M+)
	-- TODO this won't be cast if all the friendly NPCs are dead...
	-- UNIT_DIED##nil#Creature-0-5770-1279-9671-84358-0000188F23#Lady Baihu
	-- no UNIT_DIED for Kirin Tor Battle-Mage though
	self:CDBar(169240, 60.7, CL.other:format(args.spellName, L.kirin_tor))
end

function mod:EntanglementPlayer(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
	self:CDBar(args.spellId, 60.7)
end

-- Vicious Mandragora

do
	local prev = 0
	function mod:NoxiousBreath(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Gnarled Ancient

function mod:LumberingSwipe(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end
