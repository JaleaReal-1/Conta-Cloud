@echo off
setlocal enabledelayedexpansion

REM Script para iniciar microservicios de Spring Boot secuencialmente (ContaCloud)
REM Ejecuta este script desde la raíz del proyecto

REM Definir lista de rutas de microservicios en orden de inicio
set "MICROSERVICES_DIR[0]=config-server"
set "MICROSERVICES_DIR[1]=dp-registry-service"
set "MICROSERVICES_DIR[2]=pd-cliente"
set "MICROSERVICES_DIR[3]=dp-inventario"
set "MICROSERVICES_DIR[4]=pd-venta"
set "MICROSERVICES_DIR[5]=dp-licencias"
set "MICROSERVICES_DIR[6]=auth-service\auth-service"
set "MICROSERVICES_DIR[7]=dp-gateway-service/dp-gateway-service"

REM Tiempo de espera entre el inicio de cada microservicio (en segundos)
set WAIT_TIME_SECONDS=16

REM Obtener directorio raíz (donde se ejecutó el script)
set "ROOT_DIR=%cd%"

echo ==========================================================
echo Iniciando microservicios de ContaCloud secuencialmente...
echo ==========================================================
echo.

for /L %%i in (0,1,7) do (
    call set "CURRENT_SERVICE=%%MICROSERVICES_DIR[%%i]%%"
    if defined CURRENT_SERVICE (
        echo ----------------------------------------------------------
        echo Iniciando microservicio: !CURRENT_SERVICE!
        echo ----------------------------------------------------------

        REM Ir a la ruta del microservicio
        cd /d "%ROOT_DIR%\!CURRENT_SERVICE!"

        REM Usar mvnw si está presente, de lo contrario usar mvn
        if exist mvnw (
            start "Microservicio: !CURRENT_SERVICE!" cmd /k ".\mvnw spring-boot:run"
        ) else (
            start "Microservicio: !CURRENT_SERVICE!" cmd /k "mvn spring-boot:run"
        )

        REM Volver a la raíz
        cd /d "%ROOT_DIR%"

        echo Esperando %WAIT_TIME_SECONDS% segundos antes del siguiente...
        timeout /t %WAIT_TIME_SECONDS% /nobreak > nul
        echo.
    )
)

echo ==========================================================
echo Todos los microservicios han sido lanzados correctamente.
echo Puedes cerrar esta ventana, los procesos seguirán corriendo.
echo ==========================================================
pause
