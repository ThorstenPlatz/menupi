DIM SHARED k$, x, y, r, wall(27, 80) 'k$ = Tastatureingaben; x, y = Spielerposition; r = Richtung, wall(x,y) = Bildschirm-Feld
DIM SHARED xb, yb, count, b, p%, countdown, speed 'b = Anzahl der Bomben; p% = BombenstÑrke
DIM SHARED xf, yf, rf, yfold, xfold, enemykilled, file$, path$
DECLARE SUB tast ()
DECLARE SUB wallset ()
DECLARE SUB drawworm ()
DECLARE SUB drawenemy ()
DECLARE SUB drawlab ()
DECLARE SUB symbols ()
DECLARE SUB bomb ()
DECLARE SUB gameover ()
DECLARE SUB goodies ()
DECLARE SUB enemy ()
DECLARE SUB pause ()
DECLARE SUB load ()
DECLARE SUB help ()

path$ = "a:\program\laby\labs" '!!!! Pfadangabe fÅr Labs !!!!

'--- Programm start ---
SCREEN 12: CLS
OPEN (path$ + "\standard.lab") FOR OUTPUT AS #1
CLOSE #1
wallset
CLS : enemykilled = 0
yf = 17: xf = 64
b = 3: p% = 3

start:
anfang = TIMER
DO
 IF starter = 1 THEN GOTO start
 FOR j# = 1 TO speed: NEXT j#'Spielgeschwindigkeit
 SELECT CASE count
 CASE 1
  IF b = 0 THEN SOUND 100, 1: count = 0
  IF b > 0 THEN COLOR 12: LOCATE yb, xb: PRINT "B": IF TIMER - countdown > 2 THEN bomb
 CASE 0
  yb = y: xb = x
 END SELECT
 drawlab
 tast
 drawworm
 goodies
 IF enemykilled = 0 THEN drawenemy
 COLOR 5
 LOCATE 1, 5: PRINT "Zeit: "; USING "####"; (TIMER - anfang)
 LOCATE 1, 74: PRINT "B: "; b
 LOCATE 28, 5: PRINT "(L)aden"
 LOCATE 28, 38: PRINT "Hilfe: F1"
 LOCATE 28, 65: PRINT "Beenden: ESC"
 COLOR 13: LOCATE 28, 4: PRINT "|": LOCATE 28, 12: PRINT "|": LOCATE 28, 37: PRINT "|": LOCATE 28, 47: PRINT "|": LOCATE 28, 64: PRINT "|": LOCATE 28, 77: PRINT "|"
' LOCATE 25, 76: PRINT xf
' LOCATE 26, 76: PRINT yf
LOOP UNTIL k$ = CHR$(27)

CLS
LOCATE 12, 30: INPUT "Spiel beenden (J/N)? ", ende$
IF LCASE$(ende$) <> "j" THEN GOTO start
SYSTEM

'---Fehler Behandlung fÅr Load---
fehler:
SELECT CASE ERR
CASE 53
  LINE (200, 160)-(440, 220), 1, BF
  LOCATE 12, 30: PRINT "Die Datei "; file$;
  LOCATE 13, 30: PRINT " wurde nicht gefunden !"
  DO
  LOOP UNTIL ((INKEY$ = CHR$(27)) OR (INKEY$ = CHR$(13)))
END SELECT
RESUME NEXT

SUB bomb
COLOR 4
FOR i% = 1 TO p%
  IF (xb - (p% - i%) > 3) THEN IF ((wall(yb, xb - (p% - i%)) = 0) OR (wall(yb, xb - (p% - i%)) = 2)) THEN wall(yb, xb - (p% - i%)) = 0: LOCATE yb, xb - (p% - i%): PRINT "∞"
  IF (xb + (p% - i%) < 77) THEN IF ((wall(yb, xb + (p% - i%)) = 0) OR (wall(yb, xb + (p% - i%)) = 2)) THEN wall(yb, xb + (p% - i%)) = 0: LOCATE yb, xb + (p% - i%): PRINT "∞"
  IF (yb - (p% - i%) > 2) THEN IF ((wall(yb - (p% - i%), xb) = 0) OR (wall(yb - (p% - i%), xb) = 2)) THEN wall(yb - (p% - i%), xb) = 0: LOCATE yb - (p% - i%), xb: PRINT "∞"
  IF (yb + (p% - i%) < 27) THEN IF ((wall(yb + (p% - i%), xb) = 0) OR (wall(yb + (p% - i%), xb) = 2)) THEN wall(yb + (p% - i%), xb) = 0: LOCATE yb + (p% - i%), xb: PRINT "∞"
  '---Zerstîrt durch Bombe ?---
  IF (x = xb) AND (y = yb) THEN gameover
  IF (x = xb) AND (y = yb - (p% - i%)) THEN gameover
  IF (x = xb) AND (y = yb + (p% - i%)) THEN gameover
  IF (y = yb) AND (x = xb - (p% - i%)) THEN gameover
  IF (y = yb) AND (x = xb + (p% - i%)) THEN gameover
  '---Enemy zerstîrt durch Bombe ?---
  IF (xf = xb) AND (yf = yb) THEN enemykilled = 1
  IF (xf = xb) AND (yf = yb - (p% - i%)) THEN enemykilled = 1
  IF (xf = xb) AND (yf = yb + (p% - i%)) THEN enemykilled = 1
  IF (yf = yb) AND (xf = xb - (p% - i%)) THEN enemykilled = 1
  IF (yf = yb) AND (xf = xb + (p% - i%)) THEN enemykilled = 1

NEXT i%

IF b > 0 THEN b = b - 1 ELSE b = 0
count = 0
SOUND 150, 7
FOR i = 1 TO 9000: NEXT i

END SUB

SUB drawenemy

yfold = yf
xfold = xf

enemy

IF rf = 1 THEN yf = yf + 1
IF rf = -1 THEN yf = yf - 1
IF rf = 2 THEN xf = xf + 1
IF rf = -2 THEN xf = xf - 1

IF xf = 0 THEN xf = 4
IF xf <= 3 THEN xf = 4
IF xf >= 78 THEN xf = 77
IF yf <= 2 THEN yf = 3
IF yf >= 27 THEN yf = 26

IF (wall(yf, xf) = 1) OR (wall(yf, xf) = 2) THEN yf = yfold: xf = xfold

COLOR 13
LOCATE yf, xf: PRINT CHR$(1)

SELECT CASE yfold
CASE yfold <> yf
  IF rf = 1 THEN LOCATE yf - 1, xf: PRINT " "
  IF rf = -1 THEN LOCATE yf + 1, xf: PRINT " "
  IF rf = 2 THEN LOCATE yf, xf - 1: PRINT " "
  IF rf = -2 THEN LOCATE yf, xf + 1: PRINT " "
CASE y
  SELECT CASE xfold
  CASE xfold <> xf
    IF rf = 1 THEN LOCATE yf - 1, xf: PRINT " "
    IF rf = -1 THEN LOCATE yf + 1, xf: PRINT " "
    IF rf = 2 THEN LOCATE yf, xf - 1: PRINT " "
    IF rf = -2 THEN LOCATE yf, xf + 1: PRINT " "
  END SELECT
END SELECT


END SUB

SUB drawlab
COLOR 3
'---RÑnder---
'---Zeile 2---(Oberer Rand)
FOR i% = 3 TO 78
  LOCATE 2, i%: PRINT "≤"
