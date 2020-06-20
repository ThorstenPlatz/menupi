DECLARE SUB intro ()
DECLARE SUB over ()
DECLARE SUB hlp ()
DECLARE SUB wecker ()
DECLARE SUB timer1 ()
DECLARE SUB timer2 ()
DECLARE SUB ende ()
DECLARE SUB spiel ()
DECLARE SUB menu2 ()
DECLARE SUB stopuhr ()
DECLARE SUB hllp ()
DECLARE SUB crdt ()
intro
begin:
over
CLS
COLOR 1
LINE (0, 0)-(640, 480), 1, BF
LINE (50, 50)-(590, 430), 0, BF
LINE (210, 104)-(422, 134), 1, B
LINE (210, 152)-(422, 182), 1, B
LINE (210, 200)-(422, 230), 1, B
LINE (210, 248)-(422, 278), 1, B
LINE (210, 296)-(422, 326), 1, B

LOCATE 8, 36: PRINT "Programme"
LOCATE 11, 38: PRINT "Spiel"
LOCATE 14, 38: PRINT "Hilfe"
LOCATE 17, 37: PRINT "Credits"
LOCATE 20, 38: PRINT "Ende"

cursor = 1
DO
k$ = INKEY$
SELECT CASE k$

CASE CHR$(0) + CHR$(80) 'Cursor down
cursor = cursor + 1
IF cursor >= 7 THEN cursor = 1: cursor = cursor + 1

IF cursor = 2 THEN LINE (210, 104)-(422, 134), 9, B ELSE LINE (210, 104)-(422, 134), 1, B
IF cursor = 3 THEN LINE (210, 152)-(422, 182), 9, B ELSE LINE (210, 152)-(422, 182), 1, B
IF cursor = 4 THEN LINE (210, 200)-(422, 230), 9, B ELSE LINE (210, 200)-(422, 230), 1, B
IF cursor = 5 THEN LINE (210, 248)-(422, 278), 9, B ELSE LINE (210, 248)-(422, 278), 1, B
IF cursor = 6 THEN LINE (210, 296)-(422, 326), 9, B ELSE LINE (210, 296)-(422, 326), 1, B

CASE CHR$(0) + CHR$(72) 'Cursor up
cursor = cursor - 1
IF cursor <= 1 THEN cursor = 7: cursor = cursor - 1

IF cursor = 2 THEN LINE (210, 104)-(422, 134), 9, B ELSE LINE (210, 104)-(422, 134), 1, B
IF cursor = 3 THEN LINE (210, 152)-(422, 182), 9, B ELSE LINE (210, 152)-(422, 182), 1, B
IF cursor = 4 THEN LINE (210, 200)-(422, 230), 9, B ELSE LINE (210, 200)-(422, 230), 1, B
IF cursor = 5 THEN LINE (210, 248)-(422, 278), 9, B ELSE LINE (210, 248)-(422, 278), 1, B
IF cursor = 6 THEN LINE (210, 296)-(422, 326), 9, B ELSE LINE (210, 296)-(422, 326), 1, B

CASE CHR$(27) 'ESC-Taste
ende

CASE CHR$(0) + CHR$(59) 'F1-Taste
hlp
GOTO begin

CASE CHR$(13) 'Eingabe-Taste
SELECT CASE cursor
CASE IS = 2: menu2: GOTO begin
CASE IS = 3: spiel: GOTO begin
CASE IS = 4: hllp: GOTO begin
CASE IS = 5: crdt: GOTO begin
CASE IS = 6: ende

END SELECT
END SELECT

LOOP

