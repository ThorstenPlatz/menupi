@ECHO OFF
cls
echo.
echo.
echo.
echo.
echo ACHTUNG:
echo         Wenn Sie diese Programm das erste mal starten m�ssen Sie
echo         den Pfad f�r gespeicherte Dateien im Hauptprogramm anpassen
echo.
echo         �ndern Sie daf�r den Pfad im Ausdruck ' path$ = "..." ' in
echo         der Datei ' laby.bas ' im Verzeichnis ' Laby ' !!!!!!!!!
echo.
echo.
echo.
pause > nul
cls
qbasic /run laby\laby.bas
