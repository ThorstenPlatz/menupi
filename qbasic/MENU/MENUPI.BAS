DECLARE SUB tastabfrag ()
DIM SHARED k$, cursor%, cursortest%
DECLARE SUB drawmenu ()
DECLARE SUB tastabfrage (k$)
DECLARE SUB runner ()
DECLARE SUB ende ()
DECLARE SUB info ()
DECLARE SUB frame ()
DECLARE SUB dreieckPI ()
DECLARE SUB streifenPI ()
DECLARE SUB montecarloPI ()
DECLARE SUB leibnitzPI ()
DECLARE SUB infoscreen ()
DECLARE SUB clrinfoscreen ()
SCREEN 12: COLOR 1
cursor% = 1
DO
 tastabfrag
 IF cursortest% <> cursor% THEN drawmenu
 frame
 COLOR 8: LOCATE 28, 8: PRINT "v 2.0"
LOOP UNTIL k$ = CHR$(27)
SYSTEM

SUB clrinfoscreen
FOR i% = 2 TO 28
FOR j% = 30 TO 79
  LOCATE i%, j%: PRINT " "
NEXT j%
NEXT i%
END SUB

SUB drawmenu

'-----------------zeichnet Menu-Screen---------------
COLOR 8
IF cursor% <> 1 THEN LINE (25, 45)-(125, 65), 1, B: LOCATE 4, 6: PRINT "Dreiecke"
IF cursor% <> 2 THEN LINE (25, 109)-(125, 129), 1, B: LOCATE 8, 6: PRINT "Streifen"
IF cursor% <> 3 THEN LINE (25, 173)-(125, 193), 1, B: LOCATE 12, 6: PRINT "Montecarlo"
IF cursor% <> 4 THEN LINE (25, 237)-(125, 257), 1, B: LOCATE 16, 6: PRINT "Leibnitz"
IF cursor% <> 5 THEN LINE (25, 301)-(125, 321), 1, B: LOCATE 20, 6: PRINT "Info"
IF cursor% <> 6 THEN LINE (25, 365)-(125, 385), 1, B: LOCATE 24, 6: PRINT "  EXIT"
'----------------------------
LINE (180, 1)-(180, 480), 1, B
LINE (185, 1)-(185, 480), 1, B
'---------------zeichnet aktuelles Menu-Feld---------
cursorselctor:
COLOR 7
SELECT CASE cursor%
 CASE 0
  cursor% = 6
  GOTO cursorselctor:
 CASE 1
  LINE (25, 45)-(125, 65), 9, B: LOCATE 4, 6: PRINT "Dreiecke"
  infoscreen
 CASE 2
  LINE (25, 109)-(125, 129), 9, B: LOCATE 8, 6: PRINT "Streifen"
  infoscreen
 CASE 3
  LINE (25, 173)-(125, 193), 9, B: LOCATE 12, 6: PRINT "Montecarlo"
  infoscreen
 CASE 4
  LINE (25, 237)-(125, 257), 9, B: LOCATE 16, 6: PRINT "Leibnitz"
  infoscreen
 CASE 5
  LINE (25, 301)-(125, 321), 9, B: LOCATE 20, 6: PRINT "Info"
  infoscreen
 CASE 6
  LINE (25, 365)-(125, 385), 9, B: LOCATE 24, 6: PRINT "  EXIT"
  infoscreen
 CASE IS = 7
  cursor% = 1
  GOTO cursorselctor:
END SELECT
cursortest% = cursor%
END SUB

SUB dreieckPI
  'Berechnung der Zahl PI
  'Das Programm errechnet die FlÑche des Einheitskreises mit Hilfe von Dreiecken
  'Die Seiten a & b diser Dreiecke haben die LÑnge 1, die Seiten c haben die LÑnge SIN(a) / SIN(b)
  'Das Programm verwndet Winkel im Bogenma·: Winkel = Winkel¯ * (PI/180¯)
  '
  'geschrieben am 10.06.1999 von Thorsten 'Tordy' Platz
  SCREEN 12
  CONST PI# = 3.141592654#