SUB crdt
IF INKEY$ = CHR$(27) THEN GOTO xxx
SCREEN 12: CLS
COLOR 1: SLEEP 2
LOCATE 3, 35: PRINT "Credits": SLEEP 2
LOCATE 6, 10: PRINT "-programmed": SLEEP 1
LOCATE 7, 10: PRINT "-tested": SLEEP 1
LOCATE 8, 10: PRINT "-concepted": SLEEP 1
LOCATE 10, 10: PRINT "by Tordy": SLEEP 1
LOCATE 28, 2: PRINT "ver. 2.00.30.05.1999"
FOR z = 1 TO 4500: NEXT z
LOCATE 24, 50: PRINT "Thorsten 'Tordy' Platz"
LOCATE 25, 50: PRINT "Sachsenstr. 57"
LOCATE 26, 50: PRINT "D-66482 ZweibrÅcken"
LOCATE 28, 50: PRINT "Tel.:06332/44562"
SLEEP 3
DRAW "BL75 C1 "
DRAW "U30 R15 L30 BR15 BD30"
FOR z = 1 TO 2900: NEXT z
DRAW "BR40"
DRAW "L10 TA45 U10 TA360 U15 TA45 R10 TA360 R10 TA45 D10 TA360 D15 TA 45 L10"
FOR z = 1 TO 2900: NEXT z
DRAW "TA360 BR20 "
DRAW "U30 R10 TA45 D5 TA0 D10 TA45 L5 TA0 L10 TA45 D18"
FOR z = 1 TO 2900: NEXT z
DRAW "TA0 BR20"
DRAW "U30 R10 TA 45 D10 TA0 D16 TA-45 D10 TA0 L10"
FOR z = 1 TO 2900: NEXT z
DRAW "BR35"
DRAW "U15 TA30 U17 BD17 TA-30 U17"
FOR z = 1 TO 2900: NEXT z
DRAW "TA0 BU5"
DO
LOOP UNTIL INKEY$ = CHR$(27)

xxx:
SLEEP 1
END SUB

SUB ende
SCREEN 12
COLOR 1
x = 1
DO
 IF INKEY$ = CHR$(27) THEN GOTO qqq
 LINE (1, 1)-(640, x), , B
 LINE (1, 480)-(640, (480 - x)), , B
 LINE (1, 10)-(x, 470), , B
 LINE (640, 10)-((640 - x), 480), , B
 x = x + 1
 FOR z = 1 TO 800: NEXT z
LOOP UNTIL x = 237

x = 200
COLOR 1
DO
 IF INKEY$ = CHR$(27) THEN GOTO qqq
 LINE (1, 10)-(x, 470), , B
 LINE (640, 10)-((640 - x), 480), , B
 x = x + 1
 FOR z = 1 TO 800: NEXT z
LOOP UNTIL x = 321

FOR x = 1 TO 400 STEP .5
 IF INKEY$ = CHR$(27) THEN GOTO qqq
 CIRCLE (320, 240), x, 0
NEXT x

FOR n = 1 TO 200
 IF INKEY$ = CHR$(27) THEN GOTO qqq
 FOR p = 1 TO 100
  xps = INT(RND * 640)
  yps = INT(RND * 480)
  REM col = INT(RND * 15) 'Farbe
  PSET (xps, yps), 1      ' mit Farbe: PSET (xps, yps), col
 NEXT p
NEXT n

REM LOCATE 15, 38: COLOR 1
REM LINE (293, 220)-(330, 243), 1, BF

qqq:
REM LOCATE 25, 38: PRINT "Ende"
FOR x = 1 TO 480
 LINE (0, 0)-(640, x), 0, B
 FOR z = 1 TO 50
 NEXT z
NEXT x
SYSTEM

END SUB

SUB hllp
a = 6
B = 5
CLS : LOCATE 3, 36: PRINT "Hilfe"
LINE (5, 5)-(640, 25), 1, BF: LINE (5, 455)-(640, 480), 1, BF
LINE (270, 50)-(330, 50), 1

LOCATE a, B: PRINT "Der MenÅpunkt 'Programme' îffnet ein UntermenÅ,"
LOCATE a + 1, B: PRINT "in  dem Sie die Wahl zwischen folgenden MenÅ-"
LOCATE a + 2, B: PRINT "punkten  zur  Auswahl  haben:"
LOCATE a + 4, B: PRINT "        Timer 1                   <- Countdown-Timer ohne ZÑhlgerÑusch"
LOCATE a + 5, B: PRINT "        Timer 2                   <- Countdown-Timer mit  ZÑhlgerÑusch"
LOCATE a + 6, B: PRINT "        Stopuhr                   <- erklÑrt sich wohl von selbst"
LOCATE a + 7, B: PRINT "        Wecker                    <- erklÑrt sich wohl von selbst"
LOCATE a + 8, B: PRINT "        zurÅck                    <- bringt Sie zum vorherigen MenÅ zurÅck"
LOCATE a + 11, B: PRINT "Der MenÅpunkt 'Spiel' îffnet ein (kleines) Spielchen"
LOCATE a + 13, B: PRINT "Der MenÅpunkt 'Hilfe' wird momentan angezeigt"
LOCATE a + 15, B: PRINT "Der MenÅpunkt 'Ende' beendet das Programm"

