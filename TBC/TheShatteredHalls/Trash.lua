--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Shattered Halls Trash", 540)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	16700, -- Shattered Hand Legionnaire
	16593, -- Shattered Hand Brawler
	16594, -- Shadowmoon Acolyte
	17694, -- Shadowmoon Darkcaster
	17695 -- Shattered Hand Assassin
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.legionnaire = "Shattered Hand Legionnaire"
	L.brawler = "Shattered Hand Brawler"
	L.acolyte = "Shadowmoon Acolyte"
	L.darkcaster = "Shadowmoon Darkcaster"
	L.assassin = "Shattered Hand Assassin"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Shattered Hand Legionnaire ]]--
		15615, -- Pummel
		--[[ Shattered Hand Brawler ]]--
		36020, -- Curse of the Shattered Hand
		36033, -- Kick
		--[[ Shadowmoon Acolyte ]]--
		35943, -- Prayer of Healing
		--[[ Shadowmoon Darkcaster ]]--
		{12542, "SAY"}, -- Fear
		--[[ Shattered Hand Assassin ]]--
		30980, -- Sap
	}, {
		[15615] = L.legionnaire,
		[36020] = L.brawler,
		[35943] = L.acolyte,
		[12542] = L.darkcaster,
		[30980] = L.assassin,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_INTERRUPT", "Interrupts", 15615, 36033) -- Pummel, Kick

	self:Log("SPELL_AURA_APPLIED", "CurseOfTheShatteredHand", 36020)

	self:Log("SPELL_CAST_START", "PrayerOfHealing", 15585, 35943) -- normal, heroic

	self:Log("SPELL_AURA_APPLIED", "Fear", 12542)
	self:Log("SPELL_AURA_REMOVED", "FearRemoved", 12542)

	self:Log("SPELL_AURA_APPLIED", "Sap", 30980)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Interrupts(args)
	if self:Me(args.destGUID) or self:Healer(args.destName) then
		self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
		self:TargetBar(args.spellId, args.spellId == 15615 and 4 or 6, args.destName)
	end
end

function mod:CurseOfTheShatteredHand(args)
	if self:Me(args.destGUID) or self:Dispeller("curse") then
		self:TargetMessageOld(args.spellId, args.destName, "red")
	end
end

do
	local prev = 0
	function mod:PrayerOfHealing(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:MessageOld(35943, "orange", self:Interrupter() and "long", CL.casting:format(args.spellName))
		end
	end
end

function mod:Fear(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Fear") -- helps prioritizing dispelling those who are about to run into some pack
	end
	self:TargetMessageOld(args.spellId, args.destName, "red", "alert", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 4, args.destName)
end

function mod:FearRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Sap(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm")
end
