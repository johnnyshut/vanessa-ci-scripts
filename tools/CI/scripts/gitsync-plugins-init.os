
#Использовать "..\..\..\src\"

ИсполняемыйФайл = Общие.ОбъединитьПутиВСтроку(ПараметрыПриложения.КаталогПриложенияИсточник(), ПараметрыПриложения.ВернутьПутьGitSync());

// gitsync: инициализация плагинов в локальном каталоге

МассивПараметров = Новый Массив;
МассивПараметров.Добавить(ИсполняемыйФайл);
МассивПараметров.Добавить("plugins");
МассивПараметров.Добавить("init");

Общие.ВыполнитьСтороннююКоманду("oscript", МассивПараметров);

// gitsync: включение плагинов 

МассивПлагинов = СтрРазделить("check-authors,increment,limit,replace-authors,smart-tags,sync-remote,unpackForm", ",", Ложь);
Для Каждого ИмяПлагина Из МассивПлагинов Цикл
	МассивПараметров = Новый Массив;
	МассивПараметров.Добавить(ИсполняемыйФайл);
	МассивПараметров.Добавить("plugins");
	МассивПараметров.Добавить("enable");
	МассивПараметров.Добавить(ИмяПлагина);

	Общие.ВыполнитьСтороннююКоманду("oscript", МассивПараметров);
КонецЦикла;