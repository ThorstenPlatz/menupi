DIM SHARED wall(27, 80), y, x, yold, xold, r
DIM SHARED k$, kollission, drawer, change, starter, file$, path$
DECLARE SUB drawworm0 ()
DECLARE SUB drawworm1 ()
DECLARE SUB tast ()
DECLARE SUB drawworm ()
DECLARE SUB drawlab ()
DECLARE SUB wallset ()
DECLARE SUB new ()
DECLARE SUB save ()
DECLARE SUB load ()
DECLARE SUB ende ()
DECLARE SUB help ()
DECLARE SUB statistic ()
DECLARE SUB moveto ()

path$ = "a:\program\laby\labs" '!!!! Pfadangabe fÅr Labs !!!!

'---Programm Start---
kollission = 0: file$ = "standard.lab"
OPEN (paht$ + "\standard.lab") FOR OUTPUT AS #1
  FOR j% = 1 TO 27
    FOR i% = 1 TO 80
      WRITE #1, wall(j%, i%)
    NEXT i%
  NEXT j%
  WRITE #1, b
  WRITE #1, p%
CLOSE #1

start:

FOR j% = 3 TO 27
  FOR i% = 4 TO 77
    IF wall(j%, i%) = 9 THEN y = j%: x = i%
  NEXT i%
NEXT j%
SCREEN 12: CLS

DO
  starter = 0
  tast
  IF starter = 1 THEN GOTO start
  drawworm
  wallset
  drawlab
  COLOR 5
  LOCATE 1, 4: PRINT "Datei: "; LEFT$(file$, (LEN(file$) - 4))'gibt nur die Zeichen vor dem '.lab' aus
  LOCATE 1, 30: PRINT "x:"; x: LOCATE 1, 35: PRINT ";": LOCATE 1, 37: PRINT "y:"; y
  LOCATE 1, 47: PRINT "k:"; kollission
  COLOR 13: LOCATE 1, 28: PRINT "|": LOCATE 1, 43: PRINT "|": LOCATE 1, 54: PRINT "|"
  COLOR 5
  SELECT CASE drawer
  CASE 0
    LOCATE 1, 60: PRINT "drawing: _"
  CASE 1
    LOCATE 1, 60: PRINT "drawing: "; CHR$(178)
  CASE 2
    LOCATE 1, 60: PRINT "drawing: "; CHR$(177)
  CASE 3
    LOCATE 1, 60: PRINT "drawing: B";
  'CASE 4
  'CASE 5
  'CASE 6
  'CASE 7
  CASE 8
    LOCATE 1, 60: PRINT "drawing: "; CHR$(1)
  CASE 9
    LOCATE 1, 60: PRINT "drawing: "; CHR$(238)
  END SELECT
  LOCATE 28, 4: PRINT "(S)peichern"
  LOCATE 28, 18: PRINT "(L)aden"
  LOCATE 28, 28: PRINT "(N)eu"
  LOCATE 28, 38: PRINT "Hilfe: F1"
  LOCATE 28, 50: PRINT "Statistik: F2"
  LOCATE 28, 66: PRINT "Beenden: ESC"
  COLOR 13: LOCATE 28, 16: PRINT "|": LOCATE 28, 26: PRINT "|": LOCATE 28, 35: PRINT "|": LOCATE 28, 48: PRINT "|": LOCATE 28, 64: PRINT "|"
LOOP UNTIL k$ = CHR$(27)

CLS
LOCATE 12, 25: PRINT "Editor beenden (J/N):"
LOCATE 12, 46: INPUT "", beenden$
IF beenden$ = "j" OR beenden$ = "J" THEN ende ELSE GOTO start

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

IF kollission = 0 THEN drawworm0
IF kollission = 1 THEN drawworm1

END SUB

SUB drawworm0
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

SUB drawworm1
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

SUB ende
GOTO test

ask:
CLS
LOCATE 12, 25: INPUT "Datei speichern (J/N)"; speichern$
IF LCASE$(speichern$) = "j" THEN save ELSE GOTO sys

test:
FOR j% = 3 TO 27
  FOR i% = 4 TO 77
    IF wall(j%, i%) > 0 THEN GOTO ask
  NEXT i%
NEXT j%

sys:
SYSTEM

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

FOR j% = 5 TO 22
  LOCATE j%, 35: PRINT "∫" 'senkrechter Mittelstrich
NEXT j%

LOCATE 1, 1: PRINT "…"
LOCATE 1, 80: PRINT "ª"
LOCATE 28, 1: PRINT "»"
LOCATE 28, 80: PRINT "º"
'--- frame ---

COLOR 5
'---öberschrift---
LOCATE 2, 35: PRINT "Hilfe"
LOCATE 3, 34: PRINT "======="

