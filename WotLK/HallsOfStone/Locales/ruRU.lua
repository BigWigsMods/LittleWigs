local L = BigWigs:NewBossLocale("Tribunal of Ages", "ruRU")
if not L then return end
if L then
	L.engage_trigger = "Теперь будьте внимательны" -- Теперь будьте внимательны! Не успеете и глазом моргнуть, как...
	L.defeat_trigger = "Мои старые добрые пальцы" --  Ха! Мои старые добрые пальцы наконец-то одолели эту преграду! Теперь, перейдем к...
	L.fail_trigger = "Еще не время... еще не..."

	--L.timers = "Timers"
	--L.timers_desc = "Timers for various events that take place."

	L.victory = "Победа"
end
