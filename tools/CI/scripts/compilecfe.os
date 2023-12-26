#Использовать fs
#Использовать "..\..\..\src\"

// fs: создать отсутствующие каталоги

ФС.ОбеспечитьКаталог("./build/cfe");
ФС.ОбеспечитьКаталог("./src/cfe");

// ФС: поиск каталогов с расширениями

Если Не ФС.КаталогПустой("./src/cfe") Тогда
	НайденныеФайлы = НайтиФайлы("./src/cfe", "Configuration.xml", Истина);
	Для Каждого Файл Из НайденныеФайлы Цикл
		МассивПути = СтрРазделить(Файл.Путь, "\");
		ИмяРасширения = МассивПути[МассивПути.Количество() - 2];
		ИмяРасширенияСТипом = СтрШаблон("%1.cfe", ИмяРасширения);
		
		// vrunner: компиляция cfe файлов

		МассивПараметров = Новый Массив;
		МассивПараметров.Добавить("compileexttocfe");
		МассивПараметров.Добавить("--src ./src/cfe/" + ИмяРасширения);
		МассивПараметров.Добавить("--out ./build/cfe/" + ИмяРасширенияСТипом);
		
		Общие.ВыполнитьСтороннююКоманду("vrunner", МассивПараметров);

		// vrunner: запуск команды загрузки cfe в толстом клиенте

		СтрокаПарам1 = СтрШаблон("--command ""$workspaceRoot/%1,build/loadExt.log""", ИмяРасширенияСТипом);

		МассивПараметров = Новый Массив;
		МассивПараметров.Добавить("run");
		МассивПараметров.Добавить(СтрокаПарам1);
		МассивПараметров.Добавить("--execute $runnerRoot\epf\ЗагрузитьРасширение.epf");
		МассивПараметров.Добавить("--settings tools/JSON/vrunner.json");
		
		Общие.ВыполнитьСтороннююКоманду("vrunner", МассивПараметров);

	КонецЦикла;
КонецЕсли;
