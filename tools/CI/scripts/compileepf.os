
#Использовать fs
#Использовать "..\..\..\src\"

// fs: создать отсутствующие каталоги

ФС.ОбеспечитьКаталог("./build");
ФС.ОбеспечитьКаталог("./src/epf");
ФС.ОбеспечитьКаталог("./src/erf");
ФС.ОбеспечитьКаталог("./src/tools");
ФС.ОбеспечитьКаталог("./src/tests");

// vrunner: компиляция epf файлов

МассивПараметров = Новый Массив;
МассивПараметров.Добавить("compileepf");
МассивПараметров.Добавить("./src/epf");
МассивПараметров.Добавить("./build/epf");

Общие.ВыполнитьСтороннююКоманду("vrunner", МассивПараметров);

// vrunner: компиляция erf файлов

МассивПараметров = Новый Массив;
МассивПараметров.Добавить("compileepf");
МассивПараметров.Добавить("./src/erf");
МассивПараметров.Добавить("./build/erf");

Общие.ВыполнитьСтороннююКоманду("vrunner", МассивПараметров);

// vrunner: компиляция служебных epf файлов

МассивПараметров = Новый Массив;
МассивПараметров.Добавить("compileepf");
МассивПараметров.Добавить("./src/tools");
МассивПараметров.Добавить("./tools/epf");

Общие.ВыполнитьСтороннююКоманду("vrunner", МассивПараметров);

// vrunner: компиляция tdd epf файлов

МассивПараметров = Новый Массив;
МассивПараметров.Добавить("compileepf");
МассивПараметров.Добавить("./src/tests");
МассивПараметров.Добавить("./tests/smoke");

Общие.ВыполнитьСтороннююКоманду("vrunner", МассивПараметров);
