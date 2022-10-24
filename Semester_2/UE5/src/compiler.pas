PROGRAM ATGUe1;

  USES ModTree;

  CONST
    eofCh = Chr(0);
    spaceCh = ' ';

  TYPE
    Symbol = (errorSy,eofSy,
              plusSy, minusSy, timesSy, divSy,
              leftParSy, rightParSy,
              number);
    
    VAR
      line: STRING; //input = arithmetic expr
      ch: CHAR; // current char
      cnr: INTEGER; // char column number
      sy: Symbol; // current Symbol
      numberVal: INTEGER; // holds number value if sy = number
      success: BOOLEAN; // parsing successfull

  PROCEDURE NewCh;
  BEGIN (* NewCh *)
    IF (cnr < Length(line)) THEN BEGIN
      cnr := cnr + 1;
      ch := line[cnr];
    END ELSE BEGIN
      ch := eofCh;
    END;
  END; (* NewCh *)

  PROCEDURE NewSy;
  BEGIN (* NewSy *)
    WHILE (ch = spaceCh) OR (ch = Chr(9)) DO BEGIN
      NewCh;
    END; (* WHILE *)
    CASE ch OF
      eofCh:BEGIN
            sy :=eofSy;
          END;
      '+':BEGIN
            sy := plusSy; NewCh;
          END;
      '-':BEGIN
            sy := minusSy; NewCh;
          END;
      '*':BEGIN
            sy := timesSy; NewCh;
          END;
      '/':BEGIN
            sy := divSy; NewCh;
          END;
      '(':BEGIN
            sy := leftParSy; NewCh;
          END;
      ')':BEGIN
            sy := rightParSy; NewCh;
          END;
      '0'..'9': BEGIN
                  sy:= number;
                  numberVal := 0;
                  REPEAT
                    numberVal := numberVal * 10 + (Ord(ch) - Ord('0'));
                    NewCh;
                  UNTIL (ch < '0') OR (ch > '9'); (* REPEAT *)
                END;
      ELSE BEGIN
        sy := errorSy;
      END;
    END; (* CASE *)
  END; (* NewSy *)

  //PARSER

  FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;
  BEGIN (* SyIsNot *)
    success := (success) AND (expectedSy = sy);
    SyIsNot := NOT success;
  END; (* SyIsNot *)

  PROCEDURE S; FORWARD;
  PROCEDURE Expr(VAR e: NodePtr) FORWARD;
  PROCEDURE Term(VAR t: NodePtr) FORWARD;
  PROCEDURE Fact(VAR f: NodePtr) FORWARD;

  PROCEDURE S;
   VAR
    e: TreePtr;
  BEGIN (* S *)
    e := InitTree;
    Expr(e); IF NOT success THEN EXIT;
    NewSy;
    PrintTree(e); // SEM
    DisposeTree(e);
    IF (SyIsNot(eofSy)) THEN EXIT;
  END; (* S *)

  PROCEDURE Expr(VAR e: NodePtr); // Expr = Term { "+" Term | "-" Term } .
    VAR
      t: NodePtr;
  BEGIN (* Expr *)
    Term(t); IF NOT success THEN Exit;
    e := TreeOf(NewNode('Expr'), t, NIL);
    WHILE (sy = plusSy) OR (sy = minusSy) DO BEGIN
      CASE sy OF
        plusSy: BEGIN
                  NewSy; //Skip Operand
                  Term(t); IF NOT success THEN Exit; //Find next number
                  AppendSibling(e^.firstChild,NewNode('+'),t); //SEM
                END;
        minusSy: BEGIN
                  NewSy;//Skip Operand
                  Term(t); IF NOT success THEN Exit;//Find next number
                  AppendSibling(e^.firstChild,NewNode('+'),t); //SEM
                 END;
      END;
    END; (* WHILE *)

  END; (* Expr *)

  PROCEDURE Term(VAR t: NodePtr); // TERM = Fact {* Fact | / FAct}
    VAR f: NodePtr;
  BEGIN (* Tert *)
    Fact(f); IF NOT success THEN Exit;
    t := TreeOf(NewNode('Term'), f, NIL);
    WHILE (sy = timesSy) OR (sy = divSy) DO BEGIN
      CASE sy OF
        timesSy: BEGIN
                  NewSy;//Skip Operand
                  Fact(f); IF NOT success THEN Exit;//Find next number
                  AppendSibling(t^.firstChild,NewNode('*'),f); //SEM
                END;
        divSy: BEGIN
                  NewSy;//Skip Operand
                  Fact(f); IF NOT success THEN Exit;//Find next number
                  AppendSibling(t^.firstChild,NewNode('*'),f); //SEM
                 END;
      END;
    END; (* WHILE *)

  END; (* Tert *)

  PROCEDURE Fact(VAR f: NodePtr); // Fact = number | (Expr).
    VAR
      e: NodePtr;
      numberStr: STRING;
  BEGIN (* Fact *)
    CASE sy OF
      number: BEGIN
                Str(numberVal,numberStr);
                f := TreeOf(NewNode('Fact'),NewNode(numberStr),NIL); //SEM
                NewSy;
              END;
      leftParSy: BEGIN
                    f := TreeOf(NewNode('Fact'),NewNode('('),NIL);
                    NewSy;
                    Expr(e);
                    IF SyIsNot(rightParSy) THEN EXIT;
                    AppendSibling(f^.firstChild,e,NewNode(')'));
                 END;
      ELSE BEGIN
        success := FALSE;
      END;
    END;
  END; (* Fact *)
  //PARSER

BEGIN (* ATGUe1 *)
  Write('expr > ');
  ReadLn(line);
  cnr := 0;
  NewCh;
  NewSy;
  success := TRUE;
  S;
  IF (success) THEN BEGIN
    WriteLn('successfull')
  END ELSE BEGIN
    WriteLn('syntax error in: ', cnr);
  END;
END. (* ATGUe1 *)