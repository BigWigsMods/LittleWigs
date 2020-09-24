local L = BigWigs:NewBossLocale("Underrot Trash", "ptBR")
if not L then return end
if L then
	L.custom_on_fixate_plates = "Ícone de Sede de Sangue na barra de identificação inimiga"
	L.custom_on_fixate_plates_desc = "Mostra um ícone na barra identificação do alvo que setá fixado em você.\nRequer o uso de barra de identificação inimigas. Essa função é suportada pelo addon KuiNameplates."

	L.spirit = "Espírito Conspurcado"
	L.priest = "Sacerdotisa Sangrenta Devota"
	L.maggot = "Verme Fétido"
	L.matron = "Máter Sangrenta Escolhida"
	L.lasher = "Açoitadora Doente"
	L.bloodswarmer = "Enxameador Sanguíneo Feral"
	L.rot = "Putrefação Viva"
	L.deathspeaker = "Morta-voz Caído"
	L.defiler = "Corruptor Jurassangue"
	L.corruptor = "Corruptor Sem-rosto"
end

L = BigWigs:NewBossLocale("Infested Crawg", "ptBR")
if L then
	L.random_cast = "Investida ou Indigestão"
	L.random_cast_desc = "A primeira conjuração de cada Birra é aleatória."
end
