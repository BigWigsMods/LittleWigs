--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ol' Waxbeard", 2651, 2569)
if not mod then return end
mod:RegisterEnableMob(
	210149, -- Ol' Waxbeard (boss)
	210153 -- Ol' Waxbeard (mount)
)
mod:SetEncounterID(2829)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local dynamiteMineCartCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dynamite_mine_cart = "Dynamite Mine Cart"
end

--------------------------------------------------------------------------------
-- Initialization
--

local dynamiteMineCartMarker = mod:AddMarkerOption(true, "npc", 8, "dynamite_mine_cart", 8)
function mod:GetOptions()
	return {
		{422116, "SAY", "SAY_COUNTDOWN"}, -- Reckless Charge
		{422245, "TANK_HEALER"}, -- Rock Buster
		422163, -- Luring Candleflame
		-- Mythic
		{429093, "CASTBAR"}, -- Underhanded Track-tics
		dynamiteMineCartMarker,
	}, {
		[429093] = CL.mythic,
	}
end

function mod:OnRegister()
	-- delayed for custom locale
	dynamiteMineCartMarker = mod:AddMarkerOption(true, "npc", 8, "dynamite_mine_cart", 8)
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss1") -- Reckless Charge, Luring Candleflame
	self:Log("SPELL_CAST_START", "RockBuster", 422245)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Luring Candleflame
	self:Log("SPELL_AURA_APPLIED", "LuringCandleflameApplied", 423693)

	-- Mythic
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Underhanded Track-tics
	self:Log("SPELL_CAST_START", "UnderhandedTracktics", 429093)
	self:Death("DynamiteMineCartDeath", 213751)
end

function mod:OnEngage()
	dynamiteMineCartCount = 1
	self:CDBar(422245, 1.0) -- Rock Buster
	if self:Mythic() then
		self:CDBar(429093, 8.2, CL.count:format(L.dynamite_mine_cart, dynamiteMineCartCount)) -- Underhanded Track-tics
	end
	self:CDBar(422163, 11.0) -- Luring Candleflame
	self:CDBar(422116, 28.3) -- Reckless Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid, elapsed)
		self:TargetMessage(422116, "orange", name)
		if self:Me(guid) then
			self:Say(422116, nil, nil, "Reckless Charge")
			self:SayCountdown(422116, 5 - elapsed)
		end
		self:PlaySound(422116, "alarm", nil, name)
	end

	function mod:UNIT_SPELLCAST_START(_, unit, _, spellId)
		if spellId == 422116 then -- Reckless Charge
			-- there is an emote for this with a target, but the emote often lists the wrong player
			self:GetUnitTarget(printTarget, 0.1, self:UnitGUID(unit))
			self:CDBar(spellId, 35.2)
		elseif spellId == 422163 then -- Luring Candleflame
			self:CDBar(spellId, 38.4)
		end
	end
end

function mod:RockBuster(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 13.3)
	self:PlaySound(args.spellId, "alert")
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg)
	-- |TInterface\\ICONS\\Ability_Fixated_State_Red.blp|t %s targets you with |cFFFF0000|Hspell:423693|h[Luring Candleflame!]|h|r
	if msg:find("spell:423693", nil, true) then -- Luring Candleflame
		self:PersonalMessage(422163, nil, CL.casting:format(self:SpellName(422163))) -- Luring Candleflame
	end
end

function mod:LuringCandleflameApplied(args)
	self:TargetMessage(422163, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(422163, "warning", nil, args.destName)
	else
		self:PlaySound(422163, "info", nil, args.destName)
	end
end

-- Mythic

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	-- |TInterface\\ICONS\\Ability_Foundryraid_TrainDeath.BLP:20|t Waxbeard snickers as he resorts to |cFFFF0000|Hspell:428268|h[Underhanded Track-tics]|h|r!#Ol' Waxbeard
	if msg:find("spell:428268", nil, true) then -- Underhanded Track-tics
		self:StopBar(CL.count:format(L.dynamite_mine_cart, dynamiteMineCartCount))
		self:Message(429093, "cyan", CL.count:format(CL.incoming:format(L.dynamite_mine_cart), dynamiteMineCartCount))
		dynamiteMineCartCount = dynamiteMineCartCount + 1
		if dynamiteMineCartCount % 2 == 0 then
			self:CDBar(429093, 31.8, CL.count:format(L.dynamite_mine_cart, dynamiteMineCartCount))
		else
			self:CDBar(429093, 48.0, CL.count:format(L.dynamite_mine_cart, dynamiteMineCartCount))
		end
		if self:GetOption(dynamiteMineCartMarker) then
			self:RegisterTargetEvents("MarkDynamiteMineCart")
		end
		self:PlaySound(429093, "info")
	end
end

function mod:MarkDynamiteMineCart(_, unit, guid)
	-- there is no SPELL_SUMMON event
	if self:MobId(guid) == 213751 then -- Dynamite Mine Cart
		self:CustomIcon(dynamiteMineCartMarker, unit, 8)
		self:UnregisterTargetEvents()
	end
end

function mod:UnderhandedTracktics(args)
	self:Message(args.spellId, "yellow")
	self:CastBar(args.spellId, 15)
	self:PlaySound(args.spellId, "long")
end

function mod:DynamiteMineCartDeath()
	self:StopCastBar(429093) -- Underhanded Track-tics
end
