PROGRAM Namenskonvertierung;

CONST
CapitalToLower = 32;

PROCEDURE CToPascal(VAR s :String);
VAR
i,LowerChar :INTEGER;
BEGIN
  FOR i := 1 TO Length(s) DO BEGIN
    IF s[i] = '_' THEN BEGIN
      IF s[i+1] = '_' THEN BEGIN
       Delete(s,i,1);
       Dec(i)
      END
      Else BEGIN
      LowerChar := Ord(s[i+1])-CapitalToLower;
      Delete(s,i,2);
      Insert(CHAR(Ord(LowerChar)),s,i)
      END;
    END;
  END;
END;

VAR
s : STRING;
BEGIN
WriteLn('Bitte C Bezeichner eingeben um ihn auf die Pascal-Schreibweise zu konvertieren');
Read(s);
CToPascal(s);
WriteLn('Pascal Konvertierung: ',s);
END.