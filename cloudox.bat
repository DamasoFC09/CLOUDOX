@echo off

set ruta="%~dp0"
setLocal EnableDelayedExpansion
title CLOUDOX v0.0
REM Cloudox. Programa de almacenamiento de archivos y registros
set version=0.0
for /f "delims=" %%y in ('date /t') do (
    set fecha=%%y
)
for /f "delims=" %%h in ('time /t') do (
    set hora=%%h
)

REM INICIO --------------
:inicio
color 74
cls
call :logos
echo    BIENVENIDO A CLOUDOX. Administrador de archivos y carpetas.
echo    ver. !version!
echo.
echo    - Codigo abierto y gratuito.
echo    - Creado por: DamasoFC
echo.
echo    Fecha: !fecha!
echo    Hora: !hora!
echo.
echo  Presione una tecla para continuar . . .
timeout /t 3000 > nul


REM MENU --------------- MENU ----------- MENU
:menu
cls
color 0f
call :logos
echo  =====================================================================================================================
echo  -                                                                                                                   /
echo  -                                              =/= ELIJA UNA OPCION =/=                                            /
echo  -                                                                                                                 /
echo  =====================================================================================================================
echo  =                                                                                                                   /
echo  =     [1] Varios.  Varias funciones como: Abrir cmd / powershell / explorador de archivos                          /
echo  =                                                                                                                 /
echo  =     [2] Comprimir.  Comprime en un archivo .zip algun archivo o carpeta                                        /
echo  =                                                                                                               /
echo  =     [3] Respaldar.  Guarda una copia de algun archivo o carpeta                                              /
echo  =                                                                                                              \
echo  =     [4] Ubicacion.  Cambia del directorio actual                                                              \
echo  =                                                                                                                \
echo  =     [5] Salir.  Sale del programa                                                                               \
echo  =                                                                                                                  \
echo  ====================================================================================================================
echo.
echo   Directorio actual %CD%
echo.
echo  --------------------------------------------------------------------------------------------------------------------
echo.
for /f "delims=" %%i in ('dir') do (
    echo   %%i
)
echo.
echo  ----------------------------------------------------------------------
echo.
choice /c 12345 /m " Elija una opcion "
echo.

REM OPCIONES-----------OPCIONES---------OPCIONES

if errorlevel 5 (
    goto final
    color 07
    exit /b
)
if errorlevel 4 (
    goto ubicacion
)
if errorlevel 3 (
    goto respaldar
)
if errorlevel 2 (
    goto compresion
)
if errorlevel 1 (
    goto varios
)


REM FUNCIONES-------------------------------------------------FUNCIONES-------------------------------------------FUNCIONES

REM FUNCION DE ----------------- SALIDA
:final
cls
call :logos
color 0f
echo  =============================================================================================/\
echo  -                                    FINALIZAR                                              /  \
echo  ===========================================================================================/ -- \
echo  =                   Desea continuar o finalizar el programa                               /  --  \
echo  = Es posible que haya que presionar finalizar varias veces para salir del programa       /   --   \
echo  =                                                                                       /    --    \
echo  =      [1]  Finalizar                                                                  /     --     \
echo  =                                                                                     /              \
echo  =      [2]  Continuar                                                                /       00       \
echo  =                                                                                   /        00        \
echo  ===================================================================================/--------------------\
set /p finalizacion=Elija una opcion: 
if !finalizacion! EQU 1 (
    color 07
    exit /b
) else if !finalizacion! EQU 2 (
    goto menu
) else (
    call :ERROR
    echo  ---------------------------------------
    echo    La respuesta debe estar entre 2 y 1
    echo  ---------------------------------------
    color 04
    echo  Presione una tecla para continuar . . .
    timeout /t 3000 > nul
    goto final
)


REM FUNCION DE ------------------- UBICACION
:ubicacion
color 0f
set dactual="%CD%"
cls
call :logos
echo =====================================================================================================================
echo ?                                                ? UBICACION ?                                                      ?
echo =====================================================================================================================
echo.
echo   Directorio actual %CD%
echo.
for /f "delims=" %%i in ('dir /ad /b') do (
    echo  %%i
)
echo.
echo ---------------------------------------------------------------------------------------------------------------------
echo.
echo   Directorio padre
echo.
cd .. && for /f "delims=" %%i in ('dir /ad /b') do (
    echo  %%i
)
cd "!dactual!"
echo.
echo ---------------------------------------------------------------------------------------------------------------------
echo -                                           Cambiar de directorio                                                   -
echo ---------------------------------------------------------------------------------------------------------------------
echo  Escriba ".." para ir al directorio padre
echo.
echo  Escriba el directorio al que desea moverse [Dijite un punto [.] para cancelar esta accion]
echo.
set "move="
set /p move=cd 

