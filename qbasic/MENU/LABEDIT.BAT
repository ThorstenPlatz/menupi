@ECHO OFF
cls
echo.
echo.
echo.
echo.
echo ACHTUNG:
echo         Wenn Sie diese Programm das erste mal starten müssen Sie
echo         den Pfad für gespeicherte Dateien im Hauptprogramm anpassen
echo.
echo         Ändern Sie dafür den Pfad im Ausdruck ' path$ = "..." ' in
echo         der Datei ' labedit.bas ' im Verzeichnis ' Laby ' !!!!!!!!!
echo.
echo.
echo.
pause > nul
cls
qbasic /run laby\labedit.bas
