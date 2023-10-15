--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tribunal of Ages", 599, 606)
if not mod then return end
mod:RegisterEnableMob(28070) -- Brann Bronzebeard
--mod:SetEncounterID(mod:Classic() and 567 or 1995) -- not a real encounter, apparently
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local lastKill = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.engage_trigger = "Now keep an eye out" -- Now keep an eye out! I'll have this licked in two shakes of a--
	L.defeat_trigger = "The old magic fingers" --  Ha! The old magic fingers finally won through! Now let's get down to--
	L.fail_trigger = "Not yet... not ye--"

	L.timers = "Timers"
	L.timers_desc = "Timers for various events that take place."
	L.timers_icon = "INV_Misc_PocketWatch_01"

	L.victory = "Victory"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"timers",
		59868, -- Dark Matter
		59866, -- Searing Gaze
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:Log("SPELL_DAMAGE", "DarkMatter", 51012, 59868) -- normal, heroic; no SPELL_AURA_APPLIED events
	self:Log("SPELL_MISSED", "DarkMatter", 51012, 59868)
	self:Log("SPELL_DAMAGE", "SearingGaze", 51125, 59866) -- normal, heroic
	self:Log("SPELL_MISSED", "SearingGaze", 51125, 59866)
end

function mod:OnEngage()
	self:Bar("timers", 298, L.victory, "INV_Misc_PocketWatch_01")
	self:Bar("timers", 43, self.displayName, "Achievement_Character_Dwarf_Male") -- first wave
	self:DelayedMessage("timers", 43, "yellow", CL.incoming:format(CL.adds), false, "info")
end

function mod:OnWin()
	lastKill = GetTime()
end

function mod:VerifyEnable()
	-- Brann is present during the final encounter, prevent the module from loading for a while, but don't overdo it for
	-- higher level characters that might be binge-farming this dungeon for whatever reason.

	-- GetSubZoneText() approach was considered but the subzone he's initially in covers a huge chunk of the dungeon
	-- (including the exact place where you need to talk to him to open the door to the last boss) and only checking
	-- against the subzone the encounter is taking action in poses a risk of the module not being loaded.
	return not lastKill or (GetTime() - lastKill > (UnitLevel("player") > 80 and 150 or 300))
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.fail_trigger or msg:find(L.fail_trigger, nil, true) then
		self:SendMessage("BigWigs_EncounterEnd", self, nil, self.displayName, self:Difficulty(), 5, 0) -- XXX hack to force a respawn timer
		self:Wipe()
	elseif msg == L.engage_trigger or msg:find(L.engage_trigger, nil, true) then
		self:Engage()
	elseif msg == L.defeat_trigger or msg:find(L.defeat_trigger, nil, true) then
		self:Win()
	end
end

do
	local isOnMe, playerList = false, {}

	local function announce(self)
		if isOnMe or self:Dispeller("magic") then
			self:TargetMessageOld(59868, self:ColorName(playerList), "orange", "alarm", nil, nil, true)
		else
			playerList = {} -- :TargetMessage calls wipe() on its 2nd argument
		end

		isOnMe = false
	end

	function mod:DarkMatter(args)
		if self:Me(args.destGUID) then
			isOnMe = true
		end

		-- making sure we aren't including DKs that could've used AMS to negate the debuff
		if self:UnitDebuff(args.destName, args.spellId) then
			playerList[#playerList + 1] = args.destName
			if #playerList == 1 then
				self:ScheduleTimer(announce, 0.3, self)
			end
		end
	end
end

do
	local prev = 0
	function mod:SearingGaze(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:MessageOld(59866, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
