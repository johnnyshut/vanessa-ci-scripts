
#Использовать "..\..\..\src\"

ИсполняемыйФайл = Общие.ОбъединитьПутиВСтроку(ПараметрыПриложения.КаталогПриложенияИсточник(), ПараметрыПриложения.ВернутьПутьVrunner());

// vrunner: Синтаксический контроль

МассивПараметров = Новый Массив;
МассивПараметров.Добавить(ИсполняемыйФайл);
МассивПараметров.Добавить("syntax-check");

Общие.ВыполнитьСтороннююКоманду("oscript", МассивПараметров);
