local L = BigWigs:NewBossLocale("Viceroy Nezhar", "ptBR")
if not L then return end
if L then
	L.tentacles = "Tentáculos"
	L.guards = "Guardas"
	L.interrupted = "%s interrompido %s (%.1fs restando)!"
end

L = BigWigs:NewBossLocale("L'ura", "ptBR")
if L then
	L.warmup_text = "L'ura Ativa"
	L.warmup_trigger = "Quanto caos, quanta angústia. Nunca senti nada igual."
	L.warmup_trigger_2 = "Tais reflexões podem esperar, entretanto. Esta entidade deve morrer."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "ptBR")
if L then
	L.custom_on_autotalk = "Conversa Automática"
	L.custom_on_autotalk_desc = "Seleciona instantaneamente a opção de conversa com Alleria Correventos."
	L.gossip_available = "Conversa disponível"
	L.alleria_gossip_trigger = "Siga-me!" -- Allerias yell after the first boss is defeated

	L.alleria = "Alleria Correventos"
	L.subjugator = "Subjugante da Guarda Sombria"
	L.voidbender = "Dobra-caos da Guarda Sombria"
	L.conjurer = "Conjuradora da Guarda Sombria"
	L.weaver = "Tecelã-mor das Sombras"
end
