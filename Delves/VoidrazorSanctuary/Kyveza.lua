if not BigWigsLoader.isNext then return end -- XXX remove in 11.2
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nexus-Princess Ky'veza (Tier 8)", 2951)
if not mod then return end
mod:RegisterEnableMob(244752, 244753) -- Nexus-Princess Ky'veza (Tier 8)
--mod:SetEncounterID(3325) XXX 3325 or 3326
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nexus_princess_kyveza = "Nexus-Princess Ky'veza (Tier 8)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.nexus_princess_kyveza
end

function mod:GetOptions()
	return {
		-- https://www.wowhead.com/ptr-2/spells/name-extended:ky'veza?filter=21;2;110200
		1244462, -- Invoke the Shadows
		1244473, -- Enter the Shadows
		1250050, -- Energize
		1245582, -- Nether Rift
		1245240, -- Nexus Daggers
		1244601, -- Return to the Shadows
		1244600, -- Shadow Eruption
		1244505, -- Shifting Shadows
		1225642, -- Sovereign Dark
		1245035, -- Dark Massacre
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") -- XXX until encounter ids can be identified
	self:RegisterEvent("ENCOUNTER_END") -- XXX until encounter ids can be identified

	self:Log("SPELL_CAST_START", "InvokeTheShadows", 1244462)
	self:Log("SPELL_CAST_START", "EnterTheShadows", 1244473)
	self:Log("SPELL_CAST_START", "NetherRift", 1245582)
	self:Log("SPELL_CAST_START", "NexusDaggers", 1245240)
	self:Log("SPELL_CAST_SUCCESS", "ReturnToTheShadows", 1244601)
	self:Log("SPELL_CAST_START", "ShadowEruption", 1244600)
	self:Log("SPELL_CAST_SUCCESS", "Energize", 1250050)
	self:Log("SPELL_CAST_START", "ShiftingShadows", 1244505)
	self:Log("SPELL_CAST_SUCCESS", "SovereignDark", 1225642)
	self:Log("SPELL_CAST_START", "DarkMassacre", 1245035)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, id)
	if id == 3325 or id == 3326 then -- XXX don't know which is which, use this module for both for now
		self:Engage()
		local easyWidget = self:GetWidgetInfo("delve", 6184)
		local hardWidget = self:GetWidgetInfo("delve", 6185)
		local tierText = ""
		if type(easyWidget) == "table" and easyWidget.shownState == 1 then
			tierText = easyWidget.tierText or "nil"
		elseif type(hardWidget) == "table" and hardWidget.shownState == 1 then
			tierText = hardWidget.tierText or "nil"
		end
		local mobId = ""
		for enableMob in next, self.enableMobs do
			if self:GetUnitIdByGUID(enableMob) then
				mobId = enableMob
				break
			end
		end
		self:Error("Please report to the devs: "..id.." - "..mobId.." (Tier "..tierText..")")
	end
end

function mod:ENCOUNTER_END(_, id, _, _, _, status)
	if id == 3325 or id == 3326 then -- XXX don't know which is which, use this module for both for now
		if status == 0 then
			self:Wipe()
		else
			self:Win()
		end
	end
end

function mod:InvokeTheShadows(args)
	self:Message(args.spellId, "yellow")
	--self:CDBar(args.spellId, 100)
	self:PlaySound(args.spellId, "info")
end

function mod:EnterTheShadows(args)
	self:Message(args.spellId, "cyan")
	--self:CDBar(args.spellId, 100)
	self:PlaySound(args.spellId, "info")
end

function mod:NetherRift(args)
	self:Message(args.spellId, "orange")
	--self:CDBar(args.spellId, 100)
	self:PlaySound(args.spellId, "alarm")
end

function mod:NexusDaggers(args)
	self:Message(args.spellId, "orange")
	--self:CDBar(args.spellId, 100)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0

	function mod:ReturnToTheShadows(args)
		-- guessing these two spells are related
		if args.time - prev > 5 then
			prev = args.time
			self:Message(args.spellId, "red")
			--self:CDBar(args.spellId, 100)
			self:PlaySound(args.spellId, "warning")
		end
	end

	function mod:ShadowEruption(args)
		if args.time - prev > 5 then
			prev = args.time
			self:Message(args.spellId, "red")
			--self:CDBar(args.spellId, 100)
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local prev = 0

	function mod:Energize(args)
		-- guessing these two spells are related
		if args.time - prev > 5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			--self:CDBar(args.spellId, 100)
			self:PlaySound(args.spellId, "alarm")
		end
	end

	function mod:ShiftingShadows(args)
		-- guessing these two spells are related
		if args.time - prev > 5 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			--self:CDBar(args.spellId, 100)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:SovereignDark(args)
	-- cast at 100 energy, probably some way to stop the cast?
	self:Message(args.spellId, "cyan")
	--self:CDBar(args.spellId, 100)
	self:PlaySound(args.spellId, "long")
end

function mod:DarkMassacre(args)
	self:Message(args.spellId, "yellow")
	--self:CDBar(args.spellId, 100)
	self:PlaySound(args.spellId, "info")
end
