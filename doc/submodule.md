# Работа с подмодулями git

Добавление подмодуля со скриптами
git submodule add --force https://gitlab.gloria.aaanet.ru/project/1s8-enterprise/vanessa-ci-scripts vendor/vanessa-ci-scripts/

Инициализации локального конфигурационного файла
git submodule init

Получения всех данных этого проекта и извлечения соответствующего коммита, указанного в основном проекте
git submodule update

Автоматически инициализирует и обновит каждый подмодуль в этом репозитории, включая вложенные подмодули, при условии, что подмодули репозитория имеют свои подмодули.
git clone --recurse-submodules https://github.com/chaconinc/MainProject

Объединяет git submodule init и git submodule update
git submodule update --init

Безопасный вариант
git submodule update --init --recursive
