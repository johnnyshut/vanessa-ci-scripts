
#Использовать "..\src\"

// sonar-scanner: запуск статической проверки кода

МассивПараметров = Новый Массив;
МассивПараметров.Добавить("-D sonar.token=" + ПолучитьПеременнуюСреды("SONAR_TOKEN"));
МассивПараметров.Добавить("-D sonar.projectVersion=" + ПараметрыПриложения.Версия());

Общие.ВыполнитьСтороннююКоманду("sonar-scanner", МассивПараметров);

