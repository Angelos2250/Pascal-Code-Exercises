PROGRAM RLE;

  Type
    FileMode = (input,output);
    cmode = (compressmode,decompressmode);

  VAR
    compressionMode: cmode;

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

Function Compress(text: STRING): STRING;
    VAR
      compressedText: STRING;
      count: INTEGER;
      countStr: STRING;
      i: INTEGER;
      prev: CHAR;
  BEGIN (* Compress *)
      compressedText := '';
      count := 0;
      FOR i := 1 TO Length(text)+1 DO BEGIN//man geht ja immer von prev aus, daher bis Length+1
        IF (i > 1) THEN BEGIN
          prev := text[i - 1];
        END; (* IF *)
        IF (i = 1) OR (prev = text[i]) THEN BEGIN
          Inc(count);
        END ELSE BEGIN
          IF (count = 1) THEN BEGIN
            compressedText := compressedText + prev;  
          END ELSE IF (count = 2) THEN BEGIN
            compressedText := compressedText + prev + prev;
          END ELSE BEGIN
            (* convert count *)
            Str(count, countStr);
            compressedText := compressedText + prev + countStr;
          END; (* IF *)
          count := 1;
        END; (* IF *)
      END; (* FOR *)
      Compress := compressedText;
  END; (* Compress *)

  FUNCTION IsNumeric(c: CHAR): BOOLEAN;
  BEGIN (* IsNumeric *)
    IsNumeric := (Ord(c) >= 48) AND (Ord(c) <= 57);
  END; (* IsNumeric *)

  Function Decompress(text: STRING): STRING;
    VAR
      textLength : INTEGER;
      temp, decompressedText: STRING;
      count: INTEGER;
      i,j,k: INTEGER;
      prev: CHAR;
  BEGIN (* Decompress *)
      text := text + '#';
      textLength := Length(text);
      temp := '';
      decompressedText := '';
      count := 0;
      k:=1;
      FOR i := 2 TO textLength DO BEGIN
        prev := text[i - 1];
        IF (IsNumeric(text[i])) THEN BEGIN
          Val(text[i],count);
          Delete(text,i,1);
          FOR j := 1 TO count DO BEGIN
            temp := temp + prev;
          END; (* FOR *)
        END ELSE BEGIN
          temp := temp + prev;
        END; (* IF *)
      END; (* FOR *)
      WHILE temp[k] <> '#' DO BEGIN
        decompressedText := decompressedText + temp[k];
        Inc(k);
      END;
      Decompress := decompressedText;
  END; (* Decompress *)


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
  BEGIN
    WriteLn('Usage: RLE [ -c | -d ] [input | input output]');
    HALT;
  END;

  PROCEDURE CheckCmode(cliIndex : INTEGER);
  VAR
    mode: STRING;
  BEGIN (* CheckCmode *)
    IF (ParamCount >= cliIndex) THEN BEGIN
      mode := ParamStr(cliIndex);
      IF (mode = '-c') THEN BEGIN
        compressionMode := compressmode;
      END ELSE IF (mode = '-d') THEN BEGIN
        compressionMode := decompressmode;
      END ELSE BEGIN
        InvalidParams;
      END;
    END ELSE BEGIN
      WriteLn('choose a mode >');
      ReadLn(mode);
      IF (mode = '-c') THEN BEGIN
        compressionMode := compressmode;
      END ELSE IF (mode = '-d') THEN BEGIN
        compressionMode := decompressmode;
      END ELSE BEGIN
        InvalidParams;
      END;
    END;
  END; (* CheckCmode *)

  PROCEDURE CompressDecompress(VAR inputfile,outputFile: TEXT; line: STRING);
  BEGIN (* CompressDecompress *)
    IF (compressionmode = decompressmode) THEN BEGIN
    WHILE (NOT EOF(inputFile)) DO BEGIN
      ReadLn(inputFile, line);
      WriteLn(outputFile, Decompress(line));
    END; (* WHILE *)
  END; (* IF *)
  IF (compressionmode = compressmode) THEN BEGIN
    WHILE (NOT EOF(inputFile)) DO BEGIN
      ReadLn(inputFile, line);
      WriteLn(outputFile, compress(line));
    END; (* WHILE *)
  END; (* IF *)
  END; (* CompressDecompress *)

  VAR
    line: STRING;
    inputFile, outputFile: TEXT;

BEGIN (* RLE *)
  line:= '';
  CheckCmode(1);
  OpenTextFile(inputFile,2 , input);
  OpenTextFile(outputFile,3 , output);

  CompressDecompress(inputFile,outputFile,line);
  
  CloseTextFile(inputFile);
  CloseTextFile(outputFile);
  WriteLn('DONE');
END. (* RLE *)