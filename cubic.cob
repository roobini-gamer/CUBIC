       IDENTIFICATION DIVISION.
       PROGRAM-ID. UNIT-CONVERTER.
       AUTHOR. ROOBINI HAMZA.
      *> CUBIC - COBOL UNIVERSAL BASE INTERACTIVE CONVERTER

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-EXIT-FLAG               PIC X VALUE 'Y'.
          88 EXIT-PROGRAM             VALUE 'N'.
          88 CONTINUE-PROGRAM         VALUE 'Y'.

       01 WS-ERROR                    PIC X(30) VALUE SPACES.
       01 WS-CATEGORY                 PIC 9.
       01 WS-FROM-UNIT                PIC 99.
       01 WS-TO-UNIT                  PIC 99.

      *> MAX PRECISION INTERNAL MATH VARIABLES
       01 WS-INPUT-VALUE              PIC 9(9)V999999 VALUE ZEROES.
       01 WS-OUTPUT-RAW               PIC 9(9)V999999 VALUE ZEROES.
       01 WS-OUTPUT-DISPLAY           PIC -(9)9.999999.

       01 WS-TEMP-IN                  PIC S9(9)V999999 VALUE ZEROES.
       01 WS-TEMP-OUT                 PIC S9(9)V999999 VALUE ZEROES.

       01 WS-FROM-FACTOR              PIC 9(9)V999999999 VALUE ZEROES.
       01 WS-TO-FACTOR                PIC 9(9)V999999999 VALUE ZEROES.

       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM UNTIL EXIT-PROGRAM
               MOVE SPACES TO WS-ERROR
               MOVE ZEROES TO WS-INPUT-VALUE
               MOVE ZEROES TO WS-OUTPUT-RAW
               MOVE ZERO  TO WS-CATEGORY
               MOVE ZEROES TO WS-FROM-UNIT
               MOVE ZEROES TO WS-TO-UNIT

               PERFORM DISPLAY-HEADER
               PERFORM GET-CATEGORY

               IF WS-ERROR = SPACES
                   PERFORM DISPLAY-UNITS
                   PERFORM GET-UNITS
               END-IF

               IF WS-ERROR = SPACES
                   PERFORM GET-VALUE
               END-IF

               IF WS-ERROR = SPACES
                   PERFORM CONVERT-LOGIC
               END-IF

               IF WS-ERROR NOT = SPACES
                   DISPLAY WS-ERROR
               ELSE
                   MOVE WS-OUTPUT-RAW TO WS-OUTPUT-DISPLAY
                   DISPLAY "======================================="
                   DISPLAY "RESULT: " WS-OUTPUT-DISPLAY
                   DISPLAY "======================================="
               END-IF

               DISPLAY "CONVERT ANOTHER? (Y/N): "
                   WITH NO ADVANCING
               ACCEPT WS-EXIT-FLAG
           END-PERFORM
           STOP RUN.

       DISPLAY-HEADER.
           DISPLAY " "
           DISPLAY "======================================="
           DISPLAY " UNIVERSAL UNIT CONVERTER"
           DISPLAY "=======================================".

       GET-CATEGORY.
           DISPLAY "CATEGORIES:"
           DISPLAY "  1 - LENGTH"
           DISPLAY "  2 - TEMPERATURE"
           DISPLAY "  3 - AREA"
           DISPLAY "  4 - VOLUME"
           DISPLAY "  5 - WEIGHT"
           DISPLAY "  6 - TIME"
           DISPLAY "ENTER CATEGORY (1-6): " WITH NO ADVANCING
           ACCEPT WS-CATEGORY
           IF WS-CATEGORY < 1 OR WS-CATEGORY > 6
               MOVE "INVALID CATEGORY SELECTED" TO WS-ERROR
           END-IF.

       DISPLAY-UNITS.
           DISPLAY " "
           EVALUATE WS-CATEGORY
               WHEN 1
                   DISPLAY "LENGTH UNITS:"
                   DISPLAY "  01-MM  02-CM  03-M   04-KM"
                   DISPLAY "  05-IN  06-FT  07-YD  08-MI"
               WHEN 2
                   DISPLAY "TEMPERATURE UNITS:"
                   DISPLAY "  1-CELSIUS  2-FAHRENHEIT  3-KELVIN"
               WHEN 3
                   DISPLAY "AREA UNITS:"
                   DISPLAY "  01-SQMM  02-SQCM  03-SQM  04-SQKM"
                   DISPLAY "  05-SQIN  06-SQFT  07-SQYD  08-SQMI"
                   DISPLAY "  09-ACRE  10-HECTARE"
               WHEN 4
                   DISPLAY "VOLUME UNITS:"
                   DISPLAY "  01-ML    02-L     03-CBM"
                   DISPLAY "  04-FL OZ 05-CUP   06-PINT"
                   DISPLAY "  07-QT    08-GALLON"
               WHEN 5
                   DISPLAY "WEIGHT UNITS:"
                   DISPLAY "  1-MG   2-G    3-KG   4-MET TON"
                   DISPLAY "  5-OZ   6-LB"
               WHEN 6
                   DISPLAY "TIME UNITS:"
                   DISPLAY "  1-MS   2-SEC  3-MIN  4-HR"
                   DISPLAY "  5-DAY  6-WEEK"
           END-EVALUATE.

       GET-UNITS.
           DISPLAY "ENTER FROM UNIT NO: " WITH NO ADVANCING
           ACCEPT WS-FROM-UNIT
           DISPLAY "ENTER TO UNIT NO: " WITH NO ADVANCING
           ACCEPT WS-TO-UNIT.

       GET-VALUE.
           DISPLAY "ENTER VALUE: " WITH NO ADVANCING
           ACCEPT WS-INPUT-VALUE.

       CONVERT-LOGIC.
           EVALUATE WS-CATEGORY
               WHEN 1 PERFORM CONVERT-LENGTH
               WHEN 2 PERFORM CONVERT-TEMP
               WHEN 3 PERFORM CONVERT-AREA
               WHEN 4 PERFORM CONVERT-VOLUME
               WHEN 5 PERFORM CONVERT-WEIGHT
               WHEN 6 PERFORM CONVERT-TIME
           END-EVALUATE.

      *> LENGTH BASE = METERS (FEETS ARE FOR FREAKS) (1.0)
       CONVERT-LENGTH.
           MOVE ZEROES TO WS-FROM-FACTOR
           MOVE ZEROES TO WS-TO-FACTOR
           EVALUATE WS-FROM-UNIT
               WHEN 01 MOVE 0.001      TO WS-FROM-FACTOR
               WHEN 02 MOVE 0.01       TO WS-FROM-FACTOR
               WHEN 03 MOVE 1.0        TO WS-FROM-FACTOR
               WHEN 04 MOVE 1000       TO WS-FROM-FACTOR
               WHEN 05 MOVE 0.0254     TO WS-FROM-FACTOR
               WHEN 06 MOVE 0.3048     TO WS-FROM-FACTOR
               WHEN 07 MOVE 0.9144     TO WS-FROM-FACTOR
               WHEN 08 MOVE 1609.344   TO WS-FROM-FACTOR
               WHEN OTHER MOVE "INVALID FROM UNIT" TO WS-ERROR
           END-EVALUATE
           IF WS-ERROR = SPACES
               EVALUATE WS-TO-UNIT
                   WHEN 01 MOVE 0.001      TO WS-TO-FACTOR
                   WHEN 02 MOVE 0.01       TO WS-TO-FACTOR
                   WHEN 03 MOVE 1.0        TO WS-TO-FACTOR
                   WHEN 04 MOVE 1000       TO WS-TO-FACTOR
                   WHEN 05 MOVE 0.0254     TO WS-TO-FACTOR
                   WHEN 06 MOVE 0.3048     TO WS-TO-FACTOR
                   WHEN 07 MOVE 0.9144     TO WS-TO-FACTOR
                   WHEN 08 MOVE 1609.344   TO WS-TO-FACTOR
                   WHEN OTHER MOVE "INVALID TO UNIT" TO WS-ERROR
               END-EVALUATE
           END-IF
           IF WS-ERROR = SPACES
               COMPUTE WS-OUTPUT-RAW = WS-INPUT-VALUE *
                   (WS-FROM-FACTOR / WS-TO-FACTOR)
           END-IF.

      *> TEMPERATURE REQUIRES SPECIAL FORMULAS
       CONVERT-TEMP.
           EVALUATE WS-FROM-UNIT
               WHEN 1 MOVE WS-INPUT-VALUE TO WS-TEMP-IN
               WHEN 2 COMPUTE WS-TEMP-IN =
                   (WS-INPUT-VALUE - 32) * 5 / 9
               WHEN 3 COMPUTE WS-TEMP-IN =
                   WS-INPUT-VALUE - 273.15
               WHEN OTHER MOVE "INVALID FROM UNIT" TO WS-ERROR
           END-EVALUATE
           IF WS-ERROR = SPACES
               EVALUATE WS-TO-UNIT
                   WHEN 1 MOVE WS-TEMP-IN TO WS-TEMP-OUT
                   WHEN 2 COMPUTE WS-TEMP-OUT =
                       (WS-TEMP-IN * 9 / 5) + 32
                   WHEN 3 COMPUTE WS-TEMP-OUT =
                       WS-TEMP-IN + 273.15
                   WHEN OTHER MOVE "INVALID TO UNIT" TO WS-ERROR
               END-EVALUATE
           END-IF
           IF WS-ERROR = SPACES
               MOVE WS-TEMP-OUT TO WS-OUTPUT-RAW
           END-IF.

      *> AREA BASE = SQUARE METERS (1.0)
       CONVERT-AREA.
           MOVE ZEROES TO WS-FROM-FACTOR
           MOVE ZEROES TO WS-TO-FACTOR
           EVALUATE WS-FROM-UNIT
               WHEN 01 MOVE 0.000001   TO WS-FROM-FACTOR
               WHEN 02 MOVE 0.0001     TO WS-FROM-FACTOR
               WHEN 03 MOVE 1.0        TO WS-FROM-FACTOR
               WHEN 04 MOVE 1000000    TO WS-FROM-FACTOR
               WHEN 05 MOVE 0.00064516 TO WS-FROM-FACTOR
               WHEN 06 MOVE 0.09290304 TO WS-FROM-FACTOR
               WHEN 07 MOVE 0.83612736 TO WS-FROM-FACTOR
               WHEN 08 MOVE 2589988.11 TO WS-FROM-FACTOR
               WHEN 09 MOVE 4046.8564  TO WS-FROM-FACTOR
               WHEN 10 MOVE 10000      TO WS-FROM-FACTOR
               WHEN OTHER MOVE "INVALID FROM UNIT" TO WS-ERROR
           END-EVALUATE
           IF WS-ERROR = SPACES
               EVALUATE WS-TO-UNIT
                   WHEN 01 MOVE 0.000001   TO WS-TO-FACTOR
                   WHEN 02 MOVE 0.0001     TO WS-TO-FACTOR
                   WHEN 03 MOVE 1.0        TO WS-TO-FACTOR
                   WHEN 04 MOVE 1000000    TO WS-TO-FACTOR
                   WHEN 05 MOVE 0.00064516 TO WS-TO-FACTOR
                   WHEN 06 MOVE 0.09290304 TO WS-TO-FACTOR
                   WHEN 07 MOVE 0.83612736 TO WS-TO-FACTOR
                   WHEN 08 MOVE 2589988.11 TO WS-TO-FACTOR
                   WHEN 09 MOVE 4046.8564  TO WS-TO-FACTOR
                   WHEN 10 MOVE 10000      TO WS-TO-FACTOR
                   WHEN OTHER MOVE "INVALID TO UNIT" TO WS-ERROR
               END-EVALUATE
           END-IF
           IF WS-ERROR = SPACES
               COMPUTE WS-OUTPUT-RAW = WS-INPUT-VALUE *
                   (WS-FROM-FACTOR / WS-TO-FACTOR)
           END-IF.

      *> VOLUME BASE = LITERS (1.0)
       CONVERT-VOLUME.
           MOVE ZEROES TO WS-FROM-FACTOR
           MOVE ZEROES TO WS-TO-FACTOR
           EVALUATE WS-FROM-UNIT
               WHEN 01 MOVE 0.001      TO WS-FROM-FACTOR
               WHEN 02 MOVE 1.0        TO WS-FROM-FACTOR
               WHEN 03 MOVE 1000       TO WS-FROM-FACTOR
               WHEN 04 MOVE 0.0295735  TO WS-FROM-FACTOR
               WHEN 05 MOVE 0.236588   TO WS-FROM-FACTOR
               WHEN 06 MOVE 0.473176   TO WS-FROM-FACTOR
               WHEN 07 MOVE 0.946353   TO WS-FROM-FACTOR
               WHEN 08 MOVE 3.78541    TO WS-FROM-FACTOR
               WHEN OTHER MOVE "INVALID FROM UNIT" TO WS-ERROR
           END-EVALUATE
           IF WS-ERROR = SPACES
               EVALUATE WS-TO-UNIT
                   WHEN 01 MOVE 0.001      TO WS-TO-FACTOR
                   WHEN 02 MOVE 1.0        TO WS-TO-FACTOR
                   WHEN 03 MOVE 1000       TO WS-TO-FACTOR
                   WHEN 04 MOVE 0.0295735  TO WS-TO-FACTOR
                   WHEN 05 MOVE 0.236588   TO WS-TO-FACTOR
                   WHEN 06 MOVE 0.473176   TO WS-TO-FACTOR
                   WHEN 07 MOVE 0.946353   TO WS-TO-FACTOR
                   WHEN 08 MOVE 3.78541    TO WS-TO-FACTOR
                   WHEN OTHER MOVE "INVALID TO UNIT" TO WS-ERROR
               END-EVALUATE
           END-IF
           IF WS-ERROR = SPACES
               COMPUTE WS-OUTPUT-RAW = WS-INPUT-VALUE *
                   (WS-FROM-FACTOR / WS-TO-FACTOR)
           END-IF.

      *> WEIGHT BASE = KILOGRAMS (1.0)
       CONVERT-WEIGHT.
           MOVE ZEROES TO WS-FROM-FACTOR
           MOVE ZEROES TO WS-TO-FACTOR
           EVALUATE WS-FROM-UNIT
               WHEN 1 MOVE 0.000001   TO WS-FROM-FACTOR
               WHEN 2 MOVE 0.001      TO WS-FROM-FACTOR
               WHEN 3 MOVE 1.0        TO WS-FROM-FACTOR
               WHEN 4 MOVE 1000       TO WS-FROM-FACTOR
               WHEN 5 MOVE 0.0283495  TO WS-FROM-FACTOR
               WHEN 6 MOVE 0.453592   TO WS-FROM-FACTOR
               WHEN OTHER MOVE "INVALID FROM UNIT" TO WS-ERROR
           END-EVALUATE
           IF WS-ERROR = SPACES
               EVALUATE WS-TO-UNIT
                   WHEN 1 MOVE 0.000001   TO WS-TO-FACTOR
                   WHEN 2 MOVE 0.001      TO WS-TO-FACTOR
                   WHEN 3 MOVE 1.0        TO WS-TO-FACTOR
                   WHEN 4 MOVE 1000       TO WS-TO-FACTOR
                   WHEN 5 MOVE 0.0283495  TO WS-TO-FACTOR
                   WHEN 6 MOVE 0.453592   TO WS-TO-FACTOR
                   WHEN OTHER MOVE "INVALID TO UNIT" TO WS-ERROR
               END-EVALUATE
           END-IF
           IF WS-ERROR = SPACES
               COMPUTE WS-OUTPUT-RAW = WS-INPUT-VALUE *
                   (WS-FROM-FACTOR / WS-TO-FACTOR)
           END-IF.

      *> TIME BASE = SECONDS (1.0)
       CONVERT-TIME.
           MOVE ZEROES TO WS-FROM-FACTOR
           MOVE ZEROES TO WS-TO-FACTOR
           EVALUATE WS-FROM-UNIT
               WHEN 1 MOVE 0.001      TO WS-FROM-FACTOR
               WHEN 2 MOVE 1.0        TO WS-FROM-FACTOR
               WHEN 3 MOVE 60         TO WS-FROM-FACTOR
               WHEN 4 MOVE 3600       TO WS-FROM-FACTOR
               WHEN 5 MOVE 86400      TO WS-FROM-FACTOR
               WHEN 6 MOVE 604800     TO WS-FROM-FACTOR
               WHEN OTHER MOVE "INVALID FROM UNIT" TO WS-ERROR
           END-EVALUATE
           IF WS-ERROR = SPACES
               EVALUATE WS-TO-UNIT
                   WHEN 1 MOVE 0.001      TO WS-TO-FACTOR
                   WHEN 2 MOVE 1.0        TO WS-TO-FACTOR
                   WHEN 3 MOVE 60         TO WS-TO-FACTOR
                   WHEN 4 MOVE 3600       TO WS-TO-FACTOR
                   WHEN 5 MOVE 86400      TO WS-TO-FACTOR
                   WHEN 6 MOVE 604800     TO WS-TO-FACTOR
                   WHEN OTHER MOVE "INVALID TO UNIT" TO WS-ERROR
               END-EVALUATE
           END-IF
           IF WS-ERROR = SPACES
               COMPUTE WS-OUTPUT-RAW = WS-INPUT-VALUE *
                   (WS-FROM-FACTOR / WS-TO-FACTOR)
           END-IF.
