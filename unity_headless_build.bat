REM First command line argument is the path to the Unity folder, e.g.,
REM        C:\Program Files\Unity 5.6.0b9
REM Remaining command line arguments represent scenes to build, e.g.,
REM        Assets/Intro.unity Assets/ConwayLife.unity 

SET OUTPUT_DIR=App

cd %~dp0
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM First comnand line argument
SET UNITY_FOLDER=%~f1
REM Get all but first command line argument 
for /f "tokens=1,* delims= " %%a in ("%*") do set SCENES_TO_BUILD=%%b

"%UNITY_FOLDER%" -batchmode -quit -projectPath %~dp0 -executeMethod Autobuild.Build %SCENES_TO_BUILD%