if /i "!move!"=="." (
    goto menu
)
cd "%move%" 2> nul
if errorlevel 1 (
    call :ERROR
    goto ubicacion
)
echo.
if "!move!"==".." (
    echo  Se ha movido al directorio padre, su ubicacion actual es: "%CD%"
    echo.
    echo ---------------------------------------------------------------------------------------------------------------------
    timeout /t 3 >nul
) else (
    echo  Se ha movido al directorio "!move!", su ubicacion actual es: "%CD%"
    echo.
    echo ---------------------------------------------------------------------------------------------------------------------
    timeout /t 3 >nul
)
echo.
for /f "delims=" %%d in ('dir') do (
    echo  %%d
)
echo.
echo ---------------------------------------------------------------------------------------------------------------------
echo  Presione una tecla para continuar . . .
timeout /t 3000 > nul
goto menu


REM FUNCION DE ---------------------------------------- RESPALDAR
:respaldar
cls
color 0f
call :logos
echo =====================================================================================================================
echo +                                                + RESPALDAR +                                                      +
echo =====================================================================================================================
echo.
echo   Bienvenido a la seccion de respaldo, elejira un archivo al cual desee respaldar siendo copiado y enviado a una carpeta llamada "Respaldo".
echo   Las Carpetas se comprimiran, para ser enviadas a la carpeta destino de respaldo.
echo.
echo   PARA SALIR DE ALGUNA OPCION Y VOLVER AL MENU PRICIPAL DIJITE UN PUNTO [.].
echo.
echo  Puede elejir si guardar el archivo o carpeta en:
echo.
echo  - Una carpeta nueva dentro del mismo directorio. 
echo  Direccion directorio actual: "%CD%"
set directR="%CD%"
echo.
echo  - Dentro de su carpeta de usuario.
echo  Direccion directorio de usuario: "%HOMEPATH%"
set homeR="%HOMEPATH%"
echo.
echo  - Dentro de la carpeta de respaldo del programa CLOUDOX. [Recomendado]
echo  Direccion directorio respaldo CLOUDOX: "%~dp0"
set cloudoxR="%~dp0"
echo.
echo ---------------------------------------------------------------------------------------------------------------------
echo.
echo                                    + Archivos y Carpetas del directorio actual +
echo.
for /f "delims=" %%i in ('dir') do (
    echo  %%i
)
echo.
echo ---------------------------------------------------------------------------------------------------------------------
echo.
echo                                                    + PROCESO +
echo.
echo ---------------------------------------------------------------------------------------------------------------------
echo.
set /p AC=Seleccione si es Archivo [A] o Carpeta [C]: 
if "!AC!"=="." (
    goto menu
)
echo.
set /p N=Inserte el nombre del Archivo o Carpeta: 
if "!N!"=="." (
    goto menu
)
echo.
set /p D=Seleccione la ubicacion. Directorio actual [1], Directorio Usuario [2], Directorio CLOUDOX [3]: 
if "!D!"=="." (
    goto menu
)
echo.
echo ---------------------------------------------------------------------------------------------------------------------
echo.
for /f "delims=" %%h in ('time /t') do (
    set horaA=%%h
)
if /i "!AC!"=="A" (
    if !D! EQU 1 (
        if not exist !N! (
            call :ERROR
            echo  ---------------------------------------
            echo  =       EL ARCHIVO NO EXISTE          =
            echo  ---------------------------------------
            color 04
            echo  Presione una tecla para continuar . . .
            timeout /t 3000 > nul
            goto respaldar
        )
        if not exist "%CD%\Respaldo" (
            mkdir Respaldo
        )
        copy "%CD%\!N!" "%CD%\Respaldo\respaldo_!N!"
        echo.
        echo  Archivo respaldado en la carpeta "Respaldo", de este mismo directorio.
        echo.
        for /f "delims=" %%i in ('dir') do (
            echo  %%i
        )
        echo.
        echo ---------------------------------------------------------------------------------------------------------------------
    ) else if !D! EQU 2 (
        if not exist !N! (
            call :ERROR
            echo  ---------------------------------------
            echo  =       EL ARCHIVO NO EXISTE          =
            echo  ---------------------------------------
            color 04
            echo  Presione una tecla para continuar . . .
            timeout /t 3000 > nul
            goto respaldar
        )
        if not exist "%HOMEPATH%\Respaldo" (
            cd "c:%HOMEPATH%" && mkdir Respaldo
            cd "!directR!"
        )
        copy "%CD%\!N!" "c:%HOMEPATH%\Respaldo\respaldo_!N!"
        echo.
        echo  Archivo respaldado en la carpeta "Respaldo", del diretorio del usuario.
        echo.
        for /f "delims=" %%i in ('dir') do (
            echo  %%i
        )
        echo.
        echo ---------------------------------------------------------------------------------------------------------------------
    ) else if !D! EQU 3 (
        if not exist !N! (
            call :ERROR
            echo  ---------------------------------------
            echo  =       EL ARCHIVO NO EXISTE          =
            echo  ---------------------------------------
            color 04
            echo  Presione una tecla para continuar . . .
            timeout /t 3000 > nul
            goto respaldar
        )
        copy "%CD%\!N!" "%~dp0\Respaldo\respaldo_!N!"
        echo.
        echo  Archivo respaldado en la carpeta "Respaldo", del programa CLOUDOX.
        echo.
        for /f "delims=" %%i in ('dir') do (
            echo  %%i
        )
        echo.
        echo ---------------------------------------------------------------------------------------------------------------------
    ) else (
        call :ERROR
        goto respaldar
    )
) else if /i "!AC!"=="C" (
    if !D! EQU 1 (
        if not exist "%CD%\!N!" (
            call :ERROR
            echo  --------------------------------------------
            echo  =         EL DIRECTORIO NO EXISTE          =
            echo  --------------------------------------------
            color 04
            echo  Presione una tecla para continuar . . .
            timeout /t 3000 > nul
            goto respaldar
        )
        if not exist "%CD%\Respaldo" (
            mkdir Respaldo
        )
        powershell Compress-Archive -Path "%CD%\!N!" -DestinationPath "%CD%\Respaldo\respaldo_!N!.zip"
        echo.
        echo  Carpeta comprimida y respaldada en la carpeta "Respaldo", de este mismo directorio.
        echo.
        for /f "delims=" %%i in ('dir') do (
            echo  %%i
        )
        echo.
        echo ---------------------------------------------------------------------------------------------------------------------
    ) else if !D! EQU 2 (
        if not exist "%CD%\!N!" (
            call :ERROR
            echo  --------------------------------------------
            echo  =         EL DIRECTORIO NO EXISTE          =
            echo  --------------------------------------------
            color 04
            echo  Presione una tecla para continuar . . .
            timeout /t 3000 > nul
            goto respaldar
        )
        if not exist "%HOMEPATH%\Respaldo" (
            cd "c:%HOMEPATH%" && mkdir Respaldo
            cd "!directR!"
        )
        powershell Compress-Archive -Path "%CD%\!N!" -DestinationPath "c:%HOMEPATH%\Respaldo\respaldo_!N!.zip"
        echo.
        echo  Carpeta comprimida y respaldada en la carpeta "Respaldo", del diretorio del usuario.
        echo.
        for /f "delims=" %%i in ('dir') do (
            echo  %%i
        )
        echo.
        echo ---------------------------------------------------------------------------------------------------------------------
    ) else if !D! EQU 3 (
        if not exist "%CD%\!N!" (
            call :ERROR
            echo  --------------------------------------------
            echo  =         EL DIRECTORIO NO EXISTE          =
            echo  --------------------------------------------
            color 04
            echo  Presione una tecla para continuar . . .
            timeout /t 3000 > nul
            goto respaldar
        )
        powershell Compress-Archive -Path "%CD%\!N!" -DestinationPath "%~dp0\Respaldo\respaldo_!N!.zip"
        echo.
        echo  Carpeta comprimida y respaldada en la carpeta "Respaldo", del programa CLOUDOX.
        echo.
        for /f "delims=" %%i in ('dir') do (
            echo  %%i
        )
        echo.
        echo ---------------------------------------------------------------------------------------------------------------------
    ) else (
        call :ERROR
        goto respaldar
    )
) else (
    call :ERROR
    goto respaldar
)
echo  Presione una tecla para continuar . . .
timeout /t 3000 > nul
goto menu


