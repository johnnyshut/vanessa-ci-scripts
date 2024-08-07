
#Использовать 1commands

Перем Лог;    // Объект записи лога приложения

// Добавить опции и аргументы для команды
//
// Параметры:
//  ПараметрыКоманды  - Структура - Соответствие ключей командной строки и их значений
//
Процедура ОписаниеКоманды(ПараметрыКоманды) Экспорт

	ПараметрыКоманды.Аргумент("SCRIPT", "", "Имя скрипта который нужно запустить.")
					.ТСтрока()
					.ВОкружении("VCI_NAME_SCRIPT")
					.Обязательный(Истина)
					.ПоУмолчанию(ПараметрыПриложения.КаталогПриложения());

	ПараметрыКоманды.Аргумент("ARGS", "", "Коллекция параметров, передаваемых задаче")
					.ТМассивСтрок()
					.Обязательный(Ложь);

КонецПроцедуры

// Выполняет логику команды
// 
// Параметры:
//  ПараметрыКоманды  - Структура - Соответствие ключей командной строки и их значений
//
Процедура ВыполнитьКоманду(Знач ПараметрыКоманды) Экспорт

	Лог = ПараметрыПриложения.Лог();

	// Если Общие.ПроверитьЧтоЭтоКаталогИсходногоПроекта() Тогда
	// 	Возврат; 
	// КонецЕсли;

	Лог.Информация("Выполнение скрипта...");

	// Поиск скрипта по имени

	ИмяСкрипта      = ПараметрыКоманды.ЗначениеАргумента("SCRIPT") + ".os";
	// СтрокаНастройки = ПараметрыКоманды.ЗначениеОпции("settings");
	ПараметрыЗадачи = ПараметрыКоманды.ЗначениеАргумента("ARGS");

	Если ПустаяСтрока(ИмяСкрипта) Тогда
		Лог.Ошибка("Невозможно выполнить сценарий: Не указано имя скрипта");
		Возврат;
	КонецЕсли;
	
	КаталогПриложения = ПараметрыПриложения.КаталогПриложения();
	ПутьККаталогуСкриптов = ОбъединитьПути(КаталогПриложения, "tools", "CI", "scripts");
	МассивНайденныхФайлов = НайтиФайлы(ПутьККаталогуСкриптов, ИмяСкрипта, Истина);
	
	Если МассивНайденныхФайлов.Количество() = 0 Тогда
		Лог.Ошибка("Невозможно выполнить сценарий %1: Скрипт не найден", ИмяСкрипта);
		Возврат;
	КонецЕсли;
	
	// vci run script.os: выполнение скрипта из комплекта Vanessa-ci-Scripts

	ПараметрВыполненияСкрипта = СтрШаблон("""%1""", МассивНайденныхФайлов[0].ПолноеИмя);
	
	МассивПараметров = Новый Массив();
	МассивПараметров.Добавить(ПараметрВыполненияСкрипта);
	Для Каждого Параметр Из ПараметрыЗадачи Цикл
		МассивПараметров.Добавить(Параметр);
	КонецЦикла;
	Общие.ВыполнитьСтороннююКоманду("oscript", МассивПараметров);

	Лог.Информация("Выполнение скрипта завершено");

КонецПроцедуры // ВыполнитьКоманду
