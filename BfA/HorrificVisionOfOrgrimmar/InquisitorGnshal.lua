--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Inquisitor Gnshal", 2212)
if not mod then return end
mod:RegisterEnableMob(
	156161, -- Inquisitor Gnshal
	234035 -- Inquisitor Gnshal (Revisited)
)
mod:SetEncounterID({2371, 3087}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local criesOfTheVoidCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.inquisitor_gnshal = "Inquisitor Gnshal"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{307863, "SAY"}, -- Void Torrent
		304976, -- Cries of the Void
	}
end

function mod:OnRegister()
	self.displayName = L.inquisitor_gnshal
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VoidTorrent", 307863)
	self:Log("SPELL_CAST_START", "CriesOfTheVoid", 304976)
end

function mod:OnEngage()
	criesOfTheVoidCount = 1
	self:CDBar(307863, 4.9) -- Void Torrent
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage(307863, "yellow", name)
		if self:Me(guid) and not self:Solo() then
			self:Say(307863, nil, nil, "Void Torrent")
		end
		self:PlaySound(307863, "long", nil, name)
	end

	function mod:VoidTorrent(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 15.8)
	end
end

function mod:CriesOfTheVoid(args)
	-- cast at 65% and 30%
	if criesOfTheVoidCount == 1 then
		self:Message(args.spellId, "red", CL.percent:format(65, args.spellName))
	else
		self:Message(args.spellId, "red", CL.percent:format(30, args.spellName))
	end
	criesOfTheVoidCount = criesOfTheVoidCount + 1
	self:PlaySound(args.spellId, "warning")
end
