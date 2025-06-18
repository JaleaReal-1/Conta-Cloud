@echo off
REM Script para iniciar microservicios de Spring Boot secuencialmente (ContaCloud)
REM Ejecuta esto desde la raíz de tu proyecto

REM Lista de microservicios en orden de inicio
set "MICROSERVICES_DIR[0]=config-server"
set "MICROSERVICES_DIR[1]=dp-registry-service"
set "MICROSERVICES_DIR[2]=pd-cliente"
set "MICROSERVICES_DIR[3]=dp-inventario"
set "MICROSERVICES_DIR[4]=pd-venta"
set "MICROSERVICES_DIR[5]=dp-licencias"
set "MICROSERVICES_DIR[6]=dp-facturation"
set "MICROSERVICES_DIR[7]=auth-service\auth-service"
set "MICROSERVICES_DIR[8]=dp-gateway-service"

REM Tiempo de espera entre microservicios
set WAIT_TIME_SECONDS=12

echo Iniciando microservicios secuencialmente...
echo.

for /L %%i in (0,1,8) do (
    REM Verifica si el índice existe
    call set "CURRENT_SERVICE=%%MICROSERVICES_DIR[%%i]%%"
    if defined CURRENT_SERVICE (
        echo ==========================================================
        echo Iniciando: !CURRENT_SERVICE!
        echo ==========================================================
        
        cd "!CURRENT_SERVICE!"

        REM Abre una nueva ventana con mvn spring-boot:run
        start "Microservicio: !CURRENT_SERVICE!" cmd /k "mvn spring-boot:run"


        cd ..
        echo.
        echo Esperando %WAIT_TIME_SECONDS% segundos...
        timeout /t %WAIT_TIME_SECONDS% /nobreak > nul
        echo.
    )
)

echo ==========================================================
echo Todos los microservicios han sido lanzados correctamente.
echo ==========================================================
pause
