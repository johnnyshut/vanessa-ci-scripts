
#Использовать ".."
#Использовать 1commands

Команда = Новый Команда;
Команда.УстановитьПравильныйКодВозврата(0);
Команда.ПоказыватьВыводНемедленно(Истина);
Команда.УстановитьСтрокуЗапуска("allure generate out -c -o out/allure-report && allure open out/allure-report");
КодВозврата = Команда.Исполнить();
