
# Включение отладки

Простое включение логов:

```bat
SET LOGOS_LEVEL=DEBUG
```

Включение всех отладочных логов:

```bat
rem только для logos версии >=0.6
set LOGOS_CONFIG=logger.rootLogger=DEBUG

call vrunner <параметры запуска>
```

Если выводится сообщение про неправильные параметры командной строки:

```bat
set LOGOS_CONFIG=logger.oscript.lib.cmdline=DEBUG
call vrunner <параметры запуска>
```

Включит отладочный лог только для библиотеки cmdline, которая анализирует параметры командной строки.
