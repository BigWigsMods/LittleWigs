local L = BigWigs:NewBossLocale("Eye of Azshara Trash", "ptBR")
if not L then return end
if L then
	L.wrangler = "Domador de Espiródio"
	L.stormweaver = "Tempestece Espiródio"
	L.crusher = "Esmagador Espiródio"
	L.oracle = "Oráculo Espiródio"
	L.siltwalker = "Mak'rana Andalodo"
	L.tides = "Marés Inquietas"
	L.arcanist = "Arcanista Espiródio"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "ptBR")
if L then
	L.custom_on_show_helper_messages = "Mensagens de ajuda para Nova Estática e Raio Concentrado"
	L.custom_on_show_helper_messages_desc = "Ative esta opção para adicionar uma mensagem auxiliar informando se a água ou a terra estão seguras quando o chefe começa a castar |cff71d5ffNova Estática|r ou |cff71d5ffRacio concentrado|r."

	L.water_safe = "%s (água está segura)"
	L.land_safe = "%s (terra está segura)"
end
