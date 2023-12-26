#Использовать fs
#Использовать "..\..\..\src\"

// fs: создать отсутствующие каталоги

ФС.ОбеспечитьКаталог("./build");
ФС.ОбеспечитьКаталог("./src/cf");

// vrunner: компиляция cf файлов

МассивПараметров = Новый Массив;
МассивПараметров.Добавить("compile");
МассивПараметров.Добавить("--src ./src/cf");
МассивПараметров.Добавить("--out ./build/1Cv8.cf");

Общие.ВыполнитьСтороннююКоманду("vrunner", МассивПараметров);
