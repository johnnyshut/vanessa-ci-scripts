
#Использовать 1testrunner
#Использовать fs

Перем ИмяКаталогаФайловПокрытия;
Перем ИспользуетсяПокрытиеКода;
Перем КаталогФайловПокрытия; 

Функция ПрогнатьТесты(Знач ПутьКТестам = "tests", Знач ПутьКОтчетуJUnit = "out")

	Тестер = Новый Тестер;
	
	Если ИспользуетсяПокрытиеКода Тогда
		Тестер.ВключитьСборСтатистикиСкриптовOnescript(Новый Файл(КаталогФайловПокрытия));
		Тестер.УстановитьФорматЛогФайла(Тестер.ФорматыЛогФайла().GenericExec);
	КонецЕсли;

	ПутьКОтчетуJUnit = Новый Файл(ПутьКОтчетуJUnit).ПолноеИмя;

	ФС.ОбеспечитьПустойКаталог(ПутьКОтчетуJUnit);

	РезультатТестирования = Тестер.ТестироватьКаталог(
		Новый Файл(ПутьКТестам),
		Новый Файл(ПутьКОтчетуJUnit)
	);

	Успешно = РезультатТестирования = 0;

	Возврат Успешно;

КонецФункции // ПрогнатьТесты()

// Основной код

Процедура ОсновнаяРабота()

	ТекущийКаталог = ТекущийКаталог();

	КаталогФайловПокрытия = ОбъединитьПути(ТекущийКаталог, ИмяКаталогаФайловПокрытия);
	ФС.ОбеспечитьПустойКаталог(КаталогФайловПокрытия);

	ИспользуетсяПокрытиеКода = Ложь;
	Для каждого Элемент Из АргументыКоманднойСтроки Цикл
		Если Элемент = "coverage" Тогда
			ИспользуетсяПокрытиеКода = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;

	Если ИспользуетсяПокрытиеКода Тогда
		ПутьКОтчетуJUnit = "out/genericexec";
	Иначе
		ПутьКОтчетуJUnit = "out/junit";
	КонецЕсли;

	Попытка
		ТестыПрошли = ПрогнатьТесты(,  ПутьКОтчетуJUnit);
	Исключение
		ТестыПрошли = Ложь;
		ПредставлениеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ОписаниеОшибки = ОписаниеОшибки();
		ТекстСообщения = СтрШаблон("Тесты через 1testrunner выполнены неудачно
			|%1
			|%2", ПредставлениеОшибки, ОписаниеОшибки);
		Сообщить(ТекстСообщения);
	КонецПопытки;

	УстановитьТекущийКаталог(ТекущийКаталог);

	Если Не ТестыПрошли Тогда
		ВызватьИсключение "Тестирование завершилось неудачно!";
	Иначе
		ТекстСообщения = СтрШаблон("Результат прогона тестов <%1>
			|", ТестыПрошли);
		Сообщить(ТекстСообщения);
	КонецЕсли;

КонецПроцедуры

ИмяКаталогаФайловПокрытия = "coverage";

ОсновнаяРабота();
