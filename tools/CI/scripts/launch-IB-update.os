
#Использовать fs
#Использовать "..\..\..\src\"

ИсполняемыйФайл = Общие.ОбъединитьПутиВСтроку(ПараметрыПриложения.КаталогПриложенияИсточник(), ПараметрыПриложения.ВернутьПутьVrunner());

// vrunner: Запуск обновления ИБ в режиме предприятия

МассивПараметров = Новый Массив;
МассивПараметров.Добавить(ИсполняемыйФайл);
МассивПараметров.Добавить("run");
МассивПараметров.Добавить("--command ""ЗапуститьОбновлениеИнформационнойБазы;ЗавершитьРаботуСистемы;""");
МассивПараметров.Добавить("--execute $runnerRoot/epf/ЗакрытьПредприятие.epf");

Общие.ВыполнитьСтороннююКоманду("oscript", МассивПараметров);
