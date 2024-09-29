--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zekvir 2", 2682)
if not mod then return end
mod:RegisterEnableMob(221427) -- Zekvir (Tier ??)
mod:SetEncounterID(2985)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local callWebTerrorCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.zekvir = "Zekvir (Tier 2)"
	L.web_terror = "Web Terror"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.zekvir
	self:SetSpellRename(450492, CL.fear) -- Horrendous Roar (Fear)
end

local webTerrorMarker = mod:AddMarkerOption(true, "npc", 8, "web_terror", 8) -- Web Terror
function mod:GetOptions()
	return {
		450451, -- Claw Smash
		450505, -- Enfeebling Spittle
		450492, -- Horrendous Roar
		450519, -- Angler's Web
		450449, -- Regenerating Carapace
		450568, -- Call Web Terror
		-- Web Terror
		{453937, "CASTBAR"}, -- Hatching
		webTerrorMarker,
		{450597, "NAMEPLATE"}, -- Web Blast
		-- Stage 2
		451003, -- Black Blood
		450872, -- Unending Spines
		450914, -- Blood-Infused Carapace
		451782, -- Infinite Horror
	}, {
		[453937] = L.web_terror,
		[451003] = CL.stage:format(2),
	}, {
		[450492] = CL.fear, -- Horrendous Roar (Fear)
		[451003] = CL.stage:format(2), -- Black Blood (Stage 2)
		[453937] = CL.spawned:format(L.web_terror), -- Hatching... (Web Terror spawned)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ClawSmash", 450451)
	self:Log("SPELL_CAST_START", "EnfeeblingSpittle", 450505, 472128)
	self:Log("SPELL_INTERRUPT", "EnfeeblingSpittleInterrupt", 450505, 472128)
	self:Log("SPELL_CAST_SUCCESS", "EnfeeblingSpittleSuccess", 450505, 472128)
	self:Log("SPELL_AURA_APPLIED", "EnfeeblingSpittleApplied", 450505, 472128)
	self:Log("SPELL_CAST_START", "HorrendousRoar", 450492)
	self:Log("SPELL_CAST_START", "AnglersWeb", 450519, 450676) -- Stage 1, Stage 2
	self:Log("SPELL_CAST_START", "RegeneratingCarapace", 450449)
	self:Log("SPELL_INTERRUPT", "RegeneratingCarapaceInterrupt", 450449)
	self:Log("SPELL_CAST_SUCCESS", "RegeneratingCarapaceSuccess", 450449)
	self:Log("SPELL_CAST_START", "CallWebTerror", 450568, 472159)
	self:Log("SPELL_SUMMON", "WebTerrorSummon", 450568, 472002)

	-- Web Terror
	self:Log("SPELL_CAST_START", "Hatching", 453937)
	self:Log("SPELL_CAST_SUCCESS", "HatchingSuccess", 453937)
	self:Log("SPELL_CAST_START", "WebBlast", 450597)
	self:Log("SPELL_INTERRUPT", "WebBlastInterrupt", 450597)
	self:Log("SPELL_CAST_SUCCESS", "WebBlastSuccess", 450597)
	self:Death("WebTerrorDeath", 224077, 234024)

	-- Stage 2
	self:Log("SPELL_CAST_START", "BlackBlood", 451003)
	self:Log("SPELL_CAST_START", "UnendingSpines", 450872)
	self:Log("SPELL_CAST_START", "BloodInfusedCarapace", 450914)
	self:Log("SPELL_INTERRUPT", "BloodInfusedCarapaceInterrupt", 450914)
	self:Log("SPELL_CAST_SUCCESS", "BloodInfusedCarapaceSuccess", 450914)
	self:Log("SPELL_CAST_START", "InfiniteHorror", 451782)
end

function mod:OnEngage()
	callWebTerrorCount = 1
	self:SetStage(1)
	self:CDBar(450451, 4.0) -- Claw Smash
	self:CDBar(450492, 9.3, CL.fear) -- Horrendous Roar
	self:CDBar(450505, 16.1) -- Enfeebling Spittle
	self:CDBar(450568, 18.0, CL.count:format(self:SpellName(450568), callWebTerrorCount)) -- Call Web Terror
	self:CDBar(450519, 23.1) -- Angler's Web
	-- Regenerating Carapace not cast until 95%
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ClawSmash(args)
	if self:MobId(args.sourceGUID) == 221427 then -- Zekvir Tier ??
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 15.7)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:EnfeeblingSpittle(args)
	if self:MobId(args.sourceGUID) == 221427 then -- Zekvir Tier ??
		self:Message(450505, "red", CL.casting:format(args.spellName))
		self:PlaySound(450505, "alert")
	end
end

function mod:EnfeeblingSpittleInterrupt(args)
	if self:MobId(args.destGUID) == 221427 then -- Zekvir Tier ??
		self:CDBar(450505, 25.2)
	end
