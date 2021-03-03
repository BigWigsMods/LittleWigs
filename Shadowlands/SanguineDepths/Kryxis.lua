
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kryxis the Voracious", 2284, 2388)
if not mod then return end
mod:RegisterEnableMob(162100)
mod.engageId = 2360
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local viciousHeadbuttCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{319650, "TANK_HEALER"}, -- Vicious Headbutt
		319654, -- Hungering Drain
		{319713, "SAY"}, -- Juggernaut Rush
		319685, -- Severing Smash
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_START", "ViciousHeadbutt", 319650)
	self:Log("SPELL_CAST_SUCCESS", "HungeringDrain", 319654)
	self:Log("SPELL_CAST_START", "SeveringSmash", 319685)
end

function mod:OnEngage()
	viciousHeadbuttCount = 0
	self:Bar(319650, 5.8) -- Vicious Headbutt
	self:Bar(319654, 10.6) -- Hungering Drain
	self:Bar(319713, 22.8) -- Juggernaut Rush
	self:Bar(319685, 32.5) -- Severing Smash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("319713", nil, true) then
		self:TargetMessage(319713, "red", destName)
		self:PlaySound(319713, "alarm", nil, destName)
		self:Bar(319713, 36.4)

		local guid = self:UnitGUID(destName)
		if self:Me(guid) then
			self:Say(319713)
		end
	end
end

function mod:ViciousHeadbutt(args)
	viciousHeadbuttCount = viciousHeadbuttCount + 1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, viciousHeadbuttCount % 2 == 0 and 24.3 or 12.1)
end

function mod:HungeringDrain(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 36.4)
end

function mod:SeveringSmash(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 36.4)
end
