REM Command line argument is the name of the solution file to buikd, e.g.,
REM        ConwayLifeHoloLens.sln
SET SOLUTION_FILE_NAME=%1

SET OUTPUT_DIR=App
cd "%OUTPUT_DIR%"

REM /m enables parallel builds with MSBuild (see below)
msbuild.exe %SOLUTION_FILE_NAME% /m /t:Build /p:Configuration=Release;Platform=x86;AppxBundle=Always
