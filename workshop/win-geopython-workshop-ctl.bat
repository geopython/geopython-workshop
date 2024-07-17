@ECHO OFF

SETLOCAL EnableDelayedExpansion

SET "PROGRAM_NAME=%~nx0"

SET "USAGE=Usage: %PROGRAM_NAME% ^<start^|stop^|url^|update^|clean^>"

IF "%1"=="" (
    ECHO %USAGE%
    ENDLOCAL
    EXIT /B 1
)
IF NOT "%2"=="" (
    ECHO %USAGE%
    ENDLOCAL
    EXIT /B 1
)

REM Sniff which Docker Compose variant is installed
REM and set an alias.
REM See https://github.com/geopython/geopython-workshop/issues/82
docker-compose --version >NUL
IF !ERRORLEVEL! EQU 0 (
    SET DOCKERCOMPOSE=docker-compose
    ECHO Using docker-compose
) ELSE (
    docker compose version >NUL
    IF !ERRORLEVEL! NEQ 0 (
        ECHO Neither docker-compose nor docker compose is available
        ECHO Check your Docker Installation
        ENDLOCAL
        EXIT /B 1
    )
    SET "DOCKERCOMPOSE=docker compose"
    ECHO Using docker compose
)

REM Test for the command
IF /I "%1"=="start" (
    %PROGRAM_NAME% stop
    %DOCKERCOMPOSE% up -d
) ELSE ( IF /I "%1"=="stop" (
    %DOCKERCOMPOSE% stop
    %DOCKERCOMPOSE% rm --force
) ELSE ( IF /I "%1"=="url" (
    REM try to open the Jupyter Notebook in Browser
    REM Filter the URL from the log output
    powershell -Command "try { $url = (docker logs geopython-workshop-jupyter 2>&1 | Select-String -Pattern 'http://127\.0\.0\.1\S+token\S+')[-1].Matches[0].Value; Write-Output ('Attempting to open ' + $url + ' in your browser on platform Windows...') 'If this fails, simply copy/paste that URL in your browser'; start $url } catch { exit 2 }"
    IF !ERRORLEVEL! NEQ 0 (
        ECHO workshop not started
        ECHO did you start the workshop? (i.e. %PROGRAM_NAME% start^)
        ENDLOCAL
        EXIT /B 2
    )
) ELSE ( IF /I "%1"=="update" (
    docker pull geopython/geopython-workshop:latest
    ECHO:
    ECHO:
    ECHO workshop is running the latest Docker images
    ECHO If updates occured, then stop/start the workshop
) ELSE ( IF /I "%1"=="clean" (
    REM Remove all exited containers
    FOR /F %%c IN ('docker ps -a -f status^=exited -q') DO docker rm %%c
    REM And dangling images
    FOR /F %%i IN ('docker images -f dangling^=true -q') DO docker rmi %%i
) ELSE (
    ECHO %USAGE%
) ) ) ) )

ENDLOCAL
