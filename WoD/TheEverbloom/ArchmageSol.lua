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
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CinderboltStorm", 427899)
	self:Log("SPELL_AURA_APPLIED", "GlacialFusion", 428082)
	self:Log("SPELL_CAST_START", "SpatialCompression", 428139)
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