'---linker Block---
LOCATE 5, 5: PRINT "Mit den Zahlen 0-9"
LOCATE 6, 5: PRINT "wÑhlt man den Draw-Typ"
LOCATE 9, 5: PRINT CHR$(4); " 0:   normaler Durchgang"
LOCATE 10, 5: PRINT CHR$(4); " 1:   feste Mauer"
LOCATE 11, 5: PRINT CHR$(4); " 2:   sprengbare Mauer"
LOCATE 12, 5: PRINT CHR$(4); " 3:   Bombe"
LOCATE 13, 5: PRINT CHR$(4); " 4:   Bomb-Power-Improver"
LOCATE 14, 5: PRINT CHR$(4); " 5:   #"
LOCATE 15, 5: PRINT CHR$(4); " 6:   #"
LOCATE 16, 5: PRINT CHR$(4); " 7:   #"
LOCATE 17, 5: PRINT CHR$(4); " 8:   setzt Startposition"
LOCATE 18, 5: PRINT CHR$(4); " 9:   zeichnet nichts"
LOCATE 21, 5: PRINT CHR$(4); " Taste >M< ruft 'MoveTo' auf"

'---rechter Block---
LOCATE 5, 40: PRINT "MenÅleisten:"
LOCATE 6, 40: PRINT "(oberer / unterer Bildschirmrand)"
LOCATE 9, 40: PRINT CHR$(4); " Datei: zeigt den Dateinamen an"
LOCATE 10, 40: PRINT CHR$(4); " x,y: gibt die Position des Drawers an"
LOCATE 11, 40: PRINT CHR$(4); " k: Kolissionsabfrage an(1) / aus(0)"
LOCATE 12, 40: PRINT CHR$(4); " drawing: zeigt den Draw-Modus an"
LOCATE 13, 40: PRINT CHR$(4); " Speichern: speichert den Level"
LOCATE 14, 40: PRINT CHR$(4); " Laden: lÑdt einen gesicherten Level"
LOCATE 15, 40: PRINT CHR$(4); " Neu: lÑdt einen neuen (leeren) Level"
LOCATE 16, 40: PRINT CHR$(4)
LOCATE 17, 40: PRINT CHR$(4); " Hilfe: Dieses Fenster"
LOCATE 18, 40: PRINT CHR$(4); " Beenden: Beendet den Level-Editor"
'---unterer Block---
LOCATE 24, 20: PRINT "Mit den Cursortasten bewegt man den Drawer"

COLOR 4: LOCATE 26, 10: PRINT "HINWEIS: "
COLOR 1: LOCATE 26, 19: PRINT "Es sollte nur eine Startposition definiert werden!!!"

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
IF file$ = "@" THEN EXIT SUB

CHDIR path$: SHELL (LEFT$(path$, 2))
file$ = file$ + ".lab"
RESET
20 OPEN file$ FOR INPUT AS #1
30
FOR j% = 1 TO 27
  FOR i% = 1 TO 80
    INPUT #1, wall(j%, i%) 'EintrÑge aus Datei einlesen.
    IF wall(j%, i%) = 8 THEN y = j%: x = i% 'Startposition festlegen
  NEXT i%
NEXT j%
INPUT #1, b
INPUT #1, p%
CLOSE #1
drawer = 9: CLS
END SUB

SUB moveto

LINE (280, 170)-(360, 220), 1, BF
DO
  COLOR 5: LOCATE 12, 39: INPUT "y: ", y: LOCATE 12, 43
LOOP UNTIL ((y > 2) AND (y < 27))
DO
  COLOR 5: LOCATE 13, 39: INPUT "x: ", x: LOCATE 13, 43
LOOP UNTIL ((x > 3) AND (x < 78))
CLS

END SUB

SUB new
CLS
LOCATE 12, 25: INPUT "Datei speichern (J/N)"; speichern$
IF LCASE$(speichern$) = "j" THEN save
FOR j% = 3 TO 26
  FOR i% = 4 TO 77
    wall(j%, i%) = 0
  NEXT i%
NEXT j%
b = 3
p% = 3
y = 3: x = 4
CLS
END SUB

SUB save
CLS
DO
  LOCATE 7, 20: INPUT "Anzahl der Bomben zu Beginn: ", b
  LOCATE 9, 20: INPUT "StÑrke der Bombe (in Feldern): ", p%
LOOP UNTIL ((b >= 0) AND (p% >= 0))

CHDIR path$: SHELL (LEFT$(path$, 2))
DO
  CLS : COLOR 5
  LOCATE 26, 25: PRINT "Abbruch: @"
  LOCATE 24, 25: INPUT "Dateiname (max 8 Zeichen): ", file$
