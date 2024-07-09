# Журнализация изменений проекта

## Версия 1.1.1

- Новый шаги deploy
- Подробный README.md
- Добавлены тесты
- Исправлены ошибки

## Версия 1.0.1

Набор скриптов Continuous Integration for 1C. Устанавливается как библиотека OScript на компьютер с ролью gitlab-runner.

Добавил библиотеку vanessa-ci-scripts, доступные команды:

- добавить файл для генерации pipeline

```shell
vci init
```

- сгенерировать pipeline

```shell
vci generate
```

- запустить скрипт из комплекта автоматизации

```shell
vci run
```

- подготовить окружение

```shell
ci prepare
```
