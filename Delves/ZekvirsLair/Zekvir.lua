--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zekvir", 2682)
if not mod then return end
mod:RegisterEnableMob(225204) -- Zekvir (Tier ?)
mod:SetEncounterID(2987)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local callWebTerrorCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.zekvir = "Zekvir (Tier 1)"
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
		450568, -- Call Web Terror
		-- Web Terror
		{453937, "CASTBAR"}, -- Hatching
		webTerrorMarker,
		{450597, "NAMEPLATE"}, -- Web Blast
	}, {
		[453937] = L.web_terror,
	}, {
		[450492] = CL.fear, -- Horrendous Roar (Fear)
		[453937] = CL.spawned:format(L.web_terror), -- Hatching... (Web Terror spawned)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ClawSmash", 450451)
	self:Log("SPELL_CAST_START", "EnfeeblingSpittle", 450505)
	self:Log("SPELL_INTERRUPT", "EnfeeblingSpittleInterrupt", 450505)
	self:Log("SPELL_CAST_SUCCESS", "EnfeeblingSpittleSuccess", 450505)
	self:Log("SPELL_AURA_APPLIED", "EnfeeblingSpittleApplied", 450505)
	self:Log("SPELL_CAST_START", "HorrendousRoar", 450492)
	self:Log("SPELL_CAST_START", "AnglersWeb", 450519)
	self:Log("SPELL_CAST_START", "CallWebTerror", 450568, 472158)
	self:Log("SPELL_SUMMON", "WebTerrorSummon", 450568)

	-- Web Terror
	self:Log("SPELL_CAST_START", "Hatching", 453937)
	self:Log("SPELL_CAST_SUCCESS", "HatchingSuccess", 453937)
	self:Log("SPELL_CAST_START", "WebBlast", 450597)
	self:Log("SPELL_INTERRUPT", "WebBlastInterrupt", 450597)
	self:Log("SPELL_CAST_SUCCESS", "WebBlastSuccess", 450597)
	self:Death("WebTerrorDeath", 224077)
end

function mod:OnEngage()
	if self:MobId(self:UnitGUID("boss1")) == 221427 then -- Zekvir Tier ??
		-- XXX there is a bug where the Zekvir Tier ? ENCOUNTER_START fires halfway through Zekvir Tier ??
		self:Disable()
		return
	end
	callWebTerrorCount = 1
	self:CDBar(450451, 4.6) -- Claw Smash
	self:CDBar(450505, 8.3) -- Enfeebling Spittle
	self:CDBar(450492, 9.5, CL.fear) -- Horrendous Roar
	self:CDBar(450568, 18.0, CL.count:format(self:SpellName(450568), callWebTerrorCount)) -- Call Web Terror
	self:CDBar(450519, 20.4) -- Angler's Web
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ClawSmash(args)
	if self:MobId(args.sourceGUID) == 225204 then -- Zekvir Tier ?
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 18.2)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:EnfeeblingSpittle(args)
	if self:MobId(args.sourceGUID) == 225204 then -- Zekvir Tier ?
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:EnfeeblingSpittleInterrupt(args)
	if self:MobId(args.destGUID) == 225204 then -- Zekvir Tier ?
		self:CDBar(450505, 15.3)
	end
end

function mod:EnfeeblingSpittleSuccess(args)
	if self:MobId(args.sourceGUID) == 225204 then -- Zekvir Tier ?
		self:CDBar(args.spellId, 15.3)
	end
end

function mod:EnfeeblingSpittleApplied(args)
	if self:MobId(args.sourceGUID) == 225204 then -- Zekvir Tier ?
		if self:Me(args.destGUID) then
			self:PersonalMessage(args.spellId)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end

function mod:HorrendousRoar(args)
	if self:MobId(args.sourceGUID) == 225204 then -- Zekvir Tier ?
		self:Message(args.spellId, "yellow", CL.fear)
		self:CDBar(args.spellId, 20.6, CL.fear)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:AnglersWeb(args)
	if self:MobId(args.sourceGUID) == 225204 then -- Zekvir Tier ?
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 25.5)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:CallWebTerror(args)
	if self:MobId(args.sourceGUID) == 225204 then -- Zekvir Tier ?
		self:StopBar(CL.count:format(args.spellName, callWebTerrorCount))
		self:Message(450568, "cyan", CL.count:format(args.spellName, callWebTerrorCount))
		callWebTerrorCount = callWebTerrorCount + 1
		self:CDBar(450568, 37.6, CL.count:format(args.spellName, callWebTerrorCount))
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
		self:Nameplate(450597, 12.1, args.destGUID)
	end
end

function mod:WebBlastSuccess(args)
	if self:IsEngaged() then -- same spellId and same mobId as other Zekvir
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	end
end

function mod:WebTerrorDeath(args)
	if self:IsEngaged() then -- same mobId as other Zekvir
		self:StopBar(CL.cast:format(self:SpellName(453937))) -- Hatching
		self:ClearNameplate(args.destGUID)
	end
end
