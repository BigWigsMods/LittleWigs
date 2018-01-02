local L = BigWigs:NewBossLocale("Corborus", "ruRU")
if not L then return end
if L then
	L.burrow = "Закапывается/вылезает"
	L.burrow_desc = "Сообщить, когда Корбор закапывается или вылезает на поверхность."
	L.burrow_message = "Корбор закапывается"
	L.burrow_warning = "Закапается через 5 сек!"
	L.emerge_message = "Корбор вылезает на поверхность!"
	L.emerge_warning = "Велезет через 5 сек!"
end
