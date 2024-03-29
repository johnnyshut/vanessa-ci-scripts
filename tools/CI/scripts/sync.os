
#Использовать "..\..\..\src\"

// gitsync: запуск синхронизации хранилища 1С

МассивПараметров = Новый Массив;
МассивПараметров.Добавить("sync");

Общие.ВыполнитьСтороннююКоманду("gitsync", МассивПараметров);

// git: отправка изменений в репозиторий

Протокол = ?(ПолучитьПеременнуюСреды("CI_SERVER_PORT") = "443", "https", "http");
АдресРепозитория = СтрШаблон("%1://token:%2@%3/%4", 
	Протокол, 
	ПолучитьПеременнуюСреды("GROUP_ACCESS_TOKEN"), // TODO Переименовать переменную
	ПолучитьПеременнуюСреды("CI_SERVER_HOST"),
	ПолучитьПеременнуюСреды("CI_PROJECT_PATH"));
ВеткаРепозитория = СтрШаблон("HEAD:%1", ПолучитьПеременнуюСреды("CI_COMMIT_BRANCH"));

МассивПараметров = Новый Массив;
МассивПараметров.Добавить("push");
МассивПараметров.Добавить(АдресРепозитория);
МассивПараметров.Добавить(ВеткаРепозитория);

Общие.ВыполнитьСтороннююКоманду("git", МассивПараметров);
