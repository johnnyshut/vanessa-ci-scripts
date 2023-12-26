# vanessa-ci-scripts

Набор скриптов Continuous Integration for 1C. Устанавливается как библиотека OScript на компьютер с ролью gitlab-runner.
Предназначена для быстрого перехода к использованию gitlab pipeline.

## Использование библиотеки

Проект опирается на структуру каталогов и файлов настроек из проектов:

- [vanessa-opensource/vanessa-bootstrap](https://github.com/vanessa-opensource/vanessa-bootstrap)
- [vanessa-opensource/vanessa-runner](https://github.com/vanessa-opensource/vanessa-runner)
- [vanessa-opensource/add](https://github.com/vanessa-opensource/add)

**Важно! Если ваш проект отличается от описанных шаблонов, то pipeline выполнится с ошибками.**

В каталоге [```template\test-vci.zip```](./template/test-vci.zip) хранится пример пустого проекта, в котором можно посмотреть структуру и файлы настроек которые требуются для работы ```vanessa-ci-scripts```

### Порядок установки

Скачайте и установите библиотеку через hub.oscript с помощью скрипта:

- [```tools\scripts\install-package-from-hub.bat```](./tools/scripts/install-package-from-hub.bat)

Или собрав и установив библиотеку из пакета в формате ```.*ospx``` с помощью скриптов:

- [```tools\scripts\build-package.bat```](./tools/scripts/build-package.bat)
- [```tools\scripts\install-package-from-ospx.bat```](./tools/scripts/install-package-from-ospx.bat)

### Порядок использования

Чтобы начать работу, нужно клонировать ваш удаленный репозиторий с сервера ```https://gitlab.com/```.
Открыть командную строку в проекте.
И выполните команду:

```Shell
vci init
```

В корне проекта будет создан файл ```.gitlab-ci.yml```
Отправьте изменения в удаленный репозиторий, чтобы запустить pipeline

```Shell
vci generate
```

```Shell
vci prepare
```

```Shell
vci run
```

## Возможности доработки библиотеки

- откройте issue - если вам не хватает какого то функционала для вашего pipeline
- войдите в чат Телеграм - чтобы задать дополнительные вопросы [![telegram](https://img.shields.io/badge/telegram-chat-green.svg)](https://t.me/oscript_library)
- сделайте fork, внесите изменения и выполните pull request с предлагаемыми вами изменениями (fork и pull request - это кнопки на GitHub|GitLab.)

## Публикация релиза

После внесения изменений требуется изменить версию библиотеки:

- Изменить функцию ```Версия``` в файле [```src\Модули\ПараметрыПриложения.os```](./src/Модули/ПараметрыПриложения.os)
- Изменить тэг ```<version>1.0.1</version>``` в файле [```opm-metadata.xml```](./opm-metadata.xml)
- Добавить информацию об изменениях в файл [```CHANGELOG.md```](./CHANGELOG.md)
- добавить ```tag``` командой ```git tag -a 1.0.1 -m "version 1.0.1"``` и отправить в удаленный репозиторий ```git push origin --tags``` ([Подсказка по работе с тэгами](./doc/git-tag.md))

## Включение отладки

[По ссылке](./doc/debug.md)

## Благодарность

- Opensource сообществу 1C и OneScript
- [Сергею Голованову](https://t.me/GolovanoffSergio) за презентацию на "Infostart Event 2023"
- [Никите Федькину](https://t.me/nixel2007) за ответы на вопросы
- Всем кто отвечал на мои вопросы