LOCATE 28, 24: PRINT "ESC um zum MenÅ zurÅck zu kehren"
DO
LOOP UNTIL INKEY$ = CHR$(27)
END SUB

SUB hlp
CLS
DO
LOCATE 3, 35: PRINT "Hilfe"

LOCATE 13, 10: PRINT "Benutzen Sie die Cursortasten um sich im MenÅ zu bewegen."
LOCATE 15, 10: PRINT "Mit der Enter-Taste bestÑtigen Sie Ihre Auswahl."
LOCATE 17, 10: PRINT "Mit der ESC-Taste beenden Sie die Programme"
LOCATE 28, 17: PRINT "(ESC) drÅcken um wieder zum MenÅ zu gelangen..."
LOOP UNTIL INKEY$ = CHR$(27)
END SUB

SUB intro
SCREEN 12
COLOR 1
FOR n = 1 TO 200
 IF INKEY$ = CHR$(27) THEN GOTO pp
 FOR p = 1 TO 100
  xps = INT(RND * 640)
  yps = INT(RND * 480)
  REM col = INT(RND * 15) 'Farbe
  PSET (xps, yps), 1      ' mit Farbe: PSET (xps, yps), col
  NEXT p
NEXT n

FOR x = 400 TO 1 STEP -.5
 IF INKEY$ = CHR$(27) THEN GOTO pp
 CIRCLE (320, 240), x, 0
 CIRCLE (321, 240), x, 0
NEXT x

x = 320
COLOR 1
DO
 IF INKEY$ = CHR$(27) THEN GOTO pp
 LINE (320, 235)-(x, 245), , B
 LINE (320, 235)-((640 - x), 245), , B
 x = x + 1
 FOR z = 1 TO 400
 NEXT z
LOOP UNTIL x = 400
pp:
END SUB

SUB menu2
begn:
CLS
over
CLS
LINE (0, 0)-(640, 480), 1, BF
LINE (50, 50)-(590, 430), 0, BF
LINE (210, 104)-(422, 134), 1, B
LINE (210, 152)-(422, 182), 1, B
LINE (210, 200)-(422, 230), 1, B
LINE (210, 248)-(422, 278), 1, B
LINE (210, 296)-(422, 326), 1, B

LOCATE 8, 37: PRINT "Timer1"
LOCATE 11, 37: PRINT "Timer2"
LOCATE 14, 36: PRINT "Stopuhr"
LOCATE 17, 37: PRINT "Wecker"
LOCATE 20, 37: PRINT "zurÅck"

cursor = 1
DO
k$ = INKEY$
SELECT CASE k$

CASE CHR$(0) + CHR$(80)
cursor = cursor + 1
IF cursor >= 7 THEN cursor = 1: cursor = cursor + 1

IF cursor = 2 THEN LINE (210, 104)-(422, 134), 9, B ELSE LINE (210, 104)-(422, 134), 1, B
IF cursor = 3 THEN LINE (210, 152)-(422, 182), 9, B ELSE LINE (210, 152)-(422, 182), 1, B
IF cursor = 4 THEN LINE (210, 200)-(422, 230), 9, B ELSE LINE (210, 200)-(422, 230), 1, B
IF cursor = 5 THEN LINE (210, 248)-(422, 278), 9, B ELSE LINE (210, 248)-(422, 278), 1, B
IF cursor = 6 THEN LINE (210, 296)-(422, 326), 9, B ELSE LINE (210, 296)-(422, 326), 1, B

CASE CHR$(0) + CHR$(72)
cursor = cursor - 1
IF cursor <= 1 THEN cursor = 7: cursor = cursor - 1

IF cursor = 2 THEN LINE (210, 104)-(422, 134), 9, B ELSE LINE (210, 104)-(422, 134), 1, B
IF cursor = 3 THEN LINE (210, 152)-(422, 182), 9, B ELSE LINE (210, 152)-(422, 182), 1, B
IF cursor = 4 THEN LINE (210, 200)-(422, 230), 9, B ELSE LINE (210, 200)-(422, 230), 1, B
IF cursor = 5 THEN LINE (210, 248)-(422, 278), 9, B ELSE LINE (210, 248)-(422, 278), 1, B
IF cursor = 6 THEN LINE (210, 296)-(422, 326), 9, B ELSE LINE (210, 296)-(422, 326), 1, B