REM FUNCION DE ------------------- ERROR
:ERROR
cls
color 04
call :logos
echo =====================================================================================================================
echo -                                      VALOR NO VALIDO O INCORRECTO                                                 -
echo =====================================================================================================================
echo  Presione una tecla para continuar . . .
timeout /t 3000 > nul
echo.
color 0f
exit /b


REM FUNCION: COMPRIMIR --------------------------------------------- COMPRESION
:compresion
cls
color 0f
call :logos
echo =====================================================================================================================
echo -                                                - COMPRIMIR -                                                      -
echo =====================================================================================================================
echo.
echo    Directorio actual "%CD%"
echo.
for /f "delims=" %%i in ('dir /a-d /b') do (
    echo  Archivo: %%i
)
echo.
for /f "delims=" %%i in ('dir /ad /b') do (
    echo  Carpeta: %%i
)
echo.
echo ---------------------------------------------------------------------------------------------------------------------
echo.
echo     Para la compresion de archivos y carpetas, elejira un archivo o carpeta y se comprimira en un archivo .zip
echo   este archivo se guardara con el mismo nombre del archivo o carpeta comprimido, si el .zip ya existe entonces
echo   el programa pedira que cambie el nombre del .zip para poder volver a comprimir.
echo.
echo   PARA VOLVER AL MENU PRINCIPAL EN CUALQUIERA DE LAS OPCIONES DIJITE UN PUNTO [.]
echo.
set "nombre_compresion="
set /p nombre_compresion=Escriba el nombre del archivo o carpeta: 
if "!nombre_compresion!"=="." (
    goto menu
)
echo.
if not exist "%CD%\!nombre_compresion!" (
    call :ERROR
    echo  ------------------------------------------------------
    echo  =         EL ARCHIVO O DIRECTORIO NO EXISTE          =
    echo  ------------------------------------------------------
    color 04
    echo  Presione una tecla para continuar . . .
    timeout /t 3000 > nul
    goto compresion
)
if exist "%CD%\!nombre_compresion!.zip" (
    call :ERROR
    echo  -----------------------------------------------------------
    echo  =         EL ARCHIVO O DIRECTORIO YA / SI EXISTE          =
    echo  -----------------------------------------------------------
    color 04
    echo  Presione una tecla para continuar . . .
    timeout /t 3000 > nul
    color 0f
    echo.
    echo  ==========================================================================================
    echo  =                                                                                        =
    echo  =     DIJITE UN NUEVO NOMBRE PARA EL ARCHIVO .zip QUE NO SEA IGUAL AL YA EXISTENTE       =
    echo  =                                                                                        =
    echo  =  Si el nombre es identico al original se reemplazara el archivo con nueva informacion  =
    echo  =                                                                                        =
    echo  =  Para cancelar cualquier accion y volver al menu principal dijite un punto [.]         =
    echo  =                                                                                        =
    echo  ==========================================================================================
    set "nuevo_nombre="
    set /p nuevo_nombre=Nuevo nombre, sin la extension .zip: 
    if "!nuevo_nombre!"=="." (
        goto menu
    )
    if exist "%CD%\!nuevo_nombre!.zip" (
        del !nuevo_nombre!.zip
        powershell Compress-Archive -Path "%CD%\!nuevo_nombre!" -DestinationPath "%CD%\!nuevo_nombre!.zip"
        echo  Comprimido y reemplazado con exito.
        echo.
        echo  Presione una tecla para continuar . . .
        timeout /t 3000 > nul
        goto menu
    )
    echo.
    powershell Compress-Archive -Path "%CD%\!nombre_compresion!" -DestinationPath "%CD%\!nuevo_nombre!.zip"
    echo  Comprimido con exito.
    echo.
    echo  Presione una tecla para continuar . . .
    timeout /t 3000 > nul
    goto menu
)
powershell Compress-Archive -Path "%CD%\!nombre_compresion!" -DestinationPath "%CD%\!nombre_compresion!.zip"
echo  Comprimido con exito.
echo.
echo  Presione una tecla para continuar . . .
timeout /t 3000 > nul
goto menu


