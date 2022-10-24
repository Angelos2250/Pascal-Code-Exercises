PROGRAM MPC;
  USES
    MPScanner, MPI, CodeDef, CodeGen, CodeInt;
  
  VAR
    inputFilePath: STRING;
    ca: CodeArray;
    ok: BOOLEAN;
 
BEGIN (* MPC *)
  IF (ParamCount = 1) THEN BEGIN
    inputFilePath := ParamStr(1);
  END ELSE BEGIN
    Write('MidiPascal source file > ');
    ReadLn(inputFilePath);
  END; (* IF *)

  InitLex(inputFilePath);

  S;

  IF (success) THEN BEGIN
    WriteLn('parsing completed: success');
    GetCode(ca);
    StoreCode(inputFilePath + 'c', ca);
    
    LoadCode(inputFilePath + 'c', ca, ok);
    IF (NOT ok) THEN BEGIN
      WriteLn('ERROR: cannot open mpc file');
      HALT;
    END; (* IF *)
    InterpretCode(ca);
  END ELSE BEGIN
    WriteLn('parsing failed. ERROR at position (', syLineNr, ',', syColNr, ', ', sy, ')');
  END; (* IF *)
END. (* MPC *)