eingabe:
  CLS
  frame
  COLOR 8
  LINE (49, 419)-(578, 441), 4, B
  LOCATE 2, 10: PRINT "Anzahl der Ecken"
  LOCATE 3, 10: INPUT "( 100 < n < 1 000 000 000 000 000): ", n#
  IF n# < 100 GOTO eingabe
  IF n# >= 1000000000000000# GOTO eingabe
  anfang = TIMER
  LOCATE 23, 10: PRINT "Berechnung lÑuft..."
  DIM a, B, c, F AS DOUBLE
  p = n# / 100
  r = p: q = 0: s = 0
  a = 360 / n#              'Winkel a (Alpha)
  B = (180 - a) / 2        'Winkel b & C (Beta & Gamma)
  LOCATE 8, 13: PRINT "Winkel a =   "; USING "###.#################"; a
  LOCATE 9, 13: PRINT "Winkel b =   "; USING "###.#################"; B
  FOR i# = 1 TO n#
    F = F + (.5 * SIN(a * PI# / 180)) 'Berechnet die FlÑche des Kreises mit Hilfe von Dreiecken
    IF i# >= r THEN r = r + p: q = q + 1
    LOCATE 25, 10: PRINT "noch "; n# - i#; " zu berechnen     "
    LOCATE 25, 58: PRINT q; "% berechnet"
    IF q >= s THEN s = s + 5: LINE (50, 420)-(50 + (s * 5), 440), 1, BF
    IF INKEY$ = CHR$(27) THEN GOTO userende
    LOCATE 4, 65: PRINT "t: "; USING "####.####"; (TIMER - anfang)
  NEXT i#
  c = (SIN(a * PI# / 180)) / (SIN(B * PI# / 180)) 'Berechnet die Seite c der Dreicke
  IF q = 99 THEN s = s + 5: LINE (50, 420)-(50 + (s * 5), 440), 1, BF: q = 100: LOCATE 25, 58: PRINT q; "% berechnet"'korrigiert Fehler der Prozentanzeigen
  LOCATE 16, 10: PRINT "    Seite c = "; USING "###.###################"; c
  LOCATE 18, 10: PRINT "(FlÑche) PI = "; USING "##.####################"; F
  LOCATE 23, 10: PRINT "Berechnung abgeschlossen!"
  FOR i% = 440 TO 1000 STEP 100
    SOUND i%, 1
  NEXT i%
  GOTO ende

userende:
  COLOR 6: LOCATE 19, 28: PRINT "Berechnung unterbrochen..."

ende:
  DO
  end$ = INKEY$
  LOOP UNTIL end$ = CHR$(27)
  CLS

END SUB

SUB ende

SYSTEM

END SUB

SUB frame
COLOR 1
LINE (1, 1)-(1, 479) 'links
LINE (6, 6)-(6, 474) 'links innen
LINE (639, 1)-(639, 479) 'rechts
LINE (634, 6)-(634, 474) 'rechts innen
LINE (1, 1)-(639, 1) 'oben
LINE (6, 6)-(634, 6) 'oben innen
LINE (1, 479)-(639, 479) 'unten
LINE (6, 474)-(634, 474) 'unten innen

END SUB

SUB info

CLS
frame
COLOR 6
LOCATE 3, 35: PRINT "Info"
LOCATE 4, 34: PRINT "======"
COLOR 1
LOCATE 11, 20: PRINT "- Mit den Cursor-Tasten bewegen Sie sich im MenÅ"
LOCATE 13, 20: PRINT "- Mit der Return-Taste wÑhlen Sie den aktuellen "
LOCATE 14, 20: PRINT "  MenÅpunkt aus"
LOCATE 16, 20: PRINT "- Mit der ESC-Taste kînnen Sie das Programm abbrechen"
COLOR 6
LOCATE 25, 57: PRINT "geschrieben von:"
LOCATE 27, 57: PRINT "Thorsten 'Tordy' Platz"
LOCATE 28, 57: PRINT "am 31.06.1999"
DO
LOOP UNTIL INKEY$ = CHR$(27)
CLS

END SUB

SUB infoscreen
COLOR 7
SELECT CASE cursor%
 CASE 1 'Feld 1
  clrinfoscreen
  LOCATE 5, 35: PRINT "Berechnet die Zahl PI"
  LOCATE 6, 35: PRINT "====================="
  LOCATE 8, 35: PRINT "Berechnet die FlÑche des Einheitskreises"
  LOCATE 9, 35: PRINT "mit Hilfe von n Dreiecken"
 CASE 2 'Feld 2
  clrinfoscreen
  LOCATE 5, 35: PRINT "Berechnet die Zahl PI"
  LOCATE 6, 35: PRINT "====================="
  LOCATE 8, 35: PRINT "Berechnet die FlÑche des Einheitskreises"
  LOCATE 9, 35: PRINT "mit Hilfe von n Streifen"
 CASE 3 'Feld 3
  clrinfoscreen
  LOCATE 5, 35: PRINT "Berechnet die Zahl PI"
  LOCATE 6, 35: PRINT "====================="
  LOCATE 8, 35: PRINT "Berechnet die FlÑche des Einheitskreises"
  LOCATE 9, 35: PRINT "mit der Montecarlo-Methode"
 
 CASE 4 'Feld 4
  clrinfoscreen
  LOCATE 5, 35: PRINT "Berechnet die Zahl PI"
  LOCATE 6, 35: PRINT "====================="
  LOCATE 8, 35: PRINT "Berechnet die Zahl PI"
  LOCATE 9, 35: PRINT "nach der Leibnitzschen Methode:"
  LOCATE 10, 35: PRINT "PI = 1 - 1/3 + 1/5 - 1/7 + 1/9 +-...+- 1/n"
 
 CASE 5 'Feld 5
  clrinfoscreen
  LOCATE 5, 45: PRINT "Info"
 CASE 6 'Feld 6
  clrinfoscreen
  LOCATE 5, 40: PRINT "beendet das Programm"
END SELECT

END SUB

SUB leibnitzPI
DIM PI AS DOUBLE
SCREEN 12: CLS
frame
COLOR 8
LOCATE 3, 10: INPUT "DurchgÑnge (100 < n < 100000000): ", n&
PI = 1: v = -1
p = n& / 100
r = p: q = 0: s = 0
LOCATE 6, 10: PRINT "Berechnung lÑuft...": LINE (49, 419)-(578, 441), 4, B
anfang = TIMER
FOR i& = 3 TO n& STEP 2
  IF v = -1 THEN PI = PI - 1 / i& ELSE PI = PI + 1 / i&
  IF v = -1 THEN v = 1 ELSE v = -1
  IF i& >= r THEN r = r + p: q = q + 1
  LOCATE 25, 10: PRINT "noch "; (n& - i&) \ 2; " zu berechnen     "
  LOCATE 25, 58: PRINT q; "% berechnet"
  IF q >= s THEN s = s + 5: LINE (50, 420)-(50 + (s * 5), 440), 1, BF
  IF INKEY$ = CHR$(27) THEN GOTO abbruch
  LOCATE 4, 65: PRINT "t: "; USING "####.####"; (TIMER - anfang)
NEXT i&
IF q = 99 THEN s = s + 5: LINE (50, 420)-(50 + (s * 5), 440), 1, BF: q = 100: LOCATE 25, 58: PRINT q; "% berechnet"'korrigiert Fehler der Prozentanzeigen
LOCATE 6, 10: PRINT "Berechnung abgeschlossen!"
LOCATE 9, 10: PRINT "PI/4: ", USING "##.####################"; PI
LOCATE 12, 10: PRINT "PI:   ", USING "##.####################"; PI * 4
FOR i% = 440 TO 1000 STEP 100
  SOUND i%, 1
NEXT i%
GOTO ende3

abbruch:
COLOR 6: LOCATE 14, 30: PRINT "Berechnung abgebrochen..."

ende3:
DO
  end$ = INKEY$
LOOP UNTIL end$ = CHR$(27)
CLS

END SUB

SUB montecarloPI
SCREEN 12: CLS
frame
RANDOMIZE TIMER
COLOR 1
FOR i = 2 TO 27
  LOCATE i, 53: PRINT "∫"
NEXT i
FOR i = 2 TO 53
  LOCATE 27, i: PRINT "Õ"
NEXT i
LOCATE 27, 53: PRINT "º"
COLOR 8
eingabe3:
LOCATE 24, 55: PRINT "DurchgÑnge insgesamt:"
LOCATE 25, 55: PRINT "(100<n<1000000000000000)"
LOCATE 26, 55: INPUT "n: ", m#
IF m# < 100 GOTO eingabe3
IF m# >= 1000000000000000# GOTO eingabe3
anfang = TIMER
LINE (49, 439)-(576, 461), 4, B
LOCATE 15, 55: PRINT "Berechnung lÑuft..."
DIM a, x, y AS DOUBLE
t = 0: n = 0: a = 0
  p = m# / 100
  r = p: q = 0: s = 0
FOR i# = 1 TO m#
  IF INKEY$ = CHR$(27) GOTO abbruch2
  x = RND
  y = RND
  IF (x * x + y * y < 1) THEN PSET (10 + x * 400, 10 + y * 400), 2 ELSE PSET (10 + x * 400, 10 + y * 400), 4
  IF (x * x + y * y < 1) THEN t = t + 1
  n = n + 1
  IF i# >= r THEN r = r + p: q = q + 1
  LOCATE 18, 55: PRINT "noch "
  LOCATE 19, 56: PRINT m# - i#
  LOCATE 20, 55: PRINT "      zu berechnen"
  LOCATE 22, 55: PRINT q; "% berechnet"
  IF q >= s THEN s = s + 5: LINE (50, 440)-(50 + (s * 5), 460), 1, BF
  LOCATE 4, 65: PRINT "t: "; USING "####.####"; (TIMER - anfang)
NEXT i#
a = 4 * (t / n)
LOCATE 6, 55: PRINT n; " DurchgÑnge"
LOCATE 8, 55: PRINT t; " Treffer"
LOCATE 11, 55: PRINT "FlÑche (PI): "
LOCATE 12, 55: PRINT USING "##.####################"; a
IF q = 99 THEN s = s + 5: LINE (50, 440)-(50 + (s * 5), 460), 1, BF: q = 100: LOCATE 20, 55: PRINT q; "% berechnet"'korrigiert Fehler der Prozentanzeigen
LOCATE 15, 55: PRINT "Berechnung abgeschlossen!"
FOR i% = 440 TO 1000 STEP 100
  SOUND i%, 1
NEXT i%
GOTO ende4

abbruch2:
COLOR 6: LOCATE 19, 27: PRINT "Berechnung unterbrochen..."

ende4:
DO
end$ = INKEY$
LOOP UNTIL end$ = CHR$(27)
CLS
END SUB

SUB runner

SELECT CASE cursor%
 CASE 1
  dreieckPI
 CASE 2
  streifenPI
 CASE 3
  montecarloPI
 CASE 4
  leibnitzPI
 CASE 5
  info
 CASE 6
  ende
END SELECT
drawmenu
END SUB

SUB streifenPI
eingabe2:
SCREEN 12: CLS
frame
COLOR 8
LOCATE 3, 5: PRINT "Anzahl der Streifen"
LOCATE 4, 5: INPUT "( 100 < n < 1 000 000 000 000 000): ", n#
IF n# < 100 GOTO eingabe2
IF n# >= 1000000000000000# GOTO eingabe2
anfang = TIMER
LOCATE 23, 10: PRINT "Berechnung lÑuft..."
LINE (49, 419)-(578, 441), 4, B 'Rahmen der Prozentangabe
p = (1 / 100): q = 0: r = 0: s = 0: np# = 0
dx# = 1 / n#                    'errechnet die LÑnge der Streifen = dx
x# = 0: a# = 0                  'setzt x und die FlÑche A auf 0
DO
 np# = np# + 1
 x# = x# + dx#
 y# = (SQR(1 - (x# * x#)) * dx#) 'Position fÅr Punkt P(x,y) aus der Gleichung x^2 + y^2 = 1
 a# = a# + y#                    'Berechnet die 1/4 FlÑche des Einheitskreises
 IF x# >= r THEN r = r + p: q = q + 1
 LOCATE 25, 10: PRINT "noch "; n# - np#; " zu berechnen     "
 LOCATE 25, 58: PRINT q; "% berechnet"
 IF q >= s THEN s = s + 5: LINE (50, 420)-(50 + (s * 5), 440), 1, BF
 IF INKEY$ = CHR$(27) THEN GOTO userende2
 LOCATE 4, 65: PRINT "t: "; USING "####.####"; (TIMER - anfang)
LOOP UNTIL (x# >= 1 - dx#)      'Abbruchbedingung: x >= 1 - dx
PI# = a# * 4                    'PI = 4 * FlÑche des 1. Sektors
IF q = 101 THEN q = 100: LOCATE 25, 58: PRINT q; "% berechnet"'korrigiert Fehler der Prozentanzeigen
IF np# <> 0 THEN LOCATE 25, 10: PRINT "noch 0 zu berechnen     "
LOCATE 10, 10: PRINT "PI = "
LOCATE 10, 16: PRINT USING "##.####################"; PI#
LOCATE 23, 10: PRINT "Berechnung abgeschlossen!"
FOR i% = 440 TO 1000 STEP 100
  SOUND i%, 1
NEXT i%
GOTO ende2

userende2:
COLOR 6: LOCATE 19, 28: PRINT "Berechnung unterbrochen..."

ende2:
DO
end$ = INKEY$
LOOP UNTIL end$ = CHR$(27)
CLS
END SUB

SUB tastabfrag

k$ = INKEY$
'-------------------Cursor-Abfrage-------------------
IF k$ = CHR$(0) + CHR$(72) THEN cursor% = cursor% - 1'Pfeil hoch
IF k$ = CHR$(0) + CHR$(80) THEN cursor% = cursor% + 1 'Pfeil runter
IF k$ = CHR$(0) + CHR$(75) THEN cursor% = cursor% - 1'Pfeil links
IF k$ = CHR$(0) + CHR$(77) THEN cursor% = cursor% + 1'Pfeil rechts
IF k$ = CHR$(13) THEN runner 'Return-Taste
'IF k$ = CHR$(0) + CHR$(59) THEN  'F1-Taste
'IF k$ = CHR$(32) THEN 'Leer-Taste

END SUB

