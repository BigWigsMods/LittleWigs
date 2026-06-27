if not BigWigsLoader.isNext then return end -- 12.1
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Altar of Fangs Trash", 2993)
if not mod then return end
mod:SetPrivateAuraSounds({
	{1308865, sound = "alert"}, -- Infest
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