NEXT i%
'---Zeile 3---
LOCATE 3, 3: PRINT "≤"
LOCATE 3, 78: PRINT "≤"
'---Zeile 4---
LOCATE 4, 3: PRINT "≤"
LOCATE 4, 78: PRINT "≤"
'---Zeile 5---
LOCATE 5, 3: PRINT "≤"
LOCATE 5, 78: PRINT "≤"
'---Zeile 6---
LOCATE 6, 3: PRINT "≤"
LOCATE 6, 78: PRINT "≤"
'---Zeile 7---
LOCATE 7, 3: PRINT "≤"
LOCATE 7, 78: PRINT "≤"
'---Zeile 8---
LOCATE 8, 3: PRINT "≤"
LOCATE 8, 78: PRINT "≤"
'---Zeile 9---
LOCATE 9, 3: PRINT "≤"
LOCATE 9, 78: PRINT "≤"
'---Zeile10---
LOCATE 10, 3: PRINT "≤"
LOCATE 10, 78: PRINT "≤"
'---Zeile11---
LOCATE 11, 3: PRINT "≤"
LOCATE 11, 78: PRINT "≤"
'---Zeile12---
LOCATE 12, 3: PRINT "≤"
LOCATE 12, 78: PRINT "≤"
'---Zeile13---
LOCATE 13, 3: PRINT "≤"
LOCATE 13, 78: PRINT "≤"
'---Zeile14---
LOCATE 14, 3: PRINT "≤"
LOCATE 14, 78: PRINT "≤"
'---Zeile15---
LOCATE 15, 3: PRINT "≤"
LOCATE 15, 78: PRINT "≤"
'---Zeile16---
LOCATE 16, 3: PRINT "≤"
LOCATE 16, 78: PRINT "≤"
'---Zeile17---
LOCATE 17, 3: PRINT "≤"
LOCATE 17, 78: PRINT "≤"
'---Zeile18--
LOCATE 18, 3: PRINT "≤"
LOCATE 18, 78: PRINT "≤"
'---Zeile19---
LOCATE 19, 3: PRINT "≤"
LOCATE 19, 78: PRINT "≤"
'---Zeile20---
LOCATE 20, 3: PRINT "≤"
LOCATE 20, 78: PRINT "≤"
'---Zeile21---
LOCATE 21, 3: PRINT "≤"
LOCATE 21, 78: PRINT "≤"
'---Zeile22---
LOCATE 22, 3: PRINT "≤"
LOCATE 22, 78: PRINT "≤"
'---Zeile23---
LOCATE 23, 3: PRINT "≤"
LOCATE 23, 78: PRINT "≤"
'---Zeile24--
LOCATE 24, 3: PRINT "≤"
LOCATE 24, 78: PRINT "≤"
'---Zeile25---
LOCATE 25, 3: PRINT "≤"
LOCATE 25, 78: PRINT "≤"
'---Zeile26---
LOCATE 26, 3: PRINT "≤"
LOCATE 26, 78: PRINT "≤"
'---Zeile27---(Unterer Rand)
FOR i% = 3 TO 78
  LOCATE 27, i%: PRINT "≤"
NEXT i%

'---DrawEngine---
FOR i% = 3 TO 26
  FOR j% = 4 TO 77
    SELECT CASE wall(i%, j%)
    CASE 0 '---normal durchgÑngig
      IF ((i% = y) AND (j% = x)) OR ((i% = yb) AND (j% = xb)) THEN  ELSE LOCATE i%, j%: PRINT " "
    CASE 1 '---feste Mauer
      COLOR 3: LOCATE i%, j%: PRINT "≤"
    CASE 2 '---sprengbare Mauer
      COLOR 3: LOCATE i%, j%: PRINT "±"
    CASE 3 '---Bombe
      COLOR 5: LOCATE i%, j%: PRINT "B"
    CASE 4 '---Bomb-Power-Improver
      COLOR 5: LOCATE i%, j%: PRINT CHR$(15)
    CASE 5 '---
    CASE 6 '---
    CASE 7 '---
    CASE 8 '---Start Position
      COLOR 4: LOCATE i%, j%: PRINT CHR$(1)
    CASE 9 '---
    END SELECT
  NEXT j%
NEXT i%
END SUB

SUB drawworm

COLOR 3
xold = x'Speichern der Position
yold = y'fÅr Kollissionsabfrage

IF r = 1 THEN y = y + 1
IF r = -1 THEN y = y - 1
IF r = 2 THEN x = x + 1
IF r = -2 THEN x = x - 1

IF x <= 3 THEN x = 4
IF x >= 78 THEN x = 77
IF y <= 2 THEN y = 3
IF y >= 27 THEN y = 26

IF (wall(y, x) = 1) OR (wall(y, x) = 2) THEN y = yold: x = xold

COLOR 12

LOCATE y, x: PRINT CHR$(2)

SELECT CASE yold
CASE IS <> y
  IF r = 1 THEN LOCATE y - 1, x: PRINT " "
  IF r = -1 THEN LOCATE y + 1, x: PRINT " "
  IF r = 2 THEN LOCATE y, x - 1: PRINT " "
  IF r = -2 THEN LOCATE y, x + 1: PRINT " "
CASE y
  SELECT CASE xold
  CASE IS <> x
    IF r = 1 THEN LOCATE y - 1, x: PRINT " "
    IF r = -1 THEN LOCATE y + 1, x: PRINT " "
    IF r = 2 THEN LOCATE y, x - 1: PRINT " "
    IF r = -2 THEN LOCATE y, x + 1: PRINT " "
  END SELECT
END SELECT

END SUB

SUB enemy

SELECT CASE x AND y
CASE (y > yf) AND (x > xf)
  IF (x - xf) > (y - yf) THEN rf = 2 ELSE rf = 1
CASE (y < yf) AND (x < xf)
  IF (xf - x) > (yf - y) THEN rf = -2 ELSE rf = -1
CASE (y < yf) AND (x > xf)
  IF (x - xf) > (yf - y) THEN rf = 2 ELSE rf = -1
CASE (y > yf) AND (x < xf)
  IF (xf - x) > (y - yf) THEN rf = 2 ELSE rf = 1
CASE (y = yf) AND (x = xf)
  PRINT "DEAD...!": BEEP: SLEEP 3:
CASE (y = yf)
  IF (x > xf) THEN rf = 2 ELSE rf = -2
CASE (x = xf)
  IF (yf > y) THEN rf = -1 ELSE rf = 1
END SELECT

END SUB

SUB gameover
CLS : SOUND 200, 4
SLEEP 1
FOR i% = 800 TO 100 STEP -100
  SOUND i%, 2
NEXT i%
LOCATE 13, 35: PRINT "Game Over"
DO
k$ = INKEY$
LOOP UNTIL k$ = CHR$(27)
SYSTEM
END SUB

SUB goodies
IF (wall(y, x) = 3) THEN wall(y, x) = 0: b = b + 1: SOUND 500, 3
IF (wall(y, x) = 4) THEN wall(y, x) = 0: p% = p% + 1: SOUND 300, 3
END SUB

SUB help

'--- frame ---
CLS : COLOR 1

FOR j% = 1 TO 80
  LOCATE 1, j%: PRINT "Õ";
  LOCATE 28, j%: PRINT "Õ"
NEXT j%

FOR j% = 2 TO 27
  LOCATE j%, 1: PRINT "∫"
  LOCATE j%, 80: PRINT "∫"
NEXT j%

'FOR j% = 5 TO 22
'  LOCATE j%, 35: PRINT "∫" 'senkrechter Mittelstrich
'NEXT j%

LOCATE 1, 1: PRINT "…"
LOCATE 1, 80: PRINT "ª"
LOCATE 28, 1: PRINT "»"
LOCATE 28, 80: PRINT "º"
'--- frame ---

COLOR 5
'---öberschrift---
LOCATE 2, 35: PRINT "Hilfe"
LOCATE 3, 34: PRINT "======="

LOCATE 8, 25: PRINT CHR$(4); " Laden: lÑdt einen vorhandenen Level"
LOCATE 10, 25: PRINT CHR$(4); " Hilfe: Dieser Bildschirm"
LOCATE 12, 25: PRINT CHR$(4); " Beenden: Beendet das Programm"
LOCATE 15, 25: PRINT CHR$(4); " B: Anzahl der verfÅgbaren Bomben"
LOCATE 24, 20: PRINT "Mit den Cursortasten bewegt man den Bomber-Man"

DO
LOOP UNTIL INKEY$ = CHR$(27)
CLS


END SUB

SUB load
ON ERROR GOTO fehler
DO
  CLS : COLOR 5
  FILES (path$ + "\*.lab")
  LOCATE 26, 25: PRINT "Abbruch: @"
  LOCATE 25, 25: INPUT "Dateiname (max 8 Zeichen): ", file$
LOOP UNTIL (LEN(file$) < 9) AND (LEN(file$) > 0)
IF file$ = "@" THEN CLS : EXIT SUB

CHDIR path$: SHELL (LEFT$(path$, 2))

file$ = file$ + ".lab"
RESET
10 OPEN file$ FOR INPUT AS #1
20
FOR j% = 1 TO 27
  FOR i% = 1 TO 80
    INPUT #1, wall(j%, i%) 'EintrÑge aus Datei einlesen.
    IF wall(j%, i%) = 8 THEN y = j%: x = i% 'Startposition festlegen
  NEXT i%
NEXT j%
INPUT #1, b
INPUT #1, p%
CLOSE #1
CLS
END SUB

SUB pause
DO
k$ = INKEY$
LOOP UNTIL k$ = "p"
END SUB

SUB symbols
END SUB

