      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. YOUR-PROGRAM-NAME.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT DDI1-F           ASSIGN  TO  DDI1.
           SELECT DDO1-F           ASSIGN  TO  DDO1.
           SELECT DDO2-F           ASSIGN  TO  DDO2.

       DATA DIVISION.
       FILE SECTION.
       FD  DDI1-F
       LABEL       RECORD    OMITTED
       RECORDING  MODE  IS  F.
       01  DDI1-REC.
         03  IN-SHOHIN-CODE    PIC  X(5).
         03  IN-KONYU-TENPO    PIC  X(5).
         03  IN-TANKA          PIC  S9(15).
         03  IN-KONYU-KOSU     PIC  S9(15).
         03  IN-DAIKIN         PIC  S9(15).
       FD  DDO1-F
       LABEL       RECORD   OMITTED
       RECORDING  MODE  IS  F.
       01  DDO1-REC.
         03  IN-SHOHIN-CODE    PIC  X(5).
         03  IN-KONYU-TENPO    PIC  X(5).
         03  IN-TANKA          PIC  S9(15).
         03  IN-KONYU-KOSU     PIC  S9(15).
         03  IN-DAIKIN         PIC  S9(15).

       FD  DDO2-F
       LABEL       RECORD   OMITTED
       RECORDING  MODE  IS  F.
       01  DDO2-REC.
         03  IN-SHOHIN-CODE    PIC  X(5).
         03  IN-KONYU-TENPO    PIC  X(5).
         03  IN-TANKA          PIC  S9(15).
         03  IN-KONYU-KOSU     PIC  S9(15).
         03  IN-DAIKIN         PIC  S9(15).
       WORKING-STORAGE   SECTION.

       01  FILLER              PIC  X(20)  VALUE 'CONSTANT-AREA'.

       01  CONSTANT-AREA.
         05  C-TSURUMI         PIC  X(05)  VALUE  '77777'.
         05  C-ON              PIC  X(01)  VALUE  '1'.
         05  C-OFF             PIC  X(01)  VALUE  '0'.

       01  FILLER              PIC  X(20)  VALUE 'WORK-AREA'.
       01  WORK-AREA.
         05  SW-EOF-FLG        PIC  X(01).

       PROCEDURE                          DIVISION.
       PROC                               SECTION.
           PERFORM  INIT-RTN.

           PERFORM  UNTIL  SW-EOF-FLG  =  C-ON
                    PERFORM  MAIN-RTN
           END-PERFORM.
           PERFORM  END-RTN.
           STOP RUN.

           PROC-EX.
               EXIT.
               EJECT.

       INIT-RTN                            SECTION.

           OPEN  INPUT  DDI1-F
                 OUTPUT DDO1-F
                        DDO2-F

           MOVE  C-OFF  TO  SW-EOF-FLG.

           INITIALIZE  DDO1-REC
                       DDO2-REC

           PERFORM  DDI1-F-READ-RTN.

           INIT-RTN-EX.
               EXIT.

       DDI1-F-READ-RTN                      SECTION.
           READ  DDI1-F
           AT  END
           MOVE  C-ON  TO  SW-EOF-FLG
           GO  TO  DDI1-F-READ-RTN-EX
           END-READ.
           DDI1-F-READ-RTN-EX.
           EXIT.
           EJECT.
       MAIN-RTN                 SECTION.

             PERFORM  FURIWAKE-RTN.
             PERFORM  DDI1-F-READ-RTN.

             MAIN-RTN-EX.
           EXIT.

       FURIWAKE-RTN             SECTION.
            WRITE DDO1-REC.
            WRITE DDO2-REC.

            RURIWAKE-RTN-EX.
           EXIT.

       END-RTN                  SECTION.
           CLOSE  DDI1-F
                  DDO1-F
                  DDO2-F.
           END-RTN-EX.
           EXIT.
           END PROGRAM YOUR-PROGRAM-NAME.