end

function mod:EnfeeblingSpittleSuccess(args)
	if self:MobId(args.sourceGUID) == 221427 then -- Zekvir Tier ??
		self:CDBar(450505, 25.2)
	end
end

function mod:EnfeeblingSpittleApplied(args)
	if self:MobId(args.sourceGUID) == 221427 then -- Zekvir Tier ??
		if self:Me(args.destGUID) then
			self:PersonalMessage(450505)
			self:PlaySound(450505, "info", nil, args.destName)
		end
	end
end

function mod:HorrendousRoar(args)
	if self:MobId(args.sourceGUID) == 221427 then -- Zekvir Tier ??
		self:Message(args.spellId, "yellow", CL.fear)
		self:CDBar(args.spellId, 18.2, CL.fear)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:AnglersWeb(args)
	if self:MobId(args.sourceGUID) == 221427 then -- Zekvir Tier ??
		self:Message(450519, "orange")
		self:CDBar(450519, 21.8)
		self:PlaySound(450519, "alarm")
	end
end

function mod:RegeneratingCarapace(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:RegeneratingCarapaceInterrupt(args)
	self:CDBar(450449, 31.3)
end

function mod:RegeneratingCarapaceSuccess(args)
	self:CDBar(args.spellId, 31.3)
end

function mod:CallWebTerror(args)
	if self:MobId(args.sourceGUID) == 221427 then -- Zekvir Tier ??
		self:StopBar(CL.count:format(args.spellName, callWebTerrorCount))
		self:Message(450568, "cyan", CL.count:format(args.spellName, callWebTerrorCount))
		callWebTerrorCount = callWebTerrorCount + 1
		self:CDBar(450568, 41.2, CL.count:format(args.spellName, callWebTerrorCount))
		self:PlaySound(450568, "long")
	end
end

do
	local webTerrorGUID = nil

	function mod:WebTerrorSummon(args)
		if self:IsEngaged() then -- same spellId and same mobId as other Zekvir
			-- register events to auto-mark the add
			if self:GetOption(webTerrorMarker) then
				webTerrorGUID = args.destGUID
				self:RegisterTargetEvents("MarkWebTerror")
			end
		end
	end

	function mod:MarkWebTerror(_, unit, guid)
		if webTerrorGUID == guid then
			webTerrorGUID = nil
			self:CustomIcon(webTerrorMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

-- Web Terror

function mod:Hatching(args)
	if self:IsEngaged() then -- same spellId and same mobId as other Zekvir
		self:CastBar(args.spellId, 20)
	end
end

function mod:HatchingSuccess(args)
	if self:IsEngaged() then -- same spellId and same mobId as other Zekvir
		self:Message(args.spellId, "cyan", CL.spawned:format(L.web_terror))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:WebBlast(args)
	if self:IsEngaged() then -- same spellId and same mobId as other Zekvir
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:WebBlastInterrupt(args)
	if self:IsEngaged() then -- same spellId and same mobId as other Zekvir
		self:Nameplate(450597, 10.8, args.destGUID)
	end
end

function mod:WebBlastSuccess(args)
	if self:IsEngaged() then -- same spellId and same mobId as other Zekvir
		self:Nameplate(args.spellId, 10.8, args.sourceGUID)
	end
end

function mod:WebTerrorDeath(args)
	if self:IsEngaged() then -- same mobId as other Zekvir
		self:StopBar(CL.cast:format(self:SpellName(453937))) -- Hatching
		self:ClearNameplate(args.destGUID)
	end
end

-- Stage 2

function mod:BlackBlood(args)
	self:StopBar(CL.fear) -- Horrendous Roar
	self:StopBar(450449) -- Regenerating Carapace
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.percent:format(60, CL.stage:format(2)))
	self:CDBar(450451, 14.2) -- Claw Smash
	self:CDBar(450872, 17.8) -- Unending Spines
	self:CDBar(450505, 25.5) -- Enfeebling Spittle
	self:CDBar(450914, 25.5) -- Blood-Infused Carapace
	self:CDBar(450568, 28.3, CL.count:format(self:SpellName(450568), callWebTerrorCount)) -- Call Web Terror
	self:CDBar(450519, 30.3) -- Angler's Web
	self:CDBar(451782, 34.0) -- Infinite Horror
	self:PlaySound(args.spellId, "long")
end

function mod:UnendingSpines(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 21.8)
	self:PlaySound(args.spellId, "long")
end

function mod:BloodInfusedCarapace(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:BloodInfusedCarapaceInterrupt(args)
	self:CDBar(450914, 31.3)
end

function mod:BloodInfusedCarapaceSuccess(args)
	self:CDBar(args.spellId, 31.3)
end

function mod:InfiniteHorror(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 18.2)
	self:PlaySound(args.spellId, "alarm")
end
