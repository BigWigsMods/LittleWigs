local L = BigWigs:NewBossLocale("Lord Walden", "ptBR")
if not L then return end
if L then
	-- %s será "Coagulante Tóxico" ou "Catalisador Tóxico"
	L.coagulant = "%s: Mova-se para dissipar"
	L.catalyst = "%s: Buff Crítico"
	L.toxin_healer_message = "%: DoT em todos"
end
