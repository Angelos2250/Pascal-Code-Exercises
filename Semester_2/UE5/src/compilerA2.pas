PROGRAM ATGUe2;

  USES ModTreeA2;

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

  PROCEDURE Expr(VAR e: NodePtr); FORWARD;
  PROCEDURE Term(VAR t: NodePtr); FORWARD;
  PROCEDURE Fact(VAR f: NodePtr); FORWARD;
  
  PROCEDURE InitParser;
  BEGIN (* InitParser *)
    success := TRUE;
    NewSy;
  END; (* InitParser *)

  PROCEDURE S;
    VAR
      t: TreePtr;
  BEGIN (* S *)
    Expr(t); IF NOT success THEN EXIT;
    IF sy <> eofSy THEN BEGIN success := FALSE; EXIT END;
    NewSy;
    (* SEM *)
    WriteLn('In-Order:');PrintInOrder(t);WriteLn;
    WriteLn('Pre-Order:');PrintPreOrder(t);WriteLn;
    WriteLn('Post-Order:');PrintPostOrder(t);WriteLn;
    WriteLn('Value of: ', ValueOf(t));
    DisposeTree(t);
    (* ENDSEM *)
  END; (* S *)
  
  (* Expr -> Term { '+' Term | '-' Term }. *)
  PROCEDURE Expr(VAR e: NodePtr);
    VAR
      t: NodePtr;
  BEGIN (* Expr *)
    Term(e); IF NOT success THEN EXIT;
    WHILE (sy = plusSy) OR (sy = minusSy) DO BEGIN
      CASE sy OF
        plusSy: BEGIN
          NewSy; (* skip + *)
          Term(t); IF NOT success THEN EXIT;
          (* SEM *)
          e := TreeOf(NewNode('+'), e, t);
          (* ENDSEM *)
        END;
        minusSy: BEGIN
          NewSy; (* skip - *)
          Term(t); If NOT success THEN EXIT;
          (* SEM *)
          e := TreeOf(NewNode('-'), e, t);
          (* ENDSEM *)
        END;
      END; (* CASE *)
    END; (* WHILE *)
  END; (* Expr *)

  (* Term -> Fact { '*' Fact | '/' Fact }. *)
  PROCEDURE Term(VAR t: NodePtr);
    VAR
      f: NodePtr;
  BEGIN (* Term *)
    Fact(t); IF NOT success THEN EXIT;
    WHILE (sy = timesSy) OR (sy = divSy) DO BEGIN
      CASE sy OF
        timesSy: BEGIN
          NewSy; (* skip * *)
          Fact(f); IF NOT success THEN EXIT;
          (* SEM *)
          t := TreeOf(NewNode('*'), t, f);
          (* ENDSEM *)
        END;
        divSy: BEGIN
          NewSy; (* skip / *)
          Fact(f); If NOT success THEN EXIT;
          (* SEM *)
          t := TreeOf(NewNode('/'), t, f);
          (* ENDSEM *)
        END;
      END; (* CASE *)
    END; (* WHILE *)
  END; (* Term *)

  PROCEDURE Fact(VAR f: NodePtr);
    VAR
      e: NodePtr;
      numberStr: STRING;
  BEGIN (* Fact *)
    CASE sy OF
      number: BEGIN
        (* SEM *)
        Str(numberVal, numberStr);
        f := NewNode(numberStr);
        (* END SEM *)
        NewSy;
      END;
      leftParSy: BEGIN
                  NewSy; (* skip '(' *)
                  Expr(e); IF NOT success THEN EXIT;
                  IF (sy <> rightParSy) THEN BEGIN
                    success := FALSE;
                    EXIT;
                  END; (* IF *)
                  f := e;
                  NewSy;
                 END;
      ELSE BEGIN
        success := FALSE;
        EXIT;
      END;
    END; (* CASE *)
  END; (* Fact *)

  
  //PARSER


BEGIN (* ATGUe2 *)
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
END. (* ATGUe2 *)