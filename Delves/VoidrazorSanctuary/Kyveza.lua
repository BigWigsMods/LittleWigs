--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nexus-Princess Ky'veza (Tier 8)", 2951)
if not mod then return end
mod:RegisterEnableMob(244752) -- Nexus-Princess Ky'veza (Tier 8)
mod:SetEncounterID(3326)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local netherRiftCount = 1
local darkMassacreCount = 1

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
		1245240, -- Nexus Daggers
		1245582, -- Nether Rift
		1245203, -- Dark Massacre
		1244462, -- Invoke the Shadows
		1244600, -- Shadow Eruption
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NexusDaggers", 1245240)
	self:Log("SPELL_CAST_START", "NetherRift", 1245582)
	self:Log("SPELL_CAST_START", "DarkMassacre", 1245203)
	self:Log("SPELL_CAST_START", "DarkMassacrePhantom", 1245035)
	self:Log("SPELL_CAST_START", "InvokeTheShadows", 1244462)
	self:Log("SPELL_CAST_START", "ShadowEruption", 1244600)
end

function mod:OnEngage()
	netherRiftCount = 1
	darkMassacreCount = 1
	-- Nexus Daggers is cast on pull
	self:CDBar(1245582, 5.0) -- Nether Rift
	self:CDBar(1245203, 20.0) -- Dark Massacre
	self:CDBar(1244462, 64.0) -- Invoke the Shadows
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NexusDaggers(args)
	-- also cast by clones immediately after the boss's cast
	if self:MobId(args.sourceGUID) == 244752 then -- Nexus-Princess Ky'veza
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 30.0)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:NetherRift(args)
	self:Message(args.spellId, "red")
	netherRiftCount = netherRiftCount + 1
	if netherRiftCount % 2 == 0 then
		self:CDBar(args.spellId, 30.0)
	else
		self:CDBar(args.spellId, 60.0)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:DarkMassacre(args)
	self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
	darkMassacreCount = darkMassacreCount + 1
	if darkMassacreCount % 2 == 0 then
		self:CDBar(args.spellId, 30.0)
	else
		self:CDBar(args.spellId, 60.0)
	end
end

function mod:DarkMassacrePhantom(args)
	self:Message(1245203, "yellow")
	self:PlaySound(1245203, "alert")
end

function mod:InvokeTheShadows(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 90.0)
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:ShadowEruption(args)
		if args.time - prev > 5 then -- cast simultaneously by all clones
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "warning")
		end
	end
end
