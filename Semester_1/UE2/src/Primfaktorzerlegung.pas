PROGRAM Primfaktorzerlegung;
VAR  n,x: INTEGER;
begin

  Write('Welche Zahl soll zerlegt werden? : ');
  Read(n);
  WriteLn('Primfaktoren : ');

  x := 2;//Primfaktor

  WHILE n <> 1 DO BEGIN // Solange n nicht 1

    if (n MOD x = 0) THEN BEGIN // n : x = Rest 0?
      n := n DIV x;
      Write(x, ' ');
      x := 2;
    END

    ELSE // Falls x, n nicht ohne Rest teilen kann dann x++
     Inc(x);

  END;

end.
