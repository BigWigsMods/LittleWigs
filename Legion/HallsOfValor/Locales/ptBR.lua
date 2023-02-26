local L = BigWigs:NewBossLocale("Odyn", "ptBR")
if not L then return end
if L then
	L.custom_on_autotalk = "Conversa automática"
	L.custom_on_autotalk_desc = "Seleciona instantaneamente a opção de conversa para iniciar a luta."

	L.gossip_available = "Conversa disponível"
	L.gossip_trigger = "Muito impressionante! Eu nunca pensei que encontraria alguém capaz de igualar Valarjar em força... porém, aí estão vocês."

	L[197963] = "|cFF800080Acima à direita|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L[197964] = "|cFFFFA500Abaixo à direita|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L[197965] = "|cFFFFFF00Abaixo à esquerda|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L[197966] = "|cFF0000FFAcima à esquerda|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L[197967] = "|cFF008000Acima|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "ptBR")
if L then
	L.warmup_text = "Deus-Rei Skovald Ativo"
	L.warmup_trigger = "Os conquistadores já tomaram posse dele, Skovald, como era de direito. Seu protesto vem tarde demais."
	L.warmup_trigger_2 = "Se esses falsos campeões não entregarem a égide por escolha própria, entregarão na morte!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "ptBR")
if L then
	L.custom_on_autotalk = "Conversao automática"
	L.custom_on_autotalk_desc = "Instantaneamente seleciona várias opções de conversa ao redor da masmorra."

	L.mug_of_mead = "Caneco de Hidromel"
	L.valarjar_thundercaller = "Arauto do Trovão Valarjar"
	L.storm_drake = "Draco da Tempestade"
	L.stormforged_sentinel = "Sentinela Forjada em Tempestade"
	L.valarjar_runecarver = "Gravarrunas Valarjar"
	L.valarjar_mystic = "Místico Valarjar"
	L.valarjar_purifier = "Purificador Valarjar"
	L.valarjar_shieldmaiden = "Dama Escudeira Valarjar"
	L.valarjar_aspirant = "Aspirante Valarjar"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr, o Iluminado"
	L.valarjar_marksman = "Atiradora Perita Valarjar"
	L.gildedfur_stag = "Cervo Pelo D'Ouro"
	L.angerhoof_bull = "Touro Casca da Fúria"
	L.valarjar_trapper = "Coureador Valarjar"
	L.fourkings = "Os Quatro Reis"
end