CASE CHR$(27)
GOTO 999

CASE CHR$(0) + CHR$(59)
hlp
GOTO begn

CASE CHR$(13)
SELECT CASE cursor
CASE IS = 2: timer1: GOTO begn
CASE IS = 3: timer2: GOTO begn
CASE IS = 4: stopuhr: GOTO begn
CASE IS = 5: wecker: GOTO begn
CASE IS = 6: GOTO 999

END SELECT
END SELECT

LOOP

999 CLS
END SUB

SUB over
COLOR 1
x = 320
COLOR 1
DO
 'IF INKEY$ = CHR$(27) THEN GOTO pp
 LINE (320, 235)-(x, 245), , B
 LINE (320, 235)-((640 - x), 245), , B
 x = x + 1
LOOP UNTIL x = 400
x = 1
DO
 COLOR 1
 'IF INKEY$ = CHR$(27) THEN GOTO pp
                        LINE (1, 240)-(640, 240 - x), , B
 IF (240 - x) > 50 THEN LINE (50, 239)-(590, 240 - x), 0, B
                         LINE (1, 480)-(640, 240 + x), , B
 IF (240 + x) < 430 THEN LINE (50, 430)-(590, 240 + x), 0, B
                        LINE (1, 10)-(320 - x, 480), , B
 IF (320 - x) > 50 THEN LINE (50, 50)-(320 - x, 430), 0, B
                         LINE (640, 10)-((320 + x), 480), , B
 IF (320 + x) < 590 THEN LINE (590, 50)-((320 + x), 430), 0, B
 IF (320 + x) < 590 THEN LINE (320, 237)-(320 + x, 243), 0, B
 IF (320 - x) > 50 THEN LINE (320, 237)-(320 - x, 243), 0, B
 x = x + 1
 FOR z = 1 TO 10
 NEXT z
LOOP UNTIL x = 320

END SUB

SUB spiel
100 CLS : LINE (100, 100)-(500, 400), 1, BF

LINE (100, 140)-(500, 145), 9, BF

LINE (100, 199)-(500, 200), 9, BF
LINE (100, 230)-(500, 231), 9, BF
LINE (100, 263)-(500, 264), 9, BF
LINE (100, 297)-(500, 298), 9, BF
LOCATE 8, 32: PRINT "StÑbe ziehen"
105 LOCATE 14, 20: PRINT "Du kannst 1-3 StÑbe auf einmal nehmen"
110 LOCATE 16, 16: PRINT "Das Ziel ist nicht den letzten Stab zu nehmen"
120 LOCATE 18, 24: INPUT "Anzahl der StÑbe insgesamt:", T
130 IF T < 1 THEN 120
LINE (100, 327)-(500, 328), 9, BF: LINE (100, 357)-(500, 358), 9, BF
140 LOCATE 22, 27: INPUT "Du zuerst (ja/nein)"; Y$: CLS
150 IF Y$ = "ja" THEN 210
155 IF Y$ = "j" THEN 210
'-------Computer--------
160 C = T - 1 - INT((T - 1) / 4) * 4
170 IF C = 0 THEN C = 1
173 CLS : LINE (200, 150)-(400, 300), 1, BF: LOCATE 13, 30: PRINT "Restliche StÑbe"; T
175 LOCATE 17, 33: PRINT "Ich nehme"; C: SLEEP 2
179 T = T - C
180 IF T > 0 THEN 210
190 CLS : LINE (200, 150)-(400, 300), 1, BF: LOCATE 13, 30: PRINT "Ich habe verloren"
200 GOTO 270
'--------Spieler--------
210 CLS : LINE (200, 150)-(400, 300), 1, BF: LOCATE 13, 30: PRINT "Restliche StÑbe"; T
220 LOCATE 17, 28: INPUT "Wieviele nimmst Du"; H: SLEEP 2
230 IF H < 1 OR H > 3 THEN 220
240 T = T - H
250 IF T > 0 THEN 160
260 CLS : LINE (200, 150)-(400, 300), 1, BF: LOCATE 13, 31: PRINT "Du hast verloren"
'----------ENDE---------
270 LOCATE 18, 29: INPUT "Nochmal (ja/nein)"; Y$
280 IF Y$ = "ja" THEN 100
281 IF Y$ = "JA" THEN 100
282 IF Y$ = "Ja" THEN 100
283 IF Y$ = "jA" THEN 100
284 IF Y$ = "J" THEN 100
285 IF Y$ = "j" THEN 100
290 SLEEP 2: CLS : SLEEP 1
END SUB

