local L = BigWigs:NewBossLocale("Throne of the Tides Trash", "ptBR")
if not L then return end
if L then
	L.nazjar_oracle = "Oráculo Naz'jar"
	L.vicious_snap_dragon = "Estalodraco Cruel"
	L.nazjar_sentinel = "Sentinela Naz'jar"
	L.nazjar_ravager = "Assoladora Naz'jar"
	L.nazjar_tempest_witch = "Bruxa da Tempestade Naz'jar"
	--L.faceless_seer = "Faceless Seer"
	L.faceless_watcher = "Vigia Sem-rosto"
	L.tainted_sentry = "Sentinela Maculada"

	--L.ozumat_warmup_trigger = "The beast has returned! It must not pollute my waters!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "ptBR")
if L then
	--L.high_tide_trigger1 = "Take arms, minions! Rise from the icy depths!"
	--L.high_tide_trigger2 = "Destroy these intruders! Leave them for the great dark beyond!"
end

L = BigWigs:NewBossLocale("Ozumat", "ptBR")
if L then
	L.custom_on_autotalk = "Conversa Automática"
	L.custom_on_autotalk_desc = "Instantaneamente seleciona a opção de conversa para iniciar a luta."
end
