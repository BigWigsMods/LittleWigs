
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maw of Souls Trash", 1492)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	99188, -- Waterlogged Soul Guard
	97097, -- Helarjar Champion
	97182, -- Night Watch Mariner
	98919, -- Seacursed Swiftblade
	97365, -- Seacursed Mistmender
	99033, -- Helarjar Mistcaller
	99307 -- Skjal
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.soulguard = "Waterlogged Soul Guard"
	L.champion = "Helarjar Champion"
	L.mariner = "Night Watch Mariner"
	L.swiftblade = "Seacursed Swiftblade"
	L.mistmender = "Seacursed Mistmender"
	L.mistcaller = "Helarjar Mistcaller"
	L.skjal = "Skjal"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		194657, -- Soul Siphon
		198405, -- Bone Chilling Scream
		{192019, "CASTBAR"}, -- Lantern of Darkness
		194615, -- Sea Legs
		199514, -- Torrent of Souls
		199589, -- Whirlpool of Souls
		216197, -- Surging Waters
		195293, -- Debilitating Shout
		{198324, "SAY", "FLASH"}, -- Give No Quarter
	}, {
		[194657] = L.soulguard,
		[198405] = L.champion,
		[192019] = L.mariner,
		[194615] = L.swiftblade,
		[199514] = L.mistmender,
		[199589] = L.mistcaller,
		[195293] = L.skjal,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "Casts", 194657, 199514, 199589, 216197) -- Soul Siphon, Torrent of Souls, Whirlpool of Souls, Surging Waters
	self:Log("SPELL_DAMAGE", "TorrentOfSouls", 199519)
	self:Log("SPELL_MISSED", "TorrentOfSouls", 199519)

	self:Log("SPELL_AURA_APPLIED", "GhostlyRage", 194663)
	self:Log("SPELL_CAST_START", "BoneChillingScream", 198405)

	self:Log("SPELL_AURA_APPLIED", "SeaLegs", 194615)

	self:Log("SPELL_CAST_START", "LanternOfDarkness", 192019)

	self:Log("SPELL_CAST_START", "DebilitatingShout", 195293)
	self:Log("SPELL_CAST_SUCCESS", "GiveNoQuarter", 198324) -- the target-selecting instant cast (the real channeling cast is 196885)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prevTable = {}
	function mod:Casts(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1 then
			prevTable[args.spellId] = t
			self:MessageOld(args.spellId, "orange", "alarm")
		end
	end

	function mod:TorrentOfSouls(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - (prevTable[args.spellId] or 0) > 1.5 then
				prevTable[args.spellId] = t

				local spellId = self:CheckOption(199514, "MESSAGE") and 199514 or 199589 -- both these spells do damage with 199519
				self:MessageOld(spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end

	function mod:GhostlyRage(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1.5 then
			prevTable[args.spellId] = t
			self:MessageOld(198405, "yellow", "info", CL.soon:format(self:SpellName(5782))) -- Bone Chilling Scream, 5782 = "Fear"
			self:CDBar(198405, 6)
		end
	end

	function mod:BoneChillingScream(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1 then
			prevTable[args.spellId] = t
			self:MessageOld(args.spellId, "red", "warning")
		end
	end


	function mod:SeaLegs(args)
		if self:MobId(args.destGUID) ~= 98919 then return end -- mages can spellsteal it
		-- for casters/hunters it's deflection, for melees it's just dodge chance
		if self:Ranged() or self:Dispeller("magic", true) then
			local t = GetTime()
			if t - (prevTable[args.spellId] or 0) > 1 then
				prevTable[args.spellId] = t
				self:MessageOld(args.spellId, "yellow", "alarm", CL.other:format(args.spellName, args.destName))
			end
		end
	end
end

function mod:LanternOfDarkness(args)
	self:MessageOld(args.spellId, "yellow", "long")
	self:CastBar(args.spellId, 7)
end

function mod:DebilitatingShout(args)
	self:MessageOld(args.spellId, "orange", "long")
end

function mod:GiveNoQuarter(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Give No Quarter")
		self:Flash(args.spellId)
		self:TargetMessageOld(args.spellId, args.destName, "red", "warning")
	else
		self:TargetMessageOld(args.spellId, args.destName, "red", "alarm", nil, nil, true)
	end
end
