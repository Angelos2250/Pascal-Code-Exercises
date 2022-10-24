PROGRAM caesarChiffre;
TYPE
charArray = ARRAY[1..100] OF CHAR;
VAR 
str : STRING;
eingabe,ausgabe : charArray;
i,j,z,x,p : INTEGER;
BEGIN
  WriteLn(CHAR(Ord('A')+13));
  Read(str);
  for i := 1 to Length(str) do BEGIN
    eingabe[i] := str[i];
  END;
  ausgabe := eingabe;

  for j := 1 to Length(ausgabe) do BEGIN
    if ((Ord(ausgabe[j]) > 47) AND (Ord(ausgabe[j]) < 58)) OR (Ord(ausgabe[j]) = 32) THEN BEGIN
      ausgabe[j] := ausgabe[j];
    END;
    if ((Ord(ausgabe[j]) > 64) AND (Ord(ausgabe[j]) < 91)) then BEGIN
      if (Ord('Z') - Ord(ausgabe[j])) >= 13 THEN BEGIN
        ausgabe[j] := CHAR(Ord(ausgabe[j])+(13));
      END
      else if (Ord('Z') - Ord(ausgabe[j])) < 13 THEN BEGIN
        x := Ord('Z') - Ord(ausgabe[j]);
        ausgabe[j] := CHAR(Ord('A')+(12-x));
      END;//else if
    END;//if
  END;//for

  for z := 1 to Length(ausgabe) do BEGIN
    Write(ausgabe[z])
  END;
  WriteLn;
  (*n:= CHAR(65);
  WriteLn(CHAR(Ord(n)+1))*)
END.