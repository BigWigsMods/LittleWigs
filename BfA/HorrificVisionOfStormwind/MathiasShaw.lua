--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overlord Mathias Shaw", 2213)
if not mod then return end
mod:RegisterEnableMob(
	158157, -- Overlord Mathias Shaw
	233684 -- Overlord Mathias Shaw (Revisited)
)
mod:SetEncounterID({2376, 3084}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local summonEyeOfChaosCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.overlord_mathias_shaw = "Overlord Mathias Shaw"
	L["311530_icon"] = 311570 -- Seek And Destroy
	L["311530_desc"] = 311570 -- Seek And Destroy
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		308681, -- Summon Eye of Chaos
		311530, -- Seek And Destroy
		-- Eye of Chaos
		{308669, "NAMEPLATE"}, -- Dark Gaze
	}
end

function mod:OnRegister()
	self.displayName = L.overlord_mathias_shaw
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "Shrouded", 312017)
	self:Log("SPELL_CAST_START", "DarkGaze", 308669)
end

function mod:OnEngage()
	summonEyeOfChaosCount = 1
	self:CDBar(311530, 5.3, nil, L["311530_icon"]) -- Seek And Destroy
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 308681 then -- Summon Eye of Chaos
		if summonEyeOfChaosCount == 1 then
			self:Message(spellId, "cyan", CL.percent:format(70, self:SpellName(spellId)))
		else
			self:Message(spellId, "cyan", CL.percent:format(35, self:SpellName(spellId)))
		end
		summonEyeOfChaosCount = summonEyeOfChaosCount + 1
		self:PlaySound(spellId, "info")
	elseif spellId == 311530 then -- Seek And Destroy
		self:Message(spellId, "yellow", nil, L["311530_icon"])
		self:CDBar(spellId, 20.7, nil, L["311530_icon"])
		self:PlaySound(spellId, "long")
	end
end

-- Eye of Chaos

function mod:Shrouded(args)
	-- this is cast by Eye of Chaos on spawn
	self:Nameplate(308669, 2.4, args.sourceGUID) -- Dark Gaze
end

do
	local prev = 0
	function mod:DarkGaze(args)
		self:Nameplate(args.spellId, 12.3, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