REM FUNCION: VARIOS ------------------------------------------------ VARIOS --------------------------------- VARIOS
:varios
color 0f
call :logos
echo  ================================================================================================================================================================
echo   \                                                                  /              \                                                                          /
echo    \                                                                / MENU DE VARIOS \                                                                        /
echo     \                                                              /                  \                                                                      /
echo      =============================================================/====================\=====================================================================
echo                                                                  /                      \
echo  ===============================================================/                        \==================================================================\
echo  =                                                     =                                           =                                                         \
echo  =                     EXPLORADOR                      =                    CMD                    =                 POWERSHELL                               \
echo  =                                                     =                                           =                                                           \
echo  =         Abre el explorador de archivos en el        =      Inicia una sesion de CMD en el       =     Inicia una sesion de POWERSHELL en el                  \
echo  =                 directorio actual                   =             directorio actual             =             directorio actual                              /
echo  =                                                     =                                           =                                                           /
echo  =                        [1]                          =                    [2]                    =                     [3]                                  /
echo  =                                                     =                                           =                                                         /
echo  ===========================================================================================================================================================/
echo.
echo  Directorio actual: "%CD%"
echo.
set /p varios=Elija una opcion: 
if !varios! EQU 1 (
    echo.
    start .
    echo  Presione una tecla para continuar . . .
    timeout /t 90000 > nul
    goto menu
) else if !varios! EQU 2 (
    echo.
    echo  Iniciando CMD
    echo.
    start cmd
    echo  Presione una tecla para continuar . . .
    timeout /t 90000 > nul
    goto menu
) else if !varios! EQU 3 (
    echo.
    echo  Iniciando POWERSHELL
    echo.
    start powershell
    echo  Presione una tecla para continuar . . .
    timeout /t 90000 > nul
    goto menu
) else (
    call :ERROR
    goto varios
)
echo  Presione una tecla para continuar . . .
timeout /t 3000 > nul
goto menu