SUB tast
'--- Tastaturabfrage
k$ = INKEY$
starter = 0
IF k$ = CHR$(0) + CHR$(80) THEN r = 1 '(Cursor down)
IF k$ = CHR$(0) + CHR$(72) THEN r = -1 '(Cursor up)
IF k$ = CHR$(0) + CHR$(77) THEN r = 2 '(Cursor right)
IF k$ = CHR$(0) + CHR$(75) THEN r = -2 '(Cursor left)
IF k$ = CHR$(0) + CHR$(59) THEN help '(F1)
IF k$ = "s" THEN drawworm: SLEEP 2 'Debughilfe
IF k$ = CHR$(98) THEN b = 20 '(b) Bombencheat
IF k$ = CHR$(66) THEN p% = p% + 2 '(B) Bombencheat

'--- game speed ---
IF k$ = "1" THEN speed = 10
IF k$ = "2" THEN speed = 200
IF k$ = "3" THEN speed = 800
IF k$ = "4" THEN speed = 1250
IF k$ = "5" THEN speed = 2500
IF k$ = "6" THEN speed = 5000
IF k$ = "7" THEN speed = 7750
IF k$ = "8" THEN speed = 9500
IF k$ = "9" THEN speed = 13000
IF k$ = "0" THEN speed = 18000
IF k$ = "p" THEN pause
'--- end game speed ---

IF count = 0 THEN IF k$ = CHR$(13) THEN count = 1: countdown = TIMER'Return-Taste

IF LCASE$(k$) = "l" THEN load: starter = 1

END SUB

SUB wallset
'---alle Felder auf 0 (durchgÑngig) setzten
FOR i% = 1 TO 27
  FOR j% = 1 TO 80
    wall(i%, j%) = 0
  NEXT j%
NEXT i%
'---Felder auf 1 (nicht durchgÑngig) setzen

'--Zeile 3---
'Spalte 4
wall(3, 5) = 1'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
'Spalte 9
wall(3, 10) = 1'Spalte10
'Spalte11
'Spalte12
'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
'Spalte18
wall(3, 19) = 1'Spalte19
'Spalte20
wall(3, 21) = 1'Spalte21
'Spalte22
'Spalte23
'Spalte24
'Spalte25
'Spalte26
'Spalte27
'Spalte28
'Spalte29
'Spalte30
wall(3, 31) = 1'Spalte31
wall(3, 32) = 1'Spalte32
wall(3, 33) = 1'Spalte33
wall(3, 34) = 1'Spalte34
wall(3, 35) = 1'Spalte35
wall(3, 36) = 1'Spalte36
wall(3, 37) = 1'Spalte37
'Spalte38
'Spalte39
'Spalte40
wall(3, 41) = 1'Spalte41
'Spalte42
'Spalte43
'Spalte44
'Spalte45
'Spalte46
'Spalte47
'Spalte48
'Spalte49
'Spalte50
wall(3, 51) = 1'Spalte51
'Spalte52
'Spalte53
'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(3, 60) = 1'Spalte60
'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
wall(3, 67) = 1'Spalte67
'Spalte68
'Spalte69
'Spalte70
'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
'Spalte76
'Spalte77

'--Zeile 4---
'Spalte 4
wall(4, 5) = 1'Spalte 5
'Spalte 6
wall(4, 7) = 1'Spalte 7
wall(4, 8) = 1'Spalte 8
wall(4, 9) = 1'Spalte 9
wall(4, 10) = 1'Spalte10
wall(4, 11) = 1'Spalte11
wall(4, 12) = 1'Spalte12
'Spalte13
wall(4, 14) = 1'Spalte14
wall(4, 15) = 1'Spalte15
wall(4, 16) = 1'Spalte16
wall(4, 17) = 1'Spalte17
'Spalte18
'Spalte19
'Spalte20
wall(4, 21) = 1'Spalte17'Spalte21
wall(4, 22) = 1'Spalte22
wall(4, 23) = 1'Spalte23
wall(4, 24) = 1'Spalte24
wall(4, 25) = 1'Spalte25
wall(4, 26) = 1'Spalte26
wall(4, 27) = 1'Spalte27
wall(4, 28) = 1'Spalte28
wall(4, 29) = 1'Spalte29
'Spalte30
'Spalte31
'Spalte32
'Spalte33
'Spalte34
'Spalte35
'Spalte36
'Spalte37
'Spalte38
wall(4, 39) = 1'Spalte39
'Spalte40
wall(4, 41) = 1'Spalte41
'Spalte42
wall(4, 43) = 1'Spalte43
'Spalte44
wall(4, 45) = 1'Spalte45
'Spalte46
wall(4, 47) = 1'Spalte47
'Spalte48
wall(4, 49) = 1'Spalte49
'Spalte50
wall(4, 51) = 1'Spalte51
'Spalte52
wall(4, 53) = 1'Spalte53
wall(4, 54) = 1'Spalte54
wall(4, 55) = 1'Spalte55
wall(4, 56) = 1'Spalte56
wall(4, 57) = 1'Spalte57
'Spalte58
wall(4, 59) = 1'Spalte59
wall(4, 60) = 1'Spalte60
'Spalte61
wall(4, 62) = 1'Spalte62
wall(4, 63) = 1'Spalte63
wall(4, 64) = 1'Spalte64
wall(4, 65) = 1'Spalte65
'Spalte66
wall(4, 67) = 1'Spalte67
'Spalte68
wall(4, 69) = 1'Spalte69
wall(4, 70) = 1'Spalte70
'Spalte71
wall(4, 72) = 1'Spalte72
wall(4, 73) = 1'Spalte73
'Spalte74
wall(4, 75) = 1'Spalte75
wall(4, 76) = 1'Spalte76
'Spalte77

'--Zeile 5---
'Spalte 4
wall(5, 5) = 1'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
'Spalte 9
'Spalte10
'Spalte11
'Spalte12
'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
'Spalte18
'Spalte19
'Spalte20
wall(5, 21) = 1'Spalte21
'Spalte22
'Spalte23
'Spalte24
'Spalte25
'Spalte26
'Spalte27
'Spalte28
wall(5, 29) = 1'Spalte29
wall(5, 30) = 1'Spalte30
wall(5, 31) = 1'Spalte31
wall(5, 32) = 1'Spalte32
wall(5, 33) = 1'Spalte33
wall(5, 34) = 1'Spalte34
wall(5, 35) = 1'Spalte35
wall(5, 36) = 1'Spalte36
wall(5, 37) = 1'Spalte37
wall(5, 38) = 1'Spalte38
wall(5, 39) = 1'Spalte39
'Spalte40
wall(5, 41) = 1'Spalte41
'Spalte42
wall(5, 43) = 1'Spalte43
'Spalte44
wall(5, 45) = 1'Spalte45
'Spalte46
wall(5, 47) = 1'Spalte47
'Spalte48
wall(5, 49) = 1'Spalte49
'Spalte50
wall(5, 51) = 1'Spalte51
'Spalte52
wall(5, 53) = 1'Spalte53
wall(5, 54) = 1'Spalte54
wall(5, 55) = 1'Spalte55
wall(5, 56) = 1'Spalte56
'Spalte57
'Spalte58
wall(5, 59) = 1'Spalte59
wall(5, 60) = 1'Spalte60
'Spalte61
'Spalte62
'Spalte63
'Spalte64
wall(5, 65) = 1'Spalte65
'Spalte66
wall(5, 67) = 1'Spalte67
'Spalte68
wall(5, 69) = 1'Spalte69
wall(5, 70) = 1'Spalte70
'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
'Spalte76
'Spalte77

