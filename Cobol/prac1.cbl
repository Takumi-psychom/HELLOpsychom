      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. prac1.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.

       01 i BINARY-LONG.
       01 total BINARY-LONG.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

            PERFORM VARYING i
               FROM 1 BY 1 UNTIL i > 6
                   ADD i TO total
            END-PERFORM.
            DISPLAY"THE TOTAL IS" total.

            STOP RUN.
       END PROGRAM prac1.
