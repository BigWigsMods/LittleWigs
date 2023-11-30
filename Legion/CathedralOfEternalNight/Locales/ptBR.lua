local L = BigWigs:NewBossLocale("Mephistroth", "ptBR")
if not L then return end
if L then
	L.custom_on_time_lost = "Tempo perdido durante Desvanecer nas Sombras"
	L.custom_on_time_lost_desc = "Mostra o tempo perdido durante o Desvanecer nas Sombras na barra em |cffff0000red|r."
	--L.time_lost = "%s |cffff0000(+%ds)|r"
end

L = BigWigs:NewBossLocale("Domatrax", "ptBR")
if L then
	L.custom_on_autotalk = "Conversa automática"
	L.custom_on_autotalk_desc = "Seleciona instantaneamente a opção de fofoca da Égide de Aggramar para começar o confronto com Domatrax."

	L.missing_aegis = "Você não está com a Égide " -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "Égide: Cura Reduzida"
	L.aegis_damage = "Égide: Dano Reduzido"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "ptBR")
if L then
	L.dulzak = "Dul'zak"
	L.wrathguard = "Invasor Guardião Colérico"
	L.felguard = "Guarda Vil Destruidor"
	L.soulmender = "Trata-alma Ardinferno"
	L.temptress = "Tentadora Ardinferno"
	L.botanist = "Botânica Vilanesca"
	L.orbcaster = "Lança-orbe Passovil"
	L.waglur = "Wa'glur"
	L.scavenger = "Catador Língua de Serpe"
	L.gazerax = "Gazerax"
	L.vilebark = "Andarilho Cascavil"

	L.throw_tome = "Arremessar Tomo" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end