'--Zeile 6---
'Spalte 4
wall(6, 5) = 1'Spalte 5
wall(6, 6) = 1'Spalte 6
wall(6, 7) = 1'Spalte 7
wall(6, 8) = 1'Spalte 8
wall(6, 9) = 1'Spalte 9
wall(6, 10) = 1'Spalte10
wall(6, 11) = 1'Spalte11
wall(6, 12) = 1'Spalte12
wall(6, 13) = 1'Spalte13
wall(6, 14) = 1'Spalte14
wall(6, 15) = 1'Spalte15
'Spalte16
wall(6, 17) = 1'Spalte17
wall(6, 18) = 1'Spalte18
wall(6, 19) = 1'Spalte19
'Spalte20
'Spalte21
'Spalte22
wall(6, 23) = 1'Spalte23
wall(6, 24) = 1'Spalte24
wall(6, 25) = 1'Spalte25
wall(6, 26) = 1'Spalte26
wall(6, 27) = 1'Spalte27
'Spalte28
wall(6, 29) = 1'Spalte29
wall(6, 30) = 1'Spalte30
wall(6, 31) = 1'Spalte31
'Spalte32
'Spalte33
'Spalte34
'Spalte35
'Spalte36
'Spalte37
'Spalte38
'Spalte39
'Spalte40
wall(6, 41) = 1'Spalte41
'Spalte42
wall(6, 43) = 1'Spalte43
'Spalte44
wall(6, 45) = 1'Spalte45
'Spalte46
wall(6, 47) = 1'Spalte47
'Spalte48
wall(6, 49) = 1'Spalte49
'Spalte50
'Spalte51
'Spalte52
wall(6, 53) = 1'Spalte53
wall(6, 54) = 1'Spalte54
wall(6, 55) = 1'Spalte55
wall(6, 56) = 1'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(6, 60) = 1'Spalte60
wall(6, 61) = 1'Spalte61
wall(6, 62) = 1'Spalte62
wall(6, 63) = 1'Spalte63
'Spalte64
wall(6, 65) = 1'Spalte65
'Spalte66
wall(6, 67) = 1'Spalte67
'Spalte68
wall(6, 69) = 1'Spalte69
wall(6, 70) = 1'Spalte70
wall(6, 71) = 1'Spalte71
wall(6, 72) = 1'Spalte72
wall(6, 73) = 1'Spalte73
'Spalte74
wall(6, 75) = 1'Spalte75
wall(6, 76) = 1'Spalte76
wall(6, 77) = 1'Spalte77

'--Zeile 7---
'Spalte 4
'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
'Spalte 9
'Spalte10
'Spalte11
'Spalte12
'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
'Spalte18
'Spalte19
'Spalte20
wall(7, 21) = 1'Spalte21
'Spalte22
wall(7, 23) = 1'Spalte23
'Spalte24
'Spalte25
'Spalte26
'Spalte27
'Spalte28
wall(7, 29) = 1'Spalte29
wall(7, 30) = 1'Spalte30
wall(7, 31) = 1'Spalte31
'Spalte32
wall(7, 33) = 1'Spalte33
'Spalte34
wall(7, 35) = 1'Spalte35
wall(7, 36) = 1'Spalte36
wall(7, 37) = 1'Spalte37
wall(7, 38) = 1'Spalte38
wall(7, 39) = 1'Spalte39
wall(7, 40) = 1'Spalte40
wall(7, 41) = 1'Spalte41
'Spalte42
wall(7, 43) = 1'Spalte43
'Spalte44
wall(7, 45) = 1'Spalte45
'Spalte46
wall(7, 47) = 1'Spalte47
'Spalte48
wall(7, 49) = 1'Spalte49
wall(7, 50) = 1'Spalte50
wall(7, 51) = 1'Spalte51
wall(7, 52) = 1'Spalte52
wall(7, 53) = 1'Spalte53
wall(7, 54) = 1'Spalte54
wall(7, 55) = 1'Spalte55
wall(7, 56) = 1'Spalte56
'Spalte57
wall(7, 58) = 1'Spalte58
'Spalte59
'Spalte60
'Spalte61
'Spalte62
'Spalte63
'Spalte64
wall(7, 65) = 1'Spalte65
'Spalte66
wall(7, 67) = 1'Spalte67
'Spalte68
wall(7, 69) = 1'Spalte69
wall(7, 70) = 1'Spalte70
'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
'Spalte76
'Spalte77

'--Zeile 8---
'Spalte 4
wall(8, 5) = 1'Spalte 5
'Spalte 6
wall(8, 7) = 1'Spalte 7
wall(8, 8) = 1'Spalte 8
wall(8, 9) = 1'Spalte 9
'Spalte10
wall(8, 11) = 1'Spalte11
wall(8, 12) = 1'Spalte12
wall(8, 13) = 1'Spalte13
'Spalte14
wall(8, 15) = 1'Spalte15
wall(8, 16) = 1'Spalte16
wall(8, 17) = 1'Spalte17
wall(8, 18) = 1'Spalte18
'Spalte19
wall(8, 20) = 1'Spalte20
wall(8, 21) = 1'Spalte21
'Spalte22
wall(8, 23) = 1'Spalte23
'Spalte24
wall(8, 25) = 1'Spalte25
wall(8, 26) = 1'Spalte26
wall(8, 27) = 1'Spalte27
'Spalte28
wall(8, 29) = 1'Spalte29
wall(8, 30) = 1'Spalte30
wall(8, 31) = 1'Spalte31
wall(8, 32) = 1'Spalte32
wall(8, 33) = 1'Spalte33
'Spalte34
wall(8, 35) = 1'Spalte35
'Spalte36
'Spalte37
'Spalte38
'Spalte39
wall(8, 40) = 1'Spalte40
'Spalte41
'Spalte42
wall(8, 43) = 1'Spalte43
'Spalte44
wall(8, 45) = 1'Spalte45
'Spalte46
wall(8, 47) = 1'Spalte47
'Spalte48
'Spalte49
'Spalte50
'Spalte51
'Spalte52
'Spalte53
'Spalte54
'Spalte55
'Spalte56
'Spalte57
wall(8, 58) = 1'Spalte58
wall(8, 59) = 1'Spalte59
wall(8, 60) = 1'Spalte60
wall(8, 61) = 1'Spalte61
wall(8, 62) = 1'Spalte62
wall(8, 63) = 1'Spalte63
'Spalte64
'Spalte65
'Spalte66
wall(8, 67) = 1'Spalte67
'Spalte68
wall(8, 69) = 1'Spalte69
wall(8, 70) = 1'Spalte70
'Spalte71
wall(8, 72) = 1'Spalte72
'Spalte73
wall(8, 74) = 1'Spalte74
'Spalte75
wall(8, 76) = 1'Spalte76
wall(8, 77) = 1'Spalte77

'--Zeile 9---
'Spalte 4
wall(9, 5) = 1'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
'Spalte 9
'Spalte10
'Spalte11
'Spalte12
'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
'Spalte18
'Spalte19
'Spalte20
'Spalte21
'Spalte22
'Spalte23
'Spalte24
'Spalte25
'Spalte26
'Spalte27
'Spalte28
wall(9, 29) = 1'Spalte29
'Spalte30
'Spalte31
'Spalte32
'Spalte33
'Spalte34
'Spalte35
'Spalte36
'Spalte37
'Spalte38
'Spalte39
wall(9, 40) = 1'Spalte40
'Spalte41
wall(9, 42) = 1'Spalte42
wall(9, 43) = 1'Spalte43
'Spalte44
wall(9, 45) = 1'Spalte45
'Spalte46
wall(9, 47) = 1'Spalte47
'Spalte48
'Spalte49
wall(9, 50) = 1'Spalte50
'Spalte51
wall(9, 52) = 1'Spalte52
wall(9, 53) = 1'Spalte53
wall(9, 54) = 1'Spalte54
wall(9, 55) = 1'Spalte55
wall(9, 56) = 1'Spalte56
wall(9, 57) = 1'Spalte57
wall(9, 58) = 1'Spalte58
wall(9, 59) = 1'Spalte59
wall(9, 60) = 1'Spalte60
wall(9, 61) = 1'Spalte61
wall(9, 62) = 1'Spalte62
wall(9, 63) = 1'Spalte63
wall(9, 64) = 1'Spalte64
wall(9, 65) = 1'Spalte65
'Spalte66
wall(9, 67) = 1'Spalte67
'Spalte68
wall(9, 69) = 1'Spalte69
wall(9, 70) = 1'Spalte70
wall(9, 71) = 1'Spalte71
wall(9, 72) = 1'Spalte72
'Spalte73
wall(9, 74) = 1'Spalte74
'Spalte75
wall(9, 76) = 1'Spalte76
wall(9, 77) = 1'Spalte77

