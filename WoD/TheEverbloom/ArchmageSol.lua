local isTenDotTwo = select(4, GetBuildInfo()) >= 100200 --- XXX delete when 10.2 is live everywhere
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archmage Sol", 1279, 1208)
if not mod then return end
mod:RegisterEnableMob(82682) -- Archmage Sol
mod:SetEncounterID(1751)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427899, -- Cinderbolt Storm
		428082, -- Glacial Fusion
		428139, -- Spatial Compression
		-- XXX delete these option keys below when 10.2 is live everywhere
		not isTenDotTwo and "stages" or nil,
		not isTenDotTwo and 168885 or nil, -- Parasitic Growth
		not isTenDotTwo and {166492, "FLASH"} or nil, -- Firebloom
		not isTenDotTwo and 166726 or nil, -- Frozen Rain
	}
end

function mod:OnBossEnable()
	-- XXX bring these listeners outside the if block when 10.2 is live everywhere
	if isTenDotTwo then
		self:Log("SPELL_AURA_APPLIED", "CinderboltStorm", 427899)
		self:Log("SPELL_AURA_APPLIED", "GlacialFusion", 428082)
		self:Log("SPELL_CAST_START", "SpatialCompression", 428139)
	else
		-- XXX delete these listeners below when 10.2 is live everywhere
		self:Log("SPELL_CAST_START", "ParasiticGrowth", 168885)
		self:Log("SPELL_AURA_APPLIED", "MagicSchools", 166475, 166476, 166477) -- Fire, Frost, Arcane
		self:Log("SPELL_AURA_APPLIED", "FrozenRain", 166726)
		self:Log("SPELL_CAST_SUCCESS", "Firebloom", 166492)
	end
end

function mod:OnEngage()
	self:CDBar(427899, 3.3) -- Cinderbolt Storm
	self:CDBar(428082, 24.2) -- Glacial Fusion
	self:CDBar(428139, 43.3) -- Spatial Compression
end

function mod:OnWin()
    local trashMod = BigWigs:GetBossModule("The Everbloom Trash", true)
    if trashMod then
        trashMod:Enable()
        trashMod:ArchmageSolDefeated()
    end
end

-- XXX delete this entire block below when 10.2 is live everywhere
if not isTenDotTwo then
	-- before 10.2
	function mod:GetOptions()
		return {
			"stages",
			168885, -- Parasitic Growth
			{166492, "FLASH"}, -- Firebloom
			166726, -- Frozen Rain
		}
	end
	function mod:OnEngage()
		self:MessageOld("stages", "cyan", nil, 166475) -- Fire
		self:CDBar(168885, 33) -- Parasitic Growth
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CinderboltStorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	if self:Mythic() then
		if self:MobId(args.sourceGUID) == 82682 then -- Archmage Sol
			self:CDBar(args.spellId, 20.5)
			self:CDBar(428082, 20.5) -- Glacial Fusion
		else -- 213689, Spore Image
			self:CDBar(args.spellId, 39.0)
		end
	else
		self:CDBar(args.spellId, 59.5)
	end
end

function mod:GlacialFusion(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if self:Mythic() then
		if self:MobId(args.sourceGUID) == 82682 then -- Archmage Sol
			self:CDBar(args.spellId, 20.5)
			self:CDBar(428139, 20.5) -- Spatial Compression
		else -- 213689, Spore Image
			self:CDBar(args.spellId, 39.0)
		end
	else
		self:CDBar(args.spellId, 59.5)
	end
end

function mod:SpatialCompression(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	if self:Mythic() then
		if self:MobId(args.sourceGUID) == 82682 then -- Archmage Sol
			self:CDBar(args.spellId, 20.5)
			self:CDBar(427899, 20.5) -- Cinderbolt Storm
		else -- 213689, Spore Image
			self:CDBar(args.spellId, 39.0)
		end
	else
		self:CDBar(args.spellId, 59.5)
	end
end

-- XXX delete this entire block below when 10.2 is live everywhere
if not isTenDotTwo then
	function mod:ParasiticGrowth(args)
		self:MessageOld(args.spellId, "orange", "warning")
		self:Bar(args.spellId, 34)
	end

	function mod:MagicSchools(args)
		self:MessageOld("stages", "cyan", nil, args.spellId)
	end

	do
		local prev = 0
		function mod:Firebloom(args)
			local t = GetTime()
			if t-prev > 7 then
				prev = t
				self:MessageOld(args.spellId, "red", "alert")
				self:Flash(args.spellId)
			end
		end
	end

	function mod:FrozenRain(args)
		if self:Me(args.destGUID) then
			self:MessageOld(args.spellId, "blue", "alarm", CL.you:format(args.spellName))
		end
	end
end
