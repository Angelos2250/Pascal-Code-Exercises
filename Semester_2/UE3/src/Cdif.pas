PROGRAM TextFilter;

  Type
    FileMode = (input,output);

  PROCEDURE CheckIOError(message : STRING);
    VAR 
      errorcode: INTEGER;
  BEGIN (* CheckIOError *)
    errorcode := IOResult;
    IF (errorcode <> 0) THEN BEGIN
      WriteLn('ERROR: ',message, ' (code: ', errorcode, ')');
      HALT;
    END; (* IF *)
  END; (* CheckIOError *)

  FUNCTION Cdif(line1,line2,ch: STRING): STRING;
  VAR
    i,j: INTEGER;
    line3: STRING;
  BEGIN (* Cdif *)
    line3 := '';
    i := 1;
    WHILE (i <> Length(line1)+1) AND (i <> Length(line2)+1) DO BEGIN
      IF (line1[i] = line2[i]) THEN BEGIN
        line3 := line3 + ch;
      END ELSE BEGIN
        line3 := line3 + line2[i];
      END;
      Inc(i);
    END; (* WHILE *)
    IF (i = Length(line1)+1) THEN BEGIN
      FOR j := i TO Length(line2) DO BEGIN
        line3 := line3 + line2[j];
      END; (* FOR *)
    END ELSE BEGIN
      FOR j := i TO Length(line1) DO BEGIN
        line3 := line3 + '?';
      END; (* FOR *)
    END;
    Cdif := line3;
  END; (* Cdif *)

  PROCEDURE OpenTextFile(VAR textfile: TEXT; cliIndex: INTEGER; mode: FileMode);
  VAR 
    filename: STRING;
  BEGIN (* OpenFile *)
    IF (ParamCount >= cliIndex) THEN BEGIN
      fileName := ParamStr(cliIndex);
    END ELSE BEGIN
      Write('enter ', mode,' file >');
      ReadLn(fileName);
    END;
    {$I-}
    Assign(textfile,filename);
    IF (mode = input) THEN BEGIN
      Reset(textfile);
    END ELSE BEGIN
      Rewrite(textfile);
    END;
    CheckIOError('Cannot open');
    {$I+}
  END; (* OpenFile *)

  PROCEDURE CloseTextFile(VAR textfile: TEXT);
  BEGIN (* CloseTextFile *)
    {$I-}
    Close(textfile);
    CheckIOError('Cannot close');
    {$I+}
  END; (* CloseTextFile *)

  PROCEDURE InvalidParams;
  (* prints a help text and quits *)
  BEGIN
    WriteLn('CDiff [-cch] inFile1 inFile2 outFile');
    HALT;
  END;

  PROCEDURE CheckCmode(cliIndex : INTEGER;c: STRING);
  BEGIN (* CheckCmode *)
    IF (ParamCount >= cliIndex) THEN BEGIN
      IF NOT(c='-c') THEN BEGIN
        InvalidParams;
        HALT;
      END;
    END ELSE BEGIN
      WriteLn('choose a mode >');
      ReadLn(c);
      IF NOT(c='-c') THEN BEGIN
        InvalidParams;
        HALT;
      END;
    END;
  END; (* CheckCmode *)

  PROCEDURE ChooseCh(cliIndex: INTEGER;VAR ch: STRING);
  BEGIN (* ChooseCh *)
    IF NOT (ParamCount >= cliIndex) THEN BEGIN
      WriteLn('choose a char >');
      ReadLn(ch);
    END;
    IF (ch = '') THEN BEGIN
      ch := ' ';
    END; (* IF *)
  END; (* ChooseCh *)

  VAR
    ch: STRING;
    line1,line2: STRING;
    File1, File2, File3: TEXT;


BEGIN (* TextFilter *)
  ch := ' ';
  CheckCmode(1,'-c');
  ChooseCh(2,ch);
  OpenTextFile(File1,3 , input);
  OpenTextFile(File2,4 , input);
  OpenTextFile(File3,5 , output);
  WHILE (NOT EOF(File2)) DO BEGIN
    ReadLn(File1, line1);
    ReadLn(File2, line2);
    WriteLn(File3, Cdif(line1,line2,ch));
  END; (* WHILE *)
  CloseTextFile(File1);
  CloseTextFile(File2);
  CloseTextFile(File3);
  WriteLn('DONE');
END. (* TextFilter *)