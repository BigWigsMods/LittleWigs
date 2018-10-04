local L = BigWigs:NewBossLocale("Eye of Azshara Trash", "deDE")
if not L then return end
if L then
	L.wrangler = "Zänker der Hassnattern"
	L.stormweaver = "Sturmwirkerin der Hassnattern"
	L.crusher = "Zermalmer der Hassnattern"
	L.oracle = "Orakel der Hassnattern"
	L.siltwalker = "Treibsandläufer der Mak'rana"
	L.tides = "Aufgewühlte Fluten"
	L.arcanist = "Arkanistin der Hassnattern"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "deDE")
if L then
	L.custom_on_show_helper_messages = "Hinweis für Statische Nova und Gebündelter Blitz"
	L.custom_on_show_helper_messages_desc = "Wenn diese Option aktiviert ist, wird ein Hinweis angezeigt, welcher beinhaltet ob das Wasser oder Land sicher ist wenn der Boss |cff71d5ffStatische Nova|r oder |cff71d5ffGebündelter Blitz|r wirkt."

	L.water_safe = "%s (Wasser ist sicher)"
	L.land_safe = "%s (Land ist sicher)"
end
