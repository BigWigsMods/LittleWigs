--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rexxar", 2212)
if not mod then return end
mod:RegisterEnableMob(
	155098, -- Rexxar
	234038 -- Rexxar (Revisited)
)
mod:SetEncounterID({2370, 3090}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rexxar = "Rexxar"
	L.pet_trigger_1 = "Come, my pets! Serve your master!"
	L.pet_trigger_2 = "My beasts will devour you!"
	L.pet_trigger_3 = "Hunt them down!"
	L.adds_icon = "inv_jewelcrafting_purpleboar"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"adds",
		304282, -- Stampeding Corruption
		304251, -- Void Quills
	}, {
		[304251] = CL.adds,
	}
end

function mod:OnRegister()
	self.displayName = L.rexxar
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") -- Adds
	self:Log("SPELL_CAST_START", "StampedingCorruption", 304282)
	self:Log("SPELL_CAST_START", "VoidQuills", 304251)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:CHAT_MSG_MONSTER_YELL(event, msg)
		if msg == L.pet_trigger_1 then
			-- 85%, Huffer (155657) attacks
			self:Message("adds", "yellow", CL.percent:format(85, CL.adds_spawned_count:format(1)), L.adds_icon)
		elseif msg == L.pet_trigger_2 then
			-- 70%, Ruffer (155951) attacks
			self:Message("adds", "yellow", CL.percent:format(70, CL.adds_spawned_count:format(1)), L.adds_icon)
		elseif msg == L.pet_trigger_3 then
			-- 55%, Suffer (155952) and C'Thuffer (155953) attack
			self:UnregisterEvent(event)
			self:Message("adds", "yellow", CL.percent:format(55, CL.adds_spawned_count:format(2)), L.adds_icon)
		end
		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:PlaySound("adds", "info")
		end
	end
end

function mod:StampedingCorruption(args)
	self:Message(args.spellId, "cyan", CL.percent:format(40, args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Adds

do
	local prev = 0
	function mod:VoidQuills(args)
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		if args.time - prev > 1.5 then
			prev = args.time
			self:PlaySound(args.spellId, "alert")
		end
	end
end
