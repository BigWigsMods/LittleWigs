--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archmage Sol", 1279, 1208)
if not mod then return end
mod:RegisterEnableMob(82682) -- Archmage Sol
mod:SetEncounterID(1751)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local lastCinderboltStormCD = 0
local lastGlacialFusionCD = 0
local lastSpatialCompressionCD = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427899, -- Cinderbolt Storm
		428082, -- Glacial Fusion
		428139, -- Spatial Compression
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "FireAffinity", 166475)
	self:Log("SPELL_AURA_APPLIED", "CinderboltStorm", 427899)
	self:Log("SPELL_AURA_APPLIED", "FrostAffinity", 166476)
	self:Log("SPELL_AURA_APPLIED", "GlacialFusion", 428082)
	self:Log("SPELL_AURA_APPLIED", "ArcaneAffinity", 166477)
	self:Log("SPELL_CAST_START", "SpatialCompression", 428139)
end

function mod:OnEngage()
	self:SetStage(1)
	if self:Mythic() then
		-- timers are only corrected in Mythic
		lastCinderboltStormCD = 3.3
		lastGlacialFusionCD = 24.2
		lastSpatialCompressionCD = 43.3
	end
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

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FireAffinity(args)
	self:SetStage(1)
end

do
	local prev = 0
	function mod:CinderboltStorm(args)
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "long")
		if self:Mythic() then
			if self:MobId(args.sourceGUID) == 82682 then -- Archmage Sol
				local t = args.time
				if t - prev < 10 then
					-- there is a bug where Archmage Sol can double cast Cinderbolt Storm,
					-- return here to avoid restarting timers.
					return
				end
				prev = t
				self:CDBar(args.spellId, 19.9)
				lastCinderboltStormCD = 19.9
				-- correct the Glacial Fusion bar
				if lastGlacialFusionCD > 20.4 then
					self:CDBar(428082, {20.4, lastGlacialFusionCD}) -- Glacial Fusion
				else
					self:CDBar(428082, 20.4) -- Glacial Fusion
					lastGlacialFusionCD = 20.4
				end
			else -- 213689, Spore Image
				self:CDBar(args.spellId, 38.6)
				lastCinderboltStormCD = 38.6
			end
		else -- Heroic, Normal
			local t = args.time
			if t - prev < 10 then
				-- there is a bug where Archmage Sol can double cast Cinderbolt Storm,
				-- return here to avoid restarting the timer.
				return
			end
			prev = t
			self:CDBar(args.spellId, 59.5)
		end
	end
end

function mod:FrostAffinity(args)
	self:SetStage(2)
end

function mod:GlacialFusion(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if self:Mythic() then
		if self:MobId(args.sourceGUID) == 82682 then -- Archmage Sol
			self:CDBar(args.spellId, 19.4)
			lastGlacialFusionCD = 19.4
			-- correct the Spatial Compression bar
			if lastSpatialCompressionCD > 18.4 then
				self:CDBar(428139, {18.4, lastSpatialCompressionCD}) -- Spatial Compression
			else
				self:CDBar(428139, 18.4) -- Spatial Compression
				lastSpatialCompressionCD = 18.4
			end
		else -- 213689, Spore Image
			self:CDBar(args.spellId, 39.9)
			lastGlacialFusionCD = 39.9
		end
	else -- Heroic, Normal
		self:CDBar(args.spellId, 59.5)
	end
end

function mod:ArcaneAffinity(args)
	self:SetStage(3)
end

function mod:SpatialCompression(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	if self:Mythic() then
		if self:MobId(args.sourceGUID) == 82682 then -- Archmage Sol
			self:CDBar(args.spellId, 20.5)
			lastSpatialCompressionCD = 20.5
			-- correct the Cinderbolt Storm bar
			if lastCinderboltStormCD > 19.1 then
				self:CDBar(427899, {19.1, lastCinderboltStormCD}) -- Cinderbolt Storm
			else
				self:CDBar(427899, 19.1) -- Cinderbolt Storm
				lastCinderboltStormCD = 19.1
			end
		else -- 213689, Spore Image
			self:CDBar(args.spellId, 38.7)
			lastSpatialCompressionCD = 38.7
		end
	else -- Heroic, Normal
		self:CDBar(args.spellId, 59.5)
	end
end
