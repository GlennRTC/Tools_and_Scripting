@echo off
setlocal enabledelayedexpansion

:: Definir variables
set "SERVICE=Omnilab_Analyser_Manager_CDRUBYPER"
set "WAIT_TIME=100"
set "LOG_FILE=%SYSTEMROOT%\Logs\ServiceRestart_%SERVICE%.log"

:: Crear directorio de logs si no existe
if not exist "%SYSTEMROOT%\Logs" mkdir "%SYSTEMROOT%\Logs"

:: Agregar nueva entrada al archivo de log con fecha y hora
echo. >> "%LOG_FILE%"
echo ========================================================= >> "%LOG_FILE%"
echo Iniciando reinicio del servicio %SERVICE% - %date% %time% >> "%LOG_FILE%"
echo ========================================================= >> "%LOG_FILE%"

:: Intentar detener el servicio
echo Deteniendo servicio %SERVICE%... >> "%LOG_FILE%"
SC STOP %SERVICE% >> "%LOG_FILE%" 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: No se pudo detener el servicio %SERVICE%. Codigo: %ERRORLEVEL% >> "%LOG_FILE%"
    goto :ERROR
) else (
    echo Servicio detenido correctamente. >> "%LOG_FILE%"
)

:: Esperar el tiempo especificado
echo Esperando %WAIT_TIME% segundos... >> "%LOG_FILE%"
ping -n %WAIT_TIME% 127.0.0.1 > nul

:: Intentar iniciar el servicio
echo Iniciando servicio %SERVICE%... >> "%LOG_FILE%"
SC START %SERVICE% >> "%LOG_FILE%" 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: No se pudo iniciar el servicio %SERVICE%. Codigo: %ERRORLEVEL% >> "%LOG_FILE%"
    goto :ERROR
) else (
    echo Servicio iniciado correctamente. >> "%LOG_FILE%"
)

:: Verificar estado final
echo Verificando estado del servicio... >> "%LOG_FILE%"
SC QUERY %SERVICE% | findstr "STATE" >> "%LOG_FILE%" 2>&1

echo Reinicio completado exitosamente - %date% %time% >> "%LOG_FILE%"
goto :END

:ERROR
echo Proceso finalizado con errores - %date% %time% >> "%LOG_FILE%"
exit /b 1

:END
echo Proceso finalizado correctamente - %date% %time% >> "%LOG_FILE%"
exit /b 0
