PROGRAM Schachbrett;
VAR i,j,n,z,g : INTEGER;
begin
  WriteLn('Geben sie bitte die Groeße des Feldes an');
  ReadLn(n);

  IF (n < 1) OR (n > 9) THEN BEGIN
    WriteLn('Falsche Zahl eingegeben');
    WHILE TRUE DO BEGIN
    END;
  END;//Überprüfen ob n>9

  WriteLn;
  z:= 0;
  g:= 0;

  FOR i:=0 TO n DO BEGIN
    Write(g);
    Inc(g);//Y-Achse (Dient nur zur Darstellung)

    FOR j:=1 TO n DO BEGIN
      IF i = 0 THEN BEGIN
        Inc(z);
        Write(' ', z);
      END;//X-Achse (Dient nur zur Darstellung)
      IF (j > 0) AND (i > 0)THEN BEGIN //Kein X oder . auf der X Achse
        IF (i = j) OR (i + j = n + 1) THEN BEGIN //X 
          Write(' X');
        END 
        ELSE // .
          Write(' .')
      END;
    END;
    
    WriteLn;
  END;

end.
