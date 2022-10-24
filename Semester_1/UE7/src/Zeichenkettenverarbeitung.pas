PROGRAM Zeichenkettenverarbeitung;

FUNCTION Reversed(s : STRING) :STRING;
var
  i: Integer;
BEGIN
  for i := 1 to Length(s) do
    Reversed[i] := s [Length(s) - i +1];
END;

PROCEDURE StripBlanks(VAR s : STRING);
VAR 
blank : CHAR;
i : INTEGER;
BEGIN
  blank := CHAR(32);
  FOR i := 1 TO Length(s) DO BEGIN
    IF s[i] = blank THEN BEGIN
      Delete(s,i,1);
      Dec(i);
    END;  
  END;
END;

PROCEDURE ReplaceAll(old,new : STRING; VAR s : STRING);
VAR
i,PosOld : INTEGER;
BEGIN
  WHILE Pos(old,s) <> 0 DO BEGIN
    PosOld := Pos(old,s);
    Delete(s,PosOld,Length(old));
    Insert(new,s,PosOld);
  END;
END;

VAR
s,saveS,old,new : STRING;
i : INTEGER;
BEGIN
  WriteLn('Welcher String soll verarbeiet werden?');
  ReadLn(s);
  saveS := s;
  WriteLn(Reversed(s));
  
  WriteLn;

  StripBlanks(s);
  WriteLn(s);
  
  WriteLn;

  s := saveS;
  WriteLn(' Bitte String eingeben das ersetzt werden soll');
  ReadLn(old);
  WriteLn(' Bitte String eingeben mit dem das Wort ersetzt werden soll');
  ReadLn(new);
  ReplaceAll(old,new,s);
  WriteLn(s);

END.