LOOP UNTIL (LEN(file$) < 9) AND (LEN(file$) > 0)
IF file$ = "@" THEN EXIT SUB

file$ = file$ + ".lab"
OPEN file$ FOR OUTPUT AS #1
FOR j% = 1 TO 27
  FOR i% = 1 TO 80
    WRITE #1, wall(j%, i%)
  NEXT i%
NEXT j%
WRITE #1, b
WRITE #1, p%
CLOSE #1
CLS
END SUB

SUB statistic

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

LOCATE 1, 1: PRINT "…"
LOCATE 1, 80: PRINT "ª"
LOCATE 28, 1: PRINT "»"
LOCATE 28, 80: PRINT "º"
'--- frame ---

COLOR 5
empty = 0: starts = 0
wallf = 0: walls = 0
bombs = 0: bombi = 0

FOR j% = 3 TO 26
  FOR i% = 4 TO 77
    IF wall(j%, i%) = 0 THEN empty = empty + 1
    IF wall(j%, i%) = 1 THEN wallf = wallf + 1
    IF wall(j%, i%) = 2 THEN walls = walls + 1
    IF wall(j%, i%) = 3 THEN bombs = bombs + 1
    IF wall(j%, i%) = 4 THEN bombi = bombi + 1
    IF wall(j%, i%) = 8 THEN starts = starts + 1
  NEXT i%
NEXT j%

LOCATE 6, 27: PRINT "Level-Statistik:"
LOCATE 7, 27: PRINT "ÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓÓ"
LOCATE 10, 27: PRINT "leere Zellen: "; empty
LOCATE 11, 27: PRINT "feste Mauern: "; wallf
LOCATE 12, 27: PRINT "sprengbare Mauern: "; walls
LOCATE 13, 27: PRINT "Bomben: "; bombs
LOCATE 14, 27: PRINT "Bomb-Improver: "; bombi
LOCATE 15, 27: PRINT "Startpositionen: "; starts
LOCATE 16, 27: PRINT "----------------------"
LOCATE 17, 27
IF (empty + wallf + walls + boms + bombi + starts) <> 1776 THEN PRINT "ERROR !!!!!!!" ELSE PRINT "Zellen gesamt: 1776"
IF starts > 1 THEN COLOR 4: LOCATE 21, 15: PRINT "ACHTUNG! ": COLOR 5: LOCATE 22, 15: PRINT "Es wurden mehr als EINE Startposition gefunden"
DO
LOOP UNTIL INKEY$ = CHR$(27)
CLS
END SUB

SUB tast
'--- Tastaturabfrage
  xold = x 'Speichern der Position
  yold = y 'fÅr Kollissionsabfrage

k$ = INKEY$

IF k$ = CHR$(0) + CHR$(80) THEN r = 1: y = y + 1'(Cursor down)
IF k$ = CHR$(0) + CHR$(72) THEN r = -1: y = y - 1'(Cursor up)
IF k$ = CHR$(0) + CHR$(77) THEN r = 2: x = x + 1'(Cursor right)
IF k$ = CHR$(0) + CHR$(75) THEN r = -2: x = x - 1'(Cursor left)

IF x <= 3 THEN x = 4
IF x >= 78 THEN x = 77
IF y <= 2 THEN y = 3
IF y >= 27 THEN y = 26

IF k$ = "k" OR k$ = "K" THEN kollission = kollission + 1
IF kollission > 1 THEN kollission = 0
IF kollission < 0 THEN kollission = 1

change = 0
IF k$ = "0" THEN drawer = 0: change = 1
IF k$ = "1" THEN drawer = 1: change = 1
IF k$ = "2" THEN drawer = 2: change = 1
IF k$ = "3" THEN drawer = 3: change = 1
IF k$ = "4" THEN drawer = 4: change = 1
'if k$ = "5" then drawer =5: change = 1
'if k$ = "6" then drawer =6: change = 1
'if k$ = "7" then drawer =7: change = 1
IF k$ = "8" THEN drawer = 8: change = 1
IF k$ = "9" THEN drawer = 9: change = 1

IF k$ = "s" OR k$ = "S" THEN save: starter = 1
IF k$ = "l" OR k$ = "L" THEN load: starter = 1
IF k$ = "n" OR k$ = "N" THEN new
IF k$ = CHR$(0) + CHR$(59) THEN help
IF k$ = CHR$(0) + CHR$(60) THEN statistic
IF k$ = "m" OR k$ = "M" THEN moveto

END SUB

SUB wallset

SELECT CASE drawer
CASE 8
wall(y, x) = 8
CASE 9
CASE ELSE
  wall(y, x) = drawer
END SELECT

END SUB

