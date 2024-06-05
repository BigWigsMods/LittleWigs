local L = BigWigs:NewBossLocale("Lord Walden", "zhCN")
if not L then return end
if L then
	-- %s will be either "Toxic Coagulant" or "Toxic Catalyst"
	L.coagulant = "%s：移动消除"
	L.catalyst = "%s：爆击增益"
	L.toxin_healer_message = "%s：全体 DoT"
end
