--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nexus-Princess Ky'veza (Tier 11)", 2951)
if not mod then return end
mod:RegisterEnableMob(
	244752, -- Nexus-Princess Ky'veza (Tier 8)
	244753 -- Nexus-Princess Ky'veza (Tier 11)
)
mod:SetEncounterID({3326, 3325}) -- Tier 8, Tier 11
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local netherRiftCount = 1
local darkMassacreCount = 1
local invokeTheShadowsCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nexus_princess_kyveza = "Nexus-Princess Ky'veza"
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
		1250052, -- The Shadows
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NexusDaggers", 1245240)
	self:Log("SPELL_CAST_START", "NetherRift", 1245582)
	self:Log("SPELL_CAST_START", "DarkMassacre", 1245203)
	self:Log("SPELL_CAST_SUCCESS", "DarkMassacrePhantom", 1245035)
	self:Log("SPELL_CAST_START", "InvokeTheShadows", 1244462)
	self:Log("SPELL_CAST_START", "ShadowEruption", 1244600)
	self:Log("SPELL_PERIODIC_DAMAGE", "TheShadowsDamage", 1250052)
	self:Log("SPELL_PERIODIC_MISSED", "TheShadowsDamage", 1250052)
end

function mod:OnEngage()
	netherRiftCount = 1
	darkMassacreCount = 1
	invokeTheShadowsCount = 1
	-- Nexus Daggers is cast on pull
	self:CDBar(1245582, 5.0) -- Nether Rift
	self:CDBar(1245203, 20.0) -- Dark Massacre
	self:CDBar(1244462, 64.0, CL.count:format(self:SpellName(1244462), invokeTheShadowsCount)) -- Invoke the Shadows
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NexusDaggers(args)
	-- also cast by Nether Phantoms immediately after the boss's cast
	if self:IsEnableMob(self:MobId(args.sourceGUID)) then -- only the boss
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

do
	local phantomCount = 1
	local maxPhantoms = 6
	function mod:DarkMassacre(args)
		phantomCount = 1
		if self:MobId(args.sourceGUID) == 244753 then -- Ky'veza (Tier 11)
			maxPhantoms = 6
		else -- 244752, Ky'veza (Tier 8)
			maxPhantoms = 3
		end
		self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
		darkMassacreCount = darkMassacreCount + 1
		if darkMassacreCount % 2 == 0 then
			self:CDBar(args.spellId, 30.0)
		else
			self:CDBar(args.spellId, 60.0)
		end
		self:PlaySound(args.spellId, "long")
	end

	function mod:DarkMassacrePhantom(args)
		-- this alerts on SPELL_CAST_SUCCESS, denoting when it's safe to turn away from the active Nether Phantom
		self:Message(1245203, "yellow", CL.count_amount:format(args.spellName, phantomCount, maxPhantoms))
		phantomCount = phantomCount + 1
		if phantomCount <= maxPhantoms then
			-- don't play a sound after the last cast
			self:PlaySound(1245203, "alert")
		end
	end
end

function mod:InvokeTheShadows(args)
	self:StopBar(CL.count:format(args.spellName, invokeTheShadowsCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, invokeTheShadowsCount))
	invokeTheShadowsCount = invokeTheShadowsCount + 1
	self:CDBar(args.spellId, 90.0, CL.count:format(args.spellName, invokeTheShadowsCount))
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:ShadowEruption(args)
		if args.time - prev > 5 then -- cast simultaneously by all Nether Phantoms
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local prev = 0
	function mod:TheShadowsDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then -- 1s tick rate
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end
