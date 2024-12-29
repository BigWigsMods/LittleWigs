--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cookie", 36, 2632)
if not mod then return end
mod:RegisterEnableMob(645) -- Cookie
mod:SetEncounterID(mod:Retail() and 2986 or 2746)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		5174, -- Cookie's Cooking
		{6306, "DISPEL"}, -- Acid Splash
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CookiesCooking", 5174)
	self:Log("SPELL_CAST_START", "AcidSplash", 6306)
	self:Log("SPELL_AURA_APPLIED", "AcidSplashApplied", 6306)
	if self:Classic() then
		-- no ENCOUNTER_END on Classic
		self:Death("Win", 645)
	end
end

function mod:OnEngage()
	-- Cookie's Cooking is only cast below a certain hp
	self:CDBar(6306, 2.4) -- Acid Splash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CookiesCooking(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 21.0)
	self:PlaySound(args.spellId, "warning")
end

do
	local playerList = {}

	function mod:AcidSplash(args)
		playerList = {}
		self:Message(args.spellId, "orange")
		if self:Retail() then
			self:CDBar(args.spellId, 13.3)
		else -- Classic
			self:CDBar(args.spellId, 55.0)
		end
	end

	function mod:AcidSplashApplied(args)
		if self:Retail() then
			if self:Dispeller("poison", nil, args.spellId) and self:Player(args.destFlags) then
				playerList[#playerList + 1] = args.destName
				self:TargetsMessage(args.spellId, "yellow", playerList, 5)
				self:PlaySound(args.spellId, "alert", nil, playerList)
			end
		else -- Classic
			-- not dispellable on Classic
			if self:Me(args.destGUID) or (self:Healer() and self:Player(args.destFlags)) then
				playerList[#playerList + 1] = args.destName
				self:TargetsMessage(args.spellId, "yellow", playerList, 5)
				self:PlaySound(args.spellId, "alert", nil, playerList)
			end
		end
	end
end
