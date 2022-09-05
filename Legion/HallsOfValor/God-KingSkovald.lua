
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("God-King Skovald", 1477, 1488)
if not mod then return end
mod:RegisterEnableMob(95675)
mod.engageId = 1808

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "God-King Skovald Active"
	L.warmup_trigger = "The vanquishers have already taken possession of it, Skovald, as was their right. Your protest comes too late."
	L.warmup_trigger_2 = "If these false champions will not yield the aegis by choice... then they will surrender it in death!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		193668, -- Savage Blade
		193826, -- Ragnarok
		{193659, "SAY", "ICON"}, -- Felblaze Rush
		193702, -- Infernal Flames
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "SavageBlade", 193668)
	self:Log("SPELL_CAST_START", "Ragnarok", 193826)
	self:Log("SPELL_CAST_START", "FelblazeRush", 193659)
	self:Log("SPELL_CAST_SUCCESS", "FelblazeRushEnd", 193659)

	self:Log("SPELL_AURA_APPLIED", "InfernalFlamesDamage", 193702)
	self:Log("SPELL_PERIODIC_DAMAGE", "InfernalFlamesDamage", 193702)
	self:Log("SPELL_PERIODIC_MISSED", "InfernalFlamesDamage", 193702)
end

function mod:OnEngage()
	self:CDBar(193826, 11) -- Ragnarok
	self:CDBar(193668, self:Normal() and 24 or 47) -- Savage Blade
	self:CDBar(193659, 8.5) -- Felblaze Rush
end

function mod:OnWin()
	local odynMod = BigWigs:GetBossModule("Odyn", true)
	if odynMod then
		odynMod:Enable() -- Making sure to pickup the Odyn's yell to start the RP bar
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 20, L.warmup_text, "achievement_dungeon_hallsofvalor")
	elseif msg == L.warmup_trigger_2 then -- for engages after a wipe
		self:UnregisterEvent(event)
		self:Bar("warmup", 10, L.warmup_text, "achievement_dungeon_hallsofvalor")
	end
end

function mod:SavageBlade(args)
	self:MessageOld(args.spellId, "yellow", self:Tank() and "warning")
	self:CDBar(args.spellId, 18) -- pull:24.3, 24.3, 17.8, 20.9 / hc pull:48.6, 19.5 / m pull:47.3, 24.3, 37.6
end

function mod:Ragnarok(args)
	self:MessageOld(args.spellId, "orange", "long")
	self:CDBar(args.spellId, 63) -- pull:11.4, 63.5
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(193659)
		end
		self:PrimaryIcon(193659, player)
		self:TargetMessageOld(193659, player, "red", "alarm")
	end
	function mod:FelblazeRush(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		--self:CDBar(args.spellId, 10) -- pull:8.7, 14.6, 26.7, 12.1 -- pull:8.5, 35.2, 13.3, 15.9
	end
	function mod:FelblazeRushEnd(args)
		self:PrimaryIcon(args.spellId)
	end
end

do
	local prev = 0
	function mod:InfernalFlamesDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