REM FUNCION: CLOUDOX ---------------------------------------------------------------- CLOUDOX
:logos
cls
echo.
echo  ================================================================================================================================================================
echo  =                                                                                                                                                              =
echo  =       CCCCCCCCCCCCCCCC   LLLL                   OOOOOOOO        UUUU          UUUU   DDDDDDDDDDDD     /          OOOOOOOO        XXXX          XXXX          =
echo  =     CCCCCCCCCCCCCCCCC    LLLL                OOOOOOOOOOOOOO     UUUU          UUUU   DD        DDD   /        OOOOOOOOOOOOOO      XXXX        XXXX           =
echo  =    CCCCCC                LLLL               OOOOO      OOOOO    UUUU          UUUU   DD          DD /        OOOOO      OOOOO      XXXX      XXXX            =
echo  =    CCCCC                 LLLL              OOOOO        OOOOO   UUUU          UUUU   DD        DDD /        OOOOO        OOOOO      XXXX    XXXX             =
echo  =    CCCCC                 LLLL             OOOOO          OOOOO  UUUU          UUUU   DDDDDDDDDDDD /        OOOOO          OOOOO      XXXX  XXXX              =
echo  =    CCCCC                 LLLL             OOOOO          OOOOO  UUUU          UUUU         =======         OOOOO          OOOOO       XXXXXXXX               =
echo  =    CCCCC                 LLLL             OOOOO          OOOOO  UUUU          UUUU        /DDDDDDDDDDDD    OOOOO          OOOOO      XXXX  XXXX              =
echo  =    CCCCC                 LLLL              OOOOO        OOOOO   UUUU          UUUU       / DD        DDD    OOOOO        OOOOO      XXXX    XXXX             =
echo  =    CCCCCC                LLLL               OOOOO      OOOOO    UUUUU        UUUUU      /  DD          DD    OOOOO      OOOOO      XXXX      XXXX            =
echo  =     CCCCCCCCCCCCCCCCC    LLLLLLLLLLLLLLLL    OOOOOOOOOOOOOO      UUUUUUUUUUUUUUUU      /   DD        DDD      OOOOOOOOOOOOOO      XXXX        XXXX           = 
echo  =       CCCCCCCCCCCCCCCC   LLLLLLLLLLLLLLLL       OOOOOOOO          UUUUUUUUUUUUUU      /    DDDDDDDDDDDD          OOOOOOOO        XXXX          XXXX          =  VER. !version!
echo  =                                                                                                                                                              =
echo  ================================================================================================================================================================
echo.
exit /b