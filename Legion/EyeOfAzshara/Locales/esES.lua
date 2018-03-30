local L = BigWigs:NewBossLocale("Eye of Azshara Trash", "esES") or BigWigs:NewBossLocale("Eye of Azshara Trash", "esMX")
if not L then return end
if L then
	L.wrangler = "Retador Espiral de Odio"
	L.stormweaver = "Tejetormentas Espiral de Odio"
	L.crusher = "Triturador Espiral de Odio"
	L.oracle = "Oráculo Espiral de Odio"
	L.siltwalker = "Caminante de limo de Mak'rana"
	L.tides = "Mareas inquietas"
	L.arcanist = "Arcanista Espiral de Odio"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "esES") or BigWigs:NewBossLocale("Lady Hatecoil", "esMX")
if L then
	--L.custom_on_show_helper_messages = "Helper messages for Static Nova and Focused Lightning"
	--L.custom_on_show_helper_messages_desc = "Enable this option to add a helper message telling you whether water or land is safe when the boss starts casting |cff71d5ffStatic Nova|r or |cff71d5ffFocused Lightning|r."

	--L.water_safe = "%s (water is safe)"
	--L.land_safe = "%s (land is safe)"
end
