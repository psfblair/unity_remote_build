REM First command line argument is the path to the Unity folder, e.g.,
REM        C:\Program Files\Unity 5.6.0b9
REM Remaining command line arguments represent scenes to build, e.g.,
REM        Assets/Intro.unity Assets/ConwayLife.unity 

SET OUTPUT_DIR=App
SET MY_DIR=%~dp0

cd %MY_DIR%
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM First comnand line argument
SET UNITY_EXECUTABLE=%~fp1\Editor\Unity.exe
REM Strip quotes
SET UNITY_EXECUTABLE=%UNITY_EXECUTABLE:""=%

REM Get all but first command line argument 
set SCENES_TO_BUILD=
shift
:loop1
if "%1"=="" goto after_loop
set SCENES_TO_BUILD=%SCENES_TO_BUILD% %1
shift
goto loop1
:after_loop

"%UNITY_EXECUTABLE%" -batchmode -quit -projectPath %MY_DIR% -logFile "%MY_DIR%build.log" -executeMethod Autobuild.Build %SCENES_TO_BUILD%