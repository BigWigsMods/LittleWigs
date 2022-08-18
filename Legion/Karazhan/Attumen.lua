--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Attumen the Huntsman", 1651, 1835)
if not mod then return end
mod:RegisterEnableMob(114262, 114264) -- Attumen, Midnight
mod:SetEncounterID(1960)
mod:SetRespawnTime(15)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local englishGhost = "Ghost on "..mod:UnitName("player") -- CL.on:format(L.ghost, mod:UnitName("player"))

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ghost = "Ghost"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		228895, -- Enrage
		227404, -- Intangible Presence
		227363, -- Mighty Stomp
		227365, -- Spectral Charge
		227493, -- Mortal Strike
		228852, -- Shared Suffering
	}, {
		[227404] = -14300,
		[227493] = -14304,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")
	self:Log("SPELL_CAST_START", "MortalStrike", 227493)
	self:Log("SPELL_AURA_APPLIED", "MortalStrikeApplied", 227493)
	self:Log("SPELL_AURA_REMOVED", "MortalStrikeRemoved", 227493)
	self:Log("SPELL_CAST_START", "SharedSuffering", 228852)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 228895)
	self:Log("SPELL_CAST_START", "MightyStomp", 227363)
	self:RegisterEvent("VEHICLE_ANGLE_UPDATE", "CheckIntangiblePresence")
	self:RegisterMessage("BigWigs_BossComm")
end

function mod:OnEngage()
	self:CDBar(227404, 5.1) -- Intangible Presence
	self:CDBar(227363, 15.4) -- Mighty Stomp
	self:SetStage(1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local function sendChatMessage(msg, english)
	if IsInGroup() then
		BigWigsLoader.SendChatMessage(english and ("[LittleWigs] %s / %s"):format(msg, english) or ("[LittleWigs] %s"):format(msg), IsInGroup(2) and "INSTANCE_CHAT" or "PARTY")
	end
end

do
	local lastIntangiblePresenceApplied = nil

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
		if spellId == 227404 then -- Intangible Presence
			self:Message(spellId, "yellow")
			if self:Dispeller("magic") then
				self:PlaySound(spellId, "warning")
			else
				self:PlaySound(spellId, "alert")
			end
			self:Bar(spellId, 30)
			lastIntangiblePresenceApplied = GetTime()
		elseif spellId == 227338 then -- Riderless
			self:Message("stages", "cyan", spellId, false)
			self:PlaySound("stages", "long")
			self:CDBar(228852, 18.2) -- Shared Suffering
			self:StopBar(227404) -- Intangible Presence
			self:StopBar(227363) -- Mighty Stomp
			self:SetStage(2)
		elseif spellId == 227584 then -- Mounted
			self:Message("stages", "cyan", spellId, false)
			self:PlaySound("stages", "long")
			self:SetStage(1)
		elseif spellId == 227601 then -- Intermission, starts Spectral Charges
			self:Message(227365, "yellow")
			self:PlaySound(227365, "alert")
		end
	end

	function mod:CheckIntangiblePresence()
		if not lastIntangiblePresenceApplied then
			return
		end
		if GetTime() - lastIntangiblePresenceApplied < 1 then
			if self:GetOption(227404) > 0 then -- Intangible Presence
				local localizedGhost = CL.on:format(L.ghost, self:UnitName("player"))
				sendChatMessage(localizedGhost, englishGhost ~= localizedGhost and englishGhost)
			end
			self:Sync("ghost")
			lastIntangiblePresenceApplied = nil
		end
	end
end

function mod:BigWigs_BossComm(_, msg, _, sender)
	if msg == "ghost" and sender then
		self:TargetMessage(227404, "yellow", sender, L.ghost) -- Intangible Presence
	end
end

function mod:MortalStrike(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:MortalStrikeApplied(args)
	if self:Tank(args.destName) then
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:MortalStrikeRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:SharedSuffering(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

function mod:Enrage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:MightyStomp(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18.2)
end