'--Zeile10---
'Spalte 4
wall(10, 5) = 1'Spalte 5
'Spalte 6
wall(10, 7) = 1'Spalte 7
wall(10, 8) = 1'Spalte 8
wall(10, 9) = 1'Spalte 9
'Spalte10
wall(10, 11) = 1'Spalte11
'Spalte12
wall(10, 13) = 1'Spalte13
wall(10, 14) = 1'Spalte14
wall(10, 15) = 1'Spalte15
wall(10, 16) = 1'Spalte16
wall(10, 17) = 1'Spalte17
wall(10, 18) = 1'Spalte18
wall(10, 19) = 1'Spalte19
wall(10, 20) = 1'Spalte20
'Spalte21
wall(10, 22) = 1'Spalte22
wall(10, 23) = 1'Spalte23
wall(10, 24) = 1'Spalte24
wall(10, 25) = 1'Spalte25
wall(10, 26) = 1'Spalte26
wall(10, 27) = 1'Spalte27
wall(10, 28) = 1'Spalte28
wall(10, 29) = 1'Spalte29
'Spalte30
wall(10, 31) = 1'Spalte31
wall(10, 32) = 1'Spalte32
wall(10, 33) = 1'Spalte33
wall(10, 34) = 1'Spalte34
wall(10, 35) = 1'Spalte35
wall(10, 36) = 1'Spalte36
wall(10, 37) = 1'Spalte37
wall(10, 38) = 1'Spalte38
'Spalte39
wall(10, 40) = 1'Spalte40
'Spalte41
wall(10, 42) = 1'Spalte42
'Spalte43
'Spalte44
wall(10, 45) = 1'Spalte45
'Spalte46
wall(10, 47) = 1'Spalte47
'Spalte48
'Spalte49
wall(10, 50) = 1'Spalte50
'Spalte51
wall(10, 52) = 1'Spalte52
'Spalte53
'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
'Spalte60
'Spalte61
'Spalte62
'Spalte63
'Spalte64
wall(10, 65) = 1'Spalte65
'Spalte66
wall(10, 67) = 1'Spalte67
'Spalte68
'Spalte69
wall(10, 70) = 1'Spalte70
wall(10, 71) = 1'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
'Spalte76
wall(10, 77) = 1'Spalte77

'--Zeile11---
'Spalte 4
wall(11, 5) = 1'Spalte 5
'Spalte 6
wall(11, 7) = 1'Spalte 7
'Spalte 8
'Spalte 9
'Spalte10
wall(11, 11) = 1'Spalte11
'Spalte12
'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
'Spalte18
'Spalte19
'Spalte20
'Spalte21
wall(11, 22) = 1'Spalte22
'Spalte23
'Spalte24
'Spalte25
'Spalte26
'Spalte27
'Spalte28
'Spalte29
'Spalte30
wall(11, 31) = 1'Spalte31
'Spalte32
'Spalte33
'Spalte34
'Spalte35
'Spalte36
'Spalte37
wall(11, 38) = 1'Spalte38
'Spalte39
wall(11, 40) = 1'Spalte40
'Spalte41
wall(11, 42) = 1'Spalte42
'Spalte43
wall(11, 44) = 1'Spalte44
wall(11, 45) = 1'Spalte45
'Spalte46
wall(11, 47) = 1'Spalte47
'Spalte48
'Spalte49
wall(11, 50) = 1'Spalte50
'Spalte51
wall(11, 52) = 1'Spalte52
'Spalte53
wall(11, 54) = 1'Spalte54
wall(11, 55) = 1'Spalte55
wall(11, 56) = 1'Spalte56
wall(11, 57) = 1'Spalte57
wall(11, 58) = 1'Spalte58
wall(11, 59) = 1'Spalte59
wall(11, 60) = 1'Spalte60
wall(11, 61) = 1'Spalte61
wall(11, 62) = 1'Spalte62
wall(11, 63) = 1'Spalte63
wall(11, 64) = 1'Spalte64
wall(11, 65) = 1'Spalte65
'Spalte66
wall(11, 67) = 1'Spalte67
wall(11, 68) = 1'Spalte68
'Spalte69
wall(11, 70) = 1'Spalte70
wall(11, 71) = 1'Spalte71
'Spalte72
wall(11, 73) = 1'Spalte73
'Spalte74
wall(11, 75) = 1'Spalte75
'Spalte76
wall(11, 77) = 1'Spalte77

