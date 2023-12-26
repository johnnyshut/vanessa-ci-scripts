#Использовать cli
#Использовать tempfiles
#Использовать "."

Перем Лог;    // Объект записи лога приложения

///////////////////////////////////////////////////////////////////////////////

Процедура ВыполнитьПриложение()

	ИмяПриложения = ПараметрыПриложения.ИмяПриложения();

	Приложение = Новый КонсольноеПриложение(ИмяПриложения,
			"Библиотека по генерации пайплайнов. Набор скриптов Continuous Integration for 1C.
			|	Формирует файл '.gitlab-ci.yml' в репозиториях проектов 1С для быстрого использования gitlab ci.",
			ЭтотОбъект);
	Приложение.Версия("version", ПараметрыПриложения.Версия());

	Приложение.Опция("v verbose", Ложь, "вывод отладочной информации в процессе выполнения")
		.Флаговый()
		.ВОкружении("VCI_VERBOSE");

	Приложение.ДобавитьКоманду("init i",
		"Инициализация структуры git репозитория. Подготовка к запуску pipeline",
		Новый КомандаInit);

	Приложение.ДобавитьКоманду("generate g",
		"Авто генерация pipeline. Во время работы ci собирает из шаблонов общий файл с шагами",
		Новый КомандаGenerateConfig);

	Приложение.ДобавитьКоманду("prepare p",
		"Подготовка окружения: скачивание OVM, установка Oscript и всех необходимых библиотек",
		Новый КомандаPrepare);

	Приложение.ДобавитьКоманду("run r",
		"Запуск скрипта из набора Vanessa CI Scripts",
		Новый КомандаRun);

	Приложение.Запустить(АргументыКоманднойСтроки);

КонецПроцедуры // ВыполнитьПриложение()

Процедура ВыполнитьКоманду(Знач КомандаПриложения) Экспорт
	
	КомандаПриложения.ВывестиСправку();
	
КонецПроцедуры

// Функция - проверяет, что приложение запущено в режиме тестирования
//
// Возвращаемое значение:
//   Булево  - Истина - приложение запущено в режиме тестирования
//
Функция ЭтоТест()
	
	Попытка
		Возврат ЭтотОбъект.ЭтоТест;
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
КонецФункции // ЭтоТест()

///////////////////////////////////////////////////////

Лог = ПараметрыПриложения.Лог();

Попытка
	ВыполнитьПриложение();
Исключение
	
	Лог.КритичнаяОшибка(ОписаниеОшибки());
	ВременныеФайлы.Удалить();
	
	Если ЭтоТест() Тогда
		ВызватьИсключение ОписаниеОшибки();
	Иначе
		ЗавершитьРаботу(1);
	КонецЕсли;
	
КонецПопытки;