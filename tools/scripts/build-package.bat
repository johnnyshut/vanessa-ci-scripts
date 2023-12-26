
chcp 65001

@REM Собрать пакет OScript
call mkdir ".\build"
call opm build --mf .\packagedef --out .\build