'--Zeile12---
'Spalte 4
'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
wall(12, 9) = 1'Spalte 9
wall(12, 10) = 1'Spalte10
wall(12, 11) = 1'Spalte11
'Spalte12
wall(12, 13) = 1'Spalte13
'Spalte14
wall(12, 15) = 1'Spalte15
wall(12, 16) = 1'Spalte16
wall(12, 17) = 1'Spalte17
wall(12, 18) = 1'Spalte18
'Spalte19
wall(12, 20) = 1'Spalte20
'Spalte21
wall(12, 22) = 1'Spalte22
'Spalte23
wall(12, 24) = 1'Spalte24
wall(12, 25) = 1'Spalte25
wall(12, 26) = 1'Spalte26
wall(12, 27) = 1'Spalte27
wall(12, 28) = 1'Spalte28
wall(12, 29) = 1'Spalte29
wall(12, 30) = 1'Spalte30
wall(12, 31) = 1'Spalte31
wall(12, 32) = 1'Spalte32
'Spalte33
wall(12, 34) = 1'Spalte34
wall(12, 35) = 1'Spalte35
wall(12, 36) = 1'Spalte36
'Spalte37
wall(12, 38) = 1'Spalte38
'Spalte39
wall(12, 40) = 1'Spalte40
'Spalte41
wall(12, 42) = 1'Spalte42
'Spalte43
wall(12, 44) = 1'Spalte44
'Spalte45
'Spalte46
wall(12, 47) = 1'Spalte47
'Spalte48
'Spalte49
wall(12, 50) = 1'Spalte50
'Spalte51
wall(12, 52) = 1'Spalte52
'Spalte53
wall(12, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
'Spalte60
'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
'Spalte67
wall(12, 68) = 1'Spalte68
'Spalte69
wall(12, 70) = 1'Spalte70
'Spalte71
'Spalte72
wall(12, 73) = 1'Spalte73
'Spalte74
wall(12, 75) = 1'Spalte75
'Spalte76
'Spalte77

'--Zeile13---
'Spalte 4
wall(13, 5) = 1'Spalte 5
'Spalte 6
wall(13, 7) = 1'Spalte 7
'Spalte 8
'Spalte 9
'Spalte10
'Spalte11
'Spalte12
wall(13, 13) = 1'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
wall(13, 18) = 1'Spalte18
'Spalte19
wall(13, 20) = 1'Spalte20
'Spalte21
wall(13, 22) = 1'Spalte22
'Spalte23
wall(13, 24) = 1'Spalte24
'Spalte25
'Spalte26
'Spalte27
'Spalte28
'Spalte29
'Spalte30
'Spalte31
wall(13, 32) = 1'Spalte32
'Spalte33
wall(13, 34) = 1'Spalte34
'Spalte35
wall(13, 36) = 1'Spalte36
'Spalte37
wall(13, 38) = 1'Spalte38
'Spalte39
wall(13, 40) = 1'Spalte40
'Spalte41
wall(13, 42) = 1'Spalte42
'Spalte43
wall(13, 44) = 1'Spalte44
'Spalte45
wall(13, 46) = 1'Spalte46
wall(13, 47) = 1'Spalte47
'Spalte48
'Spalte49
wall(13, 50) = 1'Spalte50
'Spalte51
wall(13, 52) = 1'Spalte52
'Spalte53
wall(13, 54) = 1'Spalte54
'Spalte55
'Spalte56
wall(13, 57) = 1'Spalte57
wall(13, 58) = 1'Spalte58
wall(13, 59) = 1'Spalte59
wall(13, 60) = 1'Spalte60
wall(13, 61) = 1'Spalte61
wall(13, 62) = 1'Spalte62
wall(13, 63) = 1'Spalte63
wall(13, 64) = 1'Spalte64
'Spalte65
'Spalte66
'Spalte67
wall(13, 68) = 1'Spalte68
'Spalte69
wall(13, 70) = 1'Spalte70
'Spalte71
wall(13, 72) = 1'Spalte72
wall(13, 73) = 1'Spalte73
'Spalte74
wall(13, 75) = 1'Spalte75
wall(13, 76) = 1'Spalte76
'Spalte77

'--Zeile14---
'Spalte 4
wall(14, 5) = 1'Spalte 5
'Spalte 6
wall(14, 7) = 1'Spalte 7
'Spalte 8
wall(14, 9) = 1'Spalte 9
'Spalte10
wall(14, 11) = 1'Spalte11
'Spalte12
wall(14, 13) = 1'Spalte13
'Spalte14
wall(14, 15) = 1'Spalte15
wall(14, 16) = 1'Spalte16
'Spalte17
wall(14, 18) = 1'Spalte18
'Spalte19
wall(14, 20) = 1'Spalte20
'Spalte21
wall(14, 22) = 1'Spalte22
'Spalte23
wall(14, 24) = 1'Spalte24
'Spalte25
wall(14, 26) = 1'Spalte26
wall(14, 27) = 1'Spalte27
wall(14, 28) = 1'Spalte28
wall(14, 29) = 1'Spalte29
wall(14, 30) = 1'Spalte30
'Spalte31
wall(14, 32) = 1'Spalte32
'Spalte33
wall(14, 34) = 1'Spalte34
'Spalte35
wall(14, 36) = 1'Spalte36
'Spalte37
wall(14, 38) = 1'Spalte38
'Spalte39
'Spalte40
'Spalte41
'Spalte42
'Spalte43
'Spalte44
'Spalte45
'Spalte46
'Spalte47
'Spalte48
'Spalte49
'Spalte50
'Spalte51
wall(14, 52) = 1'Spalte52
'Spalte53
wall(14, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(14, 60) = 1'Spalte60
wall(14, 61) = 1'Spalte61
'Spalte62
'wall(14, 63) = 1'Spalte63
wall(14, 64) = 1'Spalte64
wall(14, 65) = 1'Spalte65
'Spalte66
'Spalte67
wall(14, 68) = 1'Spalte68
'Spalte69
wall(14, 70) = 1'Spalte70
'Spalte71
wall(14, 72) = 1'Spalte72
wall(14, 73) = 1'Spalte73
'Spalte74
wall(14, 75) = 1'Spalte75
wall(14, 76) = 1'Spalte76
'Spalte77

'--Zeile15---
'Spalte 4
wall(15, 5) = 1'Spalte 5
'Spalte 6
wall(15, 7) = 1'Spalte 7
'Spalte 8
wall(15, 9) = 1'Spalte 9
'Spalte10
wall(15, 11) = 1'Spalte11
'Spalte12
wall(15, 13) = 1'Spalte13
'Spalte14
wall(15, 15) = 1'Spalte15
wall(15, 16) = 1'Spalte16
'Spalte17
wall(15, 18) = 1'Spalte18
'Spalte19
wall(15, 20) = 1'Spalte20
'Spalte21
wall(15, 22) = 1'Spalte22
'Spalte23
wall(15, 24) = 1'Spalte24
'Spalte25
wall(15, 26) = 1'Spalte26
'Spalte27
'Spalte28
'Spalte29
'Spalte30
'Spalte31
wall(15, 32) = 1'Spalte32
'Spalte33
wall(15, 34) = 1'Spalte34
'Spalte35
wall(15, 36) = 1'Spalte36
'Spalte37
wall(15, 38) = 1'Spalte38
wall(15, 39) = 1'Spalte39
wall(15, 40) = 1'Spalte40
wall(15, 41) = 1'Spalte41
wall(15, 42) = 1'Spalte42
wall(15, 43) = 1'Spalte43
wall(15, 44) = 1'Spalte44
wall(15, 45) = 1'Spalte45
wall(15, 46) = 1'Spalte46
wall(15, 47) = 1'Spalte47
wall(15, 48) = 1'Spalte48
wall(15, 49) = 1'Spalte49
wall(15, 50) = 1'Spalte50
wall(15, 51) = 1'Spalte51
wall(15, 52) = 1'Spalte52
'Spalte53
wall(15, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(15, 60) = 1'Spalte60
wall(15, 61) = 1'Spalte61
'Spalte62
'Spalte63
'wall(15, 64) = 1'Spalte64
wall(15, 65) = 1'Spalte65
wall(15, 66) = 1'Spalte66
'Spalte67
wall(15, 68) = 1'Spalte68
'Spalte69
wall(15, 70) = 1'Spalte70
'Spalte71
wall(15, 72) = 1'Spalte72
'Spalte73
'Spalte74
'Spalte75
wall(15, 76) = 1'Spalte76
'Spalte77

'--Zeile16---
'Spalte 4
wall(16, 5) = 1'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
wall(16, 9) = 1'Spalte 9
'Spalte10
wall(16, 11) = 1'Spalte11
'Spalte12
wall(16, 13) = 1'Spalte13
'Spalte14
wall(16, 15) = 1'Spalte15
wall(16, 16) = 1'Spalte16
'Spalte17
wall(16, 18) = 1'Spalte18
'Spalte19
wall(16, 20) = 1'Spalte20
'Spalte21
wall(16, 22) = 1'Spalte22
'Spalte23
wall(16, 24) = 1'Spalte24
'Spalte25
wall(16, 26) = 1'Spalte26
'Spalte27
wall(16, 28) = 1'Spalte28
wall(16, 29) = 1'Spalte29
wall(16, 30) = 1'Spalte30
wall(16, 31) = 1'Spalte31
wall(16, 32) = 1'Spalte32
'Spalte33
wall(16, 34) = 1'Spalte34
'Spalte35
wall(16, 36) = 1'Spalte36
'Spalte37
'Spalte38
'Spalte39
wall(16, 40) = 1'Spalte40
'Spalte41
'Spalte42
'Spalte43
'Spalte44
'Spalte45
'Spalte46
'Spalte47
'Spalte48
'Spalte49
'Spalte50
'Spalte51
'Spalte52
'Spalte53
wall(16, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(16, 60) = 1'Spalte60
wall(16, 61) = 1'Spalte61
'Spalte62
'wall(16, 63) = 1'Spalte63
wall(16, 64) = 1'Spalte64
wall(16, 65) = 1'Spalte65
'Spalte66
'Spalte67
wall(16, 68) = 1'Spalte68
'Spalte69
wall(16, 70) = 1'Spalte70
'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
'Spalte76
'Spalte77

'--Zeile17---
'Spalte 4
wall(17, 5) = 1'Spalte 5
'Spalte 6
wall(17, 7) = 1'Spalte 7
'Spalte 8
wall(17, 9) = 1'Spalte 9
'Spalte10
wall(17, 11) = 1'Spalte11
'Spalte12
wall(17, 13) = 1'Spalte13
'Spalte14
wall(17, 15) = 1'Spalte15
wall(17, 16) = 1'Spalte16
'Spalte17
wall(17, 18) = 1'Spalte18
'Spalte19
wall(17, 20) = 1'Spalte20
'Spalte21
wall(17, 22) = 1'Spalte22
wall(17, 23) = 1'Spalte23
wall(17, 24) = 1'Spalte24
'Spalte25
wall(17, 26) = 1'Spalte26
'Spalte27
wall(17, 28) = 1'Spalte28
'Spalte29
'Spalte30
'Spalte31
'Spalte32
'Spalte33
wall(17, 34) = 1'Spalte34
'Spalte35
wall(17, 36) = 1'Spalte36
wall(17, 37) = 1'Spalte37
wall(17, 38) = 1'Spalte38
'Spalte39
wall(17, 40) = 1'Spalte40
'Spalte41
wall(17, 42) = 1'Spalte42
wall(17, 43) = 1'Spalte43
wall(17, 44) = 1'Spalte44
wall(17, 45) = 1'Spalte45
wall(17, 46) = 1'Spalte46
'Spalte47
wall(17, 48) = 1'Spalte48
wall(17, 49) = 1'Spalte49
'Spalte50
wall(17, 51) = 1'Spalte51
wall(17, 52) = 1'Spalte52
'Spalte53
wall(17, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(17, 60) = 1'Spalte60
wall(17, 61) = 1'Spalte61
wall(17, 62) = 1'Spalte62
wall(17, 63) = 1'Spalte63
wall(17, 64) = 1'Spalte64
'Spalte65
'Spalte66
'Spalte67
wall(17, 68) = 1'Spalte68
'Spalte69
wall(17, 70) = 1'Spalte70
wall(17, 71) = 1'Spalte71
wall(17, 72) = 1'Spalte72
wall(17, 73) = 1'Spalte73
wall(17, 74) = 1'Spalte74
'Spalte75
wall(17, 76) = 1'Spalte76
wall(17, 77) = 1'Spalte77

'--Zeile18---
'Spalte 4
wall(18, 5) = 1'Spalte 5
'Spalte 6
wall(18, 7) = 1'Spalte 7
'Spalte 8
wall(18, 9) = 1'Spalte 9
'Spalte10
'Spalte11
'Spalte12
wall(18, 13) = 1'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
'Spalte18
'Spalte19
'Spalte20
'Spalte21
'Spalte22
'Spalte23
'Spalte24
'Spalte25
wall(18, 26) = 1'Spalte26
'Spalte27
wall(18, 28) = 1'Spalte28
'Spalte29
wall(18, 30) = 1'Spalte30
wall(18, 31) = 1'Spalte31
wall(18, 32) = 1'Spalte32
wall(18, 33) = 1'Spalte33
wall(18, 34) = 1'Spalte34
'Spalte35
wall(18, 36) = 1'Spalte36
wall(18, 37) = 1'Spalte37
wall(18, 38) = 1'Spalte38
'Spalte39
wall(18, 40) = 1'Spalte40
'Spalte41
wall(18, 42) = 1'Spalte42
'Spalte43
'Spalte44
'Spalte45
'Spalte46
'Spalte47
'Spalte48
'Spalte49
'Spalte50
'Spalte51
wall(18, 52) = 1'Spalte52
'Spalte53
wall(18, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(18, 60) = 1'Spalte60
wall(18, 61) = 1'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
'Spalte67
wall(18, 68) = 1'Spalte68
'Spalte69
wall(18, 70) = 1'Spalte70
'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
wall(18, 76) = 1'Spalte76
'Spalte77

'--Zeile19---
'Spalte 4
'Spalte 5
'Spalte 6
wall(19, 7) = 1'Spalte 7
'Spalte 8
wall(19, 9) = 1'Spalte 9
'Spalte10
wall(19, 11) = 1'Spalte11
'Spalte12
wall(19, 13) = 1'Spalte13
'Spalte14
wall(19, 15) = 1'Spalte15
wall(19, 16) = 1'Spalte16
'Spalte17
wall(19, 18) = 1'Spalte18
'Spalte19
wall(19, 20) = 1'Spalte20
'Spalte21
wall(19, 22) = 1'Spalte22
'Spalte23
wall(19, 24) = 1'Spalte24
'Spalte25
wall(19, 26) = 1'Spalte26
'Spalte27
wall(19, 28) = 1'Spalte28
'Spalte29
wall(19, 30) = 1'Spalte30
'Spalte31
'Spalte32
'Spalte33
'Spalte34
'Spalte35
'Spalte36
'Spalte37
wall(19, 38) = 1'Spalte38
'Spalte39
wall(19, 40) = 1'Spalte40
'Spalte41
wall(19, 42) = 1'Spalte42
'Spalte43
wall(19, 44) = 1'Spalte44
wall(19, 45) = 1'Spalte45
wall(19, 46) = 1'Spalte46
wall(19, 47) = 1'Spalte47
wall(19, 48) = 1'Spalte48
'Spalte49
wall(19, 50) = 1'Spalte50
'Spalte51
wall(19, 52) = 1'Spalte52
'Spalte53
wall(19, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(19, 60) = 1'Spalte60
wall(19, 61) = 1'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
'Spalte67
wall(19, 68) = 1'Spalte68
'Spalte69
wall(19, 70) = 1'Spalte70
wall(19, 71) = 1'Spalte71
wall(19, 72) = 1'Spalte72
'Spalte73
wall(19, 74) = 1'Spalte74
wall(19, 75) = 1'Spalte75
wall(19, 76) = 1'Spalte76
'Spalte77

'--Zeile20---
'Spalte 4
wall(20, 5) = 1'Spalte 5
'Spalte 6
wall(20, 7) = 1'Spalte 7
'Spalte 8
'Spalte 9
'Spalte10
wall(20, 11) = 1'Spalte11
'Spalte12
wall(20, 13) = 1'Spalte13
'Spalte14
wall(20, 15) = 1'Spalte15
wall(20, 16) = 1'Spalte16
'Spalte17
wall(20, 18) = 1'Spalte18
'Spalte19
wall(20, 20) = 1'Spalte20
'Spalte21
wall(20, 22) = 1'Spalte22
'Spalte23
wall(20, 24) = 1'Spalte24
'Spalte25
wall(20, 26) = 1'Spalte26
'Spalte27
'Spalte28
'Spalte29
'Spalte30
'Spalte31
wall(20, 32) = 1'Spalte32
wall(20, 33) = 1'Spalte33
wall(20, 34) = 1'Spalte34
wall(20, 35) = 1'Spalte35
wall(20, 36) = 1'Spalte36
'Spalte37
wall(20, 38) = 1'Spalte38
'Spalte39
wall(20, 40) = 1'Spalte40
'Spalte41
wall(20, 42) = 1'Spalte42
'Spalte43
'Spalte44
'Spalte45
'Spalte46
'Spalte47
'Spalte48
'Spalte49
wall(20, 50) = 1'Spalte50
'Spalte51
'Spalte52
'Spalte53
wall(20, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(20, 60) = 1'Spalte60
wall(20, 61) = 1'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
'Spalte67
wall(20, 68) = 1'Spalte68
'Spalte69
wall(20, 70) = 1'Spalte70
'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
'Spalte76
'Spalte77

'--Zeile21---
'Spalte 4
wall(21, 5) = 1'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
wall(21, 9) = 1'Spalte 9
'Spalte10
wall(21, 11) = 1'Spalte11
'Spalte12
wall(21, 13) = 1'Spalte13
'Spalte14
wall(21, 15) = 1'Spalte15
wall(21, 16) = 1'Spalte16
'Spalte17
wall(21, 18) = 1'Spalte18
'Spalte19
wall(21, 20) = 1'Spalte20
'Spalte21
wall(21, 22) = 1'Spalte22
'Spalte23
wall(21, 24) = 1'Spalte24
wall(21, 25) = 1'Spalte25
wall(21, 26) = 1'Spalte26
'Spalte27
wall(21, 28) = 1'Spalte28
'Spalte29
wall(21, 30) = 1'Spalte30
wall(21, 31) = 1'Spalte31
wall(21, 32) = 1'Spalte32
'Spalte33
wall(21, 34) = 1'Spalte34
wall(21, 35) = 1'Spalte35
'Spalte36
'Spalte37
wall(21, 38) = 1'Spalte38
'Spalte39
wall(21, 40) = 1'Spalte40
'Spalte41
wall(21, 42) = 1'Spalte42
wall(21, 43) = 1'Spalte43
wall(21, 44) = 1'Spalte44
wall(21, 45) = 1'Spalte45
wall(21, 46) = 1'Spalte46
wall(21, 47) = 1'Spalte47
wall(21, 48) = 1'Spalte48
'Spalte49
wall(21, 50) = 1'Spalte50
'Spalte51
wall(21, 52) = 1'Spalte52
wall(21, 53) = 1'Spalte53
wall(21, 54) = 1'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
wall(21, 60) = 1'Spalte60
wall(21, 61) = 1'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
'Spalte67
wall(21, 68) = 1'Spalte68
'Spalte69
wall(21, 70) = 1'Spalte70
wall(21, 71) = 1'Spalte71
wall(21, 72) = 1'Spalte72
wall(21, 73) = 1'Spalte73
wall(21, 74) = 1'Spalte74
'Spalte75
wall(21, 76) = 1'Spalte76
'Spalte77

'--Zeile22---
'Spalte 4
wall(22, 5) = 1'Spalte 5
'Spalte 6
wall(22, 7) = 1'Spalte 7
wall(22, 8) = 1'Spalte 8
wall(22, 9) = 1'Spalte 9
'Spalte10
wall(22, 11) = 1'Spalte11
'Spalte12
wall(22, 13) = 1'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
wall(22, 18) = 1'Spalte18
'Spalte19
wall(22, 20) = 1'Spalte20
'Spalte21
wall(22, 22) = 1'Spalte22
'Spalte23
wall(22, 24) = 1'Spalte24
'Spalte25
'Spalte26
'Spalte27
wall(22, 28) = 1'Spalte28
'Spalte29
wall(22, 30) = 1'Spalte30
'Spalte31
'Spalte32
'Spalte33
'Spalte34
wall(22, 35) = 1'Spalte35
'Spalte36
wall(22, 37) = 1'Spalte37
wall(22, 38) = 1'Spalte38
'Spalte39
wall(22, 40) = 1'Spalte40
'Spalte41
'Spalte42
'Spalte43
wall(22, 44) = 1'Spalte44
'Spalte45
'Spalte46
'Spalte47
wall(22, 48) = 1'Spalte48
'Spalte49
wall(22, 50) = 1'Spalte50
'Spalte51
wall(22, 52) = 1'Spalte52
'Spalte53
'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
'Spalte60
'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
'Spalte67
wall(22, 68) = 1'Spalte68
'Spalte69
wall(22, 70) = 1'Spalte70
'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
wall(22, 76) = 1'Spalte76
'Spalte77

'--Zeile23---
'Spalte 4
wall(23, 5) = 1'Spalte 5
'Spalte 6
wall(23, 7) = 1'Spalte 7
'Spalte 8
'Spalte 9
'Spalte10
'Spalte11
'Spalte12
wall(23, 13) = 1'Spalte13
'Spalte14
'Spalte15
'Spalte16
'Spalte17
wall(23, 18) = 1'Spalte18
'Spalte19
wall(23, 20) = 1'Spalte20
'Spalte21
wall(23, 22) = 1'Spalte22
'Spalte23
wall(23, 24) = 1'Spalte24
'Spalte25
'Spalte26
'Spalte27
wall(23, 28) = 1'Spalte28
'Spalte29
'Spalte30
'Spalte31
wall(23, 32) = 1'Spalte32
wall(23, 33) = 1'Spalte33
'Spalte34
wall(23, 35) = 1'Spalte35
'Spalte36
'Spalte37
'Spalte38
'Spalte39
wall(23, 40) = 1'Spalte40
'Spalte41
wall(23, 42) = 1'Spalte42
'Spalte43
wall(23, 44) = 1'Spalte44
'Spalte45
wall(23, 46) = 1'Spalte46
wall(23, 47) = 1'Spalte47
wall(23, 48) = 1'Spalte48
'Spalte49
wall(23, 50) = 1'Spalte50
'Spalte51
wall(23, 52) = 1'Spalte52
'Spalte53
wall(23, 54) = 1'Spalte54
wall(23, 55) = 1'Spalte55
wall(23, 56) = 1'Spalte56
wall(23, 57) = 1'Spalte57
wall(23, 58) = 1'Spalte58
wall(23, 59) = 1'Spalte59
wall(23, 60) = 1'Spalte60
wall(23, 61) = 1'Spalte61
wall(23, 62) = 1'Spalte62
wall(23, 63) = 1'Spalte63
wall(23, 64) = 1'Spalte64
wall(23, 65) = 1'Spalte65
wall(23, 66) = 1'Spalte66
wall(23, 67) = 1'Spalte67
wall(23, 68) = 1'Spalte68
'Spalte69
wall(23, 70) = 1'Spalte70
'Spalte71
wall(23, 72) = 1'Spalte72
wall(23, 73) = 1'Spalte73
wall(23, 74) = 1'Spalte74
'Spalte75
wall(23, 76) = 1'Spalte76
'Spalte77

'--Zeile24---
'Spalte 4
wall(24, 5) = 1'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
wall(24, 9) = 1'Spalte 9
wall(24, 10) = 1'Spalte10
wall(24, 11) = 1'Spalte11
'Spalte12
wall(24, 13) = 1'Spalte13
'Spalte14
wall(24, 15) = 1'Spalte15
'Spalte16
'Spalte17
'Spalte18
'Spalte19
wall(24, 20) = 1'Spalte20
'Spalte21
wall(24, 22) = 1'Spalte22
'Spalte23
wall(24, 24) = 1'Spalte24
'Spalte25
wall(24, 26) = 1'Spalte26
'Spalte27
'Spalte28
'Spalte29
wall(24, 30) = 1'Spalte30
wall(24, 31) = 1'Spalte31
wall(24, 32) = 1'Spalte32
wall(24, 33) = 1'Spalte33
'Spalte34
wall(24, 35) = 1'Spalte35
wall(24, 36) = 1'Spalte36
wall(24, 37) = 1'Spalte37
wall(24, 38) = 1'Spalte38
wall(24, 39) = 1'Spalte39
wall(24, 40) = 1'Spalte40
'Spalte41
wall(24, 42) = 1'Spalte42
'Spalte43
wall(24, 44) = 1'Spalte44
'Spalte45
wall(24, 46) = 1'Spalte46
'Spalte47
'Spalte48
'Spalte49
'Spalte50
'Spalte51
wall(24, 52) = 1'Spalte52
'Spalte53
'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
'Spalte60
'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
'Spalte67
'Spalte68
'Spalte69
wall(24, 70) = 1'Spalte70
'Spalte71
wall(24, 72) = 1'Spalte72
'Spalte73
'Spalte74
'Spalte75
wall(24, 76) = 1'Spalte76
'Spalte77

'--Zeile25---
'Spalte 4
wall(25, 5) = 1'Spalte 5
'Spalte 6
wall(25, 7) = 1'Spalte 7
wall(25, 8) = 1'Spalte 8
wall(25, 9) = 1'Spalte 9
wall(25, 10) = 1'Spalte10
wall(25, 11) = 1'Spalte11
'Spalte12
wall(25, 13) = 1'Spalte13
'Spalte14
wall(25, 15) = 1'Spalte15
'Spalte16
wall(25, 17) = 1'Spalte17
wall(25, 18) = 1'Spalte18
'Spalte19
wall(25, 20) = 1'Spalte20
'Spalte21
wall(25, 22) = 1'Spalte22
'Spalte23
wall(25, 24) = 1'Spalte24
wall(25, 25) = 1'Spalte25
wall(25, 26) = 1'Spalte26
wall(25, 27) = 1'Spalte27
wall(25, 28) = 1'Spalte28
'Spalte29
wall(25, 30) = 1'Spalte30
wall(25, 31) = 1'Spalte31
wall(25, 32) = 1'Spalte32
'Spalte33
'Spalte34
'Spalte35
'Spalte36
'Spalte37
'Spalte38
'Spalte39
'Spalte40
'Spalte41
wall(25, 42) = 1'Spalte42
'Spalte43
wall(25, 33) = 1'Spalte44
'Spalte45
wall(25, 46) = 1'Spalte46
'Spalte47
wall(25, 48) = 1'Spalte48
wall(25, 49) = 1'Spalte49
wall(25, 50) = 1'Spalte50
'Spalte51
wall(25, 52) = 1'Spalte52
wall(25, 53) = 1'Spalte53
wall(25, 54) = 1'Spalte54
wall(25, 55) = 1'Spalte55
wall(25, 56) = 1'Spalte56
wall(25, 57) = 1'Spalte57
wall(25, 58) = 1'Spalte58
wall(25, 59) = 1'Spalte59
wall(25, 60) = 1'Spalte60
wall(25, 61) = 1'Spalte61
wall(25, 62) = 1'Spalte62
wall(25, 63) = 1'Spalte63
wall(25, 64) = 1'Spalte64
wall(25, 65) = 1'Spalte65
wall(25, 66) = 1'Spalte66
wall(25, 67) = 1'Spalte67
wall(25, 68) = 1'Spalte68
wall(25, 69) = 1'Spalte69
wall(25, 70) = 1'Spalte70
'Spalte71
wall(25, 72) = 1'Spalte72
'Spalte73
wall(25, 74) = 1'Spalte74
'Spalte75
wall(25, 76) = 1'Spalte76
'Spalte77

'--Zeile26---
'Spalte 4
'Spalte 5
'Spalte 6
'Spalte 7
'Spalte 8
'Spalte 9
'Spalte10
'Spalte11
'Spalte12
'Spalte13
'Spalte14
wall(26, 15) = 1'Spalte15
'Spalte16
wall(26, 17) = 1'Spalte17
wall(26, 18) = 1'Spalte18
'Spalte19
'Spalte20
'Spalte21
wall(26, 22) = 1'Spalte22
'Spalte23
'Spalte24
'Spalte25
'Spalte26
'Spalte27
wall(26, 28) = 1'Spalte28
'Spalte29
'Spalte30
'Spalte31
'Spalte32
'Spalte33
'Spalte34
wall(26, 35) = 1'Spalte35
wall(26, 36) = 1'Spalte36
wall(26, 37) = 1'Spalte37
wall(26, 38) = 1'Spalte38
wall(26, 39) = 1'Spalte39
wall(26, 40) = 1'Spalte40
'Spalte41
'Spalte42
'Spalte43
'Spalte44
'Spalte45
'Spalte46
'Spalte47
'Spalte48
'Spalte49
'Spalte50
'Spalte51
'Spalte52
'Spalte53
'Spalte54
'Spalte55
'Spalte56
'Spalte57
'Spalte58
'Spalte59
'Spalte60
'Spalte61
'Spalte62
'Spalte63
'Spalte64
'Spalte65
'Spalte66
'Spalte67
'Spalte68
'Spalte69
'Spalte70
'Spalte71
'Spalte72
'Spalte73
'Spalte74
'Spalte75
'Spalte76
'Spalte77

'---Special Symbols---
FOR k% = 1 TO 100
  RANDOMIZE TIMER
  i% = INT(RND * 27)
  j% = INT(RND * 77)
  IF ((i% > 3) AND (i% < 27) AND (j% > 3) AND (j% < 77) AND (wall(i%, j%) = 1)) THEN wall(i%, j%) = 2
NEXT k%
FOR k% = 1 TO 20
  RANDOMIZE TIMER
  i% = INT(RND * 27)
  j% = INT(RND * 77)
  IF ((i% > 3) AND (i% < 27) AND (j% > 3) AND (j% < 77) AND (wall(i%, j%) = 0)) THEN wall(i%, j%) = 3
NEXT k%

END SUB