SUB stopuhr
CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
LET sekunde = 0
LET minute = 0
LET stunde = 0
DO
LOCATE 16, 25: PRINT "Leertaste zum starten drÅcken..."
LOOP UNTIL INKEY$ = CHR$(32)

start:
CLS : LOCATE 13, 34: PRINT stunde; ":"; minute; ":"; sekunde;
LOCATE 23, 25: PRINT "Leertaste zum stoppen drÅcken...": SLEEP 1
IF INKEY$ = CHR$(32) THEN GOTO xxxx
LET sekunde = sekunde + 1
IF sekunde = 60 THEN LET sekunde = 0: LET minute = minute + 1
IF minute = 60 THEN LET minute = 0: LET stunde = stunde + 1
IF stunde = 24 THEN LET stunde = 0
GOTO start

xxxx:
DO
LOCATE 27, 28: PRINT "ESC drÅcken um zu beenden.."
LOOP UNTIL INKEY$ = CHR$(27)

END SUB

SUB timer1
'Stumm
CLS
LINE (190, 120)-(390, 250), 1, BF: COLOR 15
LOCATE 10, 28, 0, 25, 30: INPUT "Stunden  (0-23) :", stunden
LOCATE 12, 28, 0: INPUT "Minuten  (0-59) :", minuten
LOCATE 14, 28, 0: INPUT "Sekunden (0-59) :", sekunden
LET time = stunden * 60 ^ 2 + minuten * 60 + sekunden
FOR time = time TO 0 STEP -1: IF INKEY$ = CHR$(27) THEN END
SLEEP 1: CLS : LINE (100, 180)-(560, 260), 1, BF
LOCATE 14, 31: PRINT "  "; time; "       "
LOCATE 14, 49: PRINT "     Sekunden  "
NEXT time
DO
SOUND 1500, 14: SLEEP 1
LOOP UNTIL INKEY$ = CHR$(27)

END SUB

SUB timer2
'Mit ZÑhlgerÑusch
CLS
LINE (190, 120)-(390, 250), 1, BF: COLOR 9
LOCATE 10, 28, 0, 25, 30: INPUT "Stunden  (0-23) :", stunden
LOCATE 12, 28, 0: INPUT "Minuten  (0-59) :", minuten
LOCATE 14, 28, 0: INPUT "Sekunden (0-59) :", sekunden
LET time = stunden * 60 ^ 2 + minuten * 60 + sekunden
FOR time = time TO 0 STEP -1: IF INKEY$ = CHR$(27) THEN END
SLEEP 1: CLS : LINE (100, 180)-(560, 260), 1, BF
LOCATE 14, 31: PRINT "  "; time; "       "
LOCATE 14, 39: PRINT "     Sekunden  ": SOUND 1500, 1
NEXT time
DO
SOUND 1500, 14: SLEEP 1
LOOP UNTIL INKEY$ = CHR$(27)

END SUB

SUB wecker
'Uhrzeit-Alarm
SCREEN 12: CLS
PRINT ""
PRINT ""
PRINT ""
LOCATE , 28
PRINT "AKTUELLE ZEIT:"; TIME$
PRINT ""
PRINT ""
LINE (125, 135)-(495, 170), 15, BF
LINE (125, 170)-(495, 200), 1, BF
COLOR 15
LOCATE 10, 20
PRINT "Alarm Zeit eingeben (Format:hh:mm:ss):"
COLOR 1
LOCATE 12, 34
INPUT "", n$
CLS
DO
SLEEP 1: CLS
LINE (165, 180)-(495, 270), 1, BF
LOCATE 13, 30
PRINT " AKTUELLE ZEIT:   "; TIME$; " "
PRINT ""
LOCATE 16, 30
PRINT " ALARM    ZEIT:   "; n$; " "
IF TIME$ = n$ THEN GOTO snd
LOOP UNTIL INKEY$ = CHR$(27): GOTO nd

snd:
DO
CLS
LINE (165, 180)-(495, 250), 1, BF
LOCATE 14, 32: PRINT "!!!!!!!!!!!!!!!!!!!!!"
SOUND 1000, 14: SLEEP 1
LOOP UNTIL INKEY$ = CHR$(27)

nd:
END SUB

