# Собрать приложение OScript

opm build --mf .\packagedef --out .\build

## Установка из ospx

opm install -f .\build\vanessa-ci-scripts-1.0.1.ospx

## Установить oscript_module

opm install -l
