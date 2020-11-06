
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Inquisitor Gnshal", 2212)
if not mod then return end
mod:RegisterEnableMob(156161)
mod:SetAllowWin(true)
mod.engageId = 2371

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

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage(307863, "orange", name)
		self:PlaySound(307863, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(307863)
		end
	end

	function mod:VoidTorrent(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 15.8)
	end
end

function mod:CriesOfTheVoid(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
