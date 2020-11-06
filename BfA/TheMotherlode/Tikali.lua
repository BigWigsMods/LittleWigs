
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tik'ali", 1594, 2114)
if not mod then return end
mod:RegisterEnableMob(129227)
mod.engageId = 2106
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_fixate_plates = "Raging Gaze icon on Enemy Nameplate"
	L.custom_on_fixate_plates_desc = "Show an icon on the target nameplate that is fixating on you.\nRequires the use of Enemy Nameplates. This feature is currently only supported by KuiNameplates."
	L.custom_on_fixate_plates_icon = 257582
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		271698, -- Azerite Infusion
		258622, -- Resonant Pulse
		257593, -- Call Earthrager
		{257582, "SAY"}, -- Raging Gaze
		"custom_on_fixate_plates",
		-- Heroic
		275907, -- Tectonic Smash
	}, {
		[271698] = "general",
		[275907] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallEarthrager", 257593)
	self:Log("SPELL_AURA_APPLIED", "RagingGazeApplied", 257582)
	self:Log("SPELL_AURA_REMOVED", "RagingGazeRemoved", 257582)
	self:Log("SPELL_CAST_SUCCESS", "AzeriteInfusion", 271698)
	self:Log("SPELL_CAST_START", "ResonantPulse", 258622)
	self:Log("SPELL_CAST_START", "TectonicSmash", 275907)
end

function mod:OnEngage()
	self:Bar(258622, 9.5) -- Resonant Pulse
	self:Bar(271698, 20) -- Azerite Infusion
	self:Bar(257593, 64) -- Call Earthrager
	if not self:Normal() then
		self:Bar(275907, 5) -- Tectonic Smash
	end
	if self:GetOption("custom_on_fixate_plates") then
		self:ShowPlates()
	end
end

function mod:OnBossDisable()
	if self:GetOption("custom_on_fixate_plates") then
		self:HidePlates()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallEarthrager(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "mobsoon")
	-- The boss casts "Set Energy to 0" (280479) every 60 sec.
	-- There is a chance that the boss will cast Call Earthrager afterwards,
	-- but it is not guaranteed, so a timer for this can't be accurate. 
end

do
	local playerList = mod:NewTargetList()
	local prev = 0
	function mod:RagingGazeApplied(args)
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList)
		if self:Me(args.destGUID) then
			if self:GetOption("custom_on_fixate_plates") then
				self:AddPlateIcon(args.spellId, args.sourceGUID)
			end
			local t = args.time
			if t-prev > 0.3 then -- Only run once per targetsmessage
				prev = t
				self:PlaySound(args.spellId, "warning", "fixate")
				self:Say(args.spellId)
			end
		end
	end
end

function mod:RagingGazeRemoved(args)
	if self:GetOption("custom_on_fixate_plates") and self:Me(args.destGUID) then
		self:RemovePlateIcon(args.spellId, args.sourceGUID)
	end
end

function mod:AzeriteInfusion(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "killmob")
	self:Bar(args.spellId, 17)
end

function mod:ResonantPulse(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long", "aesoon")
	self:Bar(args.spellId, 34)
end

function mod:TectonicSmash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21)
end
