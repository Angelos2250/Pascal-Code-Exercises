PROGRAM varianz;
TYPE
RealArray = ARRAY[1..100] OF REAL;
VAR
Eingabe,s : String;
n,summe, quotient : REAL;
zahlenFolge : RealArray;
i,j,total : INTEGER;

BEGIN
  Read(n);
  Str(n:7:3,s);
  Eingabe := Concat(s, ' ');

  i := 1;
  summe := 0;
  total := 0;
  quotient := 0;

  while n <> 0 do BEGIN
    zahlenFolge[i] := n;
    summe := summe + n;
    Inc(i);
    Inc(total);
    Read(n);

    Str(n:7:3,s); // Convert n to String and save it to s (Dient nur zur Darstellung)
    Eingabe := Concat(Eingabe, s, ' '); //Verkette Eingabe, s und ' ' in Eingabe (Dient nur zur Darstellung)
  END;
  
  FOR j := 1 TO total DO BEGIN
    quotient := quotient + Sqr(zahlenFolge[j] - (summe / total));
  END;

  WriteLn('Eingabe: ', Eingabe);
  WriteLn('Average : ', (summe / total):7:3);
  WriteLn('Varianz : ', (quotient / (total - 1)):7:3)
END.