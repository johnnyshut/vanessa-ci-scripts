
#Использовать 1commands
#Использовать fs

#Область ОписаниеПеременных

Перем Лог; // Объект записи лога приложения

#КонецОбласти


Функция ОбъединитьПутиВСтроку(Путь1, Путь2 = "", Путь3 = "", Путь4 = "") Экспорт
	
	НовыйПуть = ОбъединитьПути(Путь1, Путь2, Путь3, Путь4);
	Возврат СтрШаблон("""%1""", НовыйПуть);
	
КонецФункции

// Проверить что текущий каталог это каталог исходного проекта
//
// Возвращаемое значение:
//  Булево - Это каталог исходного проекта VCI
//
Функция ПроверитьЧтоЭтоКаталогИсходногоПроекта() Экспорт
	
	ТекущийКаталогSrc = ОбъединитьПути(ТекущийКаталог(), "src");
	СтартовыйКаталогSrc = СтартовыйСценарий().Каталог;
	Если ТекущийКаталогSrc = СтартовыйКаталогSrc Тогда
		Лог.Ошибка("Невозможно выполнить сценарий в каталоге исходного проекта");
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// Сохранить текст в выходной файл
//
// Параметры:
//  Пайплайн      - Строка - Текст пайплайна
//  ВыходнойФайл  - Строка - Путь выходного файла куда сохраняем
//
Процедура СохранитьТекст(Пайплайн, ВыходнойФайл) Экспорт
	
	ЗаписьТекста = Новый ЗаписьТекста(ВыходнойФайл, КодировкаТекста.UTF8);
	ЗаписьТекста.ЗаписатьСтроку(Пайплайн);
	ЗаписьТекста.Закрыть();
	
КонецПроцедуры

// Выполнить стороннюю команду
//	Обертка для выполнения какой нибудь команды в ОС, например vrunner compilecf
//
// Параметры:
//  ИмяКоманды        - Строка - Имя команды OC которую требуется выполнить
//  МассивПараметров  - Массив - Массив параметров выполнения команды ОС
//
Процедура ВыполнитьСтороннююКоманду(ИмяКоманды, МассивПараметров) Экспорт
	
	Лог.Вывести("%1 %2", УровниЛога.Информация, ИмяКоманды, СтрСоединить(МассивПараметров, " "));
	
	Команда = Новый Команда;
	Команда.УстановитьКоманду(ИмяКоманды);
	
	Команда.ДобавитьПараметры(МассивПараметров);
	
	Команда.ДобавитьЛогВыводаКоманды(Лог);
	Команда.ПоказыватьВыводНемедленно(Истина);
	
	Команда.УстановитьПравильныйКодВозврата(0);
	Команда.Исполнить();
	
КонецПроцедуры

// Читаем содержимое файла env.*.json из репозитория проекта
//
// Параметры:
//  ПутьКФайлу   - Путь - путь к файлу настроек который нужно прочитать
//
// Возвращаемое значение:
//   Соответствие - позволяет обращаться к значениям параметров окружения
//
Функция ПрочитатьПеременныеОкруженияИзФайла(ПутьКФайлу) Экспорт
	
	Соответствие = ПрочитатьJSONИзФайла(ПутьКФайлу, Истина);
	ДополнитьПеременныеОкружения(Соответствие);
	Возврат Соответствие;
	
КонецФункции

// Дополняем не стандартными параметрами: db, ras etc
//
// Параметры:
//  Соответствие  - Соответствие - Получен из функции "ПрочитатьПеременныеОкруженияИзФайла"
//
Процедура ДополнитьПеременныеОкружения(Соответствие)

	ibconnection = Соответствие.Получить("default").Получить("--ibconnection");
	// Лог.Вывести(ibconnection, УровниЛога.Информация);

	Если СтрНачинаетсяС(ibconnection, "/S") Тогда
		СтрокаСРазделителем = СтрЗаменить(ibconnection, "/S", "");
		МассивПараметров = СтрРазделить(СтрокаСРазделителем, "/");
		
		server_name = МассивПараметров[0];
		db_name = МассивПараметров[1];
	Иначе
		server_name = "";
		db_name = "";
	КонецЕсли;

	Соответствие.Вставить("server_name", server_name);
	Соответствие.Вставить("db_name", db_name);

КонецПроцедуры

// Считывает значение из JSON-файла. JSON-текст должен быть корректным.
//
// Параметры:
//  ПутьКФайлу     - Строка - JSON-файл.
//  ВСоответствие  - Булево - Если установлено Истина, чтение объекта JSON будет выполнено в Соответствие. Если установлено Ложь, объекты будут считываться в объект типа Структура. Значение по умолчанию: Ложь.
//
// Возвращаемое значение:
//   Соответствие/Структура - Значения параметров
//
Функция ПрочитатьJSONИзФайла(ПутьКФайлу, ВСоответствие) Экспорт

	Чтение = Новый ЧтениеJSON;
	Чтение.ОткрытьФайл(ПутьКФайлу);
	Параметры = ПрочитатьJSON(Чтение, ВСоответствие);
	Чтение.Закрыть();

	Возврат Параметры;

КонецФункции

// Записывает значение из параметров в JSON-файл
//
// Параметры:
//  Параметры  - Структура/Соответствие - Параметры для записи
//  ПутьКФайлу - Строка - JSON-файл.
//
Процедура ЗаписатьJSONВФайл(Параметры, ПутьКФайлу) Экспорт

	Запись = Новый ЗаписьJSON;
	Запись.ОткрытьФайл(ПутьКФайлу);
	ЗаписатьJSON(Запись, Параметры);
	Запись.Закрыть();

КонецПроцедуры

// Получить знаечние свойства из соответствия
//
// Параметры:
//  Соответствие - Соответствие - таблица с соответствиями ключей и значений
//  Имя          - Строка       - Ключ свойства
//
// Возвращаемое значение:
//   Произвольный - значение свойства из соответствия
//
Функция ПолучитьЗначениеСвойства(Соответствие, Имя) Экспорт

	ВремЗначение = Соответствие.Получить(Имя);

	МассивБулевоИстина = СтрРазделить("1,true,истина", ",", Ложь);
	МассивБулевоЛожь   = СтрРазделить("0,false,ложь", ",", Ложь);

	Если Не МассивБулевоИстина.Найти(НРег(ВремЗначение)) = Неопределено Тогда
		Значение = Истина;
	ИначеЕсли Не МассивБулевоЛожь.Найти(НРег(ВремЗначение)) = Неопределено Тогда
		Значение = Ложь;
	ИначеЕсли ВремЗначение = Неопределено Тогда
		Значение = Ложь;
	Иначе
		Значение = ВремЗначение;
	КонецЕсли;
	
	Возврат Значение;

КонецФункции

// Получить свойства конфигурации из исходного кода
//	Пытаемся прочитать файл Configuration.xml и его свойства (Name, Vendor, Version etc)
//
// Параметры:
//  КаталогИсходогоКода  - Строка - относительный путь к каталогу исходного кода
//                                   по умолчанию каталог "./src/cf"
//
// Возвращаемое значение:
//   Структура   - Значения свойств конфигурации
//
Функция ПолучитьСвойстваКонфигурации(КаталогИсходогоКода = "./src/cf") Экспорт
	
	Свойства = Новый Структура("Name, Vendor, Version");
	
	ПутьКФайлу = ОбъединитьПути(КаталогИсходогоКода, "Configuration.xml");
	Если ФС.ФайлСуществует(ПутьКФайлу) Тогда
		Текст = ПрочитатьФайлВТексте(ПутьКФайлу);
		
		Значение = РазобратьСПомощьюРВ(Текст, "(?<=<Name>).*?(?=</Name>)");
		Свойства.Name = Значение;
		
		Значение = РазобратьСПомощьюРВ(Текст, "(?<=<Vendor>).*?(?=</Vendor>)");
		Свойства.Vendor = Значение;
		
		Значение = РазобратьСПомощьюРВ(Текст, "(?<=<Version>).*?(?=</Version>)");
		Свойства.Version = Значение;
		
	КонецЕсли;
	
	Возврат Свойства;
	
КонецФункции

// Прочитать файл в тексте
//
// Параметры:
//  ИмяФайла  - Строка - относительный путь к файлу который требуется прочитать как текст
//
// Возвращаемое значение:
//   Строка   - Прочитанный файл как текст
//
Функция ПрочитатьФайлВТексте(ИмяФайла)
	
	Файл = Новый Файл(ИмяФайла);
	Если Файл.Существует() Тогда
		ЧтениеТекста = Новый ЧтениеТекста(ИмяФайла, КодировкаТекста.UTF8);
		Текст = ЧтениеТекста.Прочитать();
		ЧтениеТекста.Закрыть();
		Возврат Текст;
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

// Разобрать с помощью регулярного выражения
//
// Параметры:
//  Текст  - Строка - Текст в котором требуется найти совпадения
//  ТекстРВ  - Строка - регулярное выражение которое нужно применить
//
// Возвращаемое значение:
//   Строка   - Найденное значение
//
Функция РазобратьСПомощьюРВ(Текст, ТекстРВ)
	
	РегулярноеВыражение = Новый РегулярноеВыражение(ТекстРВ);
	РегулярноеВыражение.Многострочный = Истина;
	Совпадения = РегулярноеВыражение.НайтиСовпадения(Текст);
	Если Совпадения.Количество() > 0 Тогда
		Возврат Совпадения[0].Значение;
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

Лог = ПараметрыПриложения.Лог();
