local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "ptBR")
if not L then return end
if L then
	L.breaker = "Rachador Megalito"
	L.hulk = "Gigante Estilhavil"
	L.gnasher = "Triscadente Costapétrea"
	L.trapper = "Coureador Rochatado"
end

L = BigWigs:NewBossLocale("Rokmora", "ptBR")
if L then
	L.warmup_text = "Rokmora Ativo"
	L.warmup_trigger = "Navarrogg?! Traidor! Você liderou esses intrusos contra nós?!"
	L.warmup_trigger_2 = "De qualquer forma, vou curtir cada momento. Rokmora, esmague-os!"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "ptBR")
if L then
	L.totems = "Totens"
	L.bellow = "{193375} (Totens)" -- Bellow of the Deeps (Totems)
end
