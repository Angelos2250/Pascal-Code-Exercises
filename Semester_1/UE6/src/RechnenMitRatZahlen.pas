PROGRAM ratZahlen;

TYPE 
Rational= RECORD                  (*     numerator     *)
  num, denom: INTEGER;            (*    -----------    *)
END; (*RECORD*)                   (*    denominator    *)

PROCEDURE ReadInput(VAR RatZahl : Rational);
BEGIN
  WriteLn('Bitte Zaehler eingeben');
  ReadLn(RatZahl.num);
  WriteLn('Bitte Nenner eingeben');
  ReadLn(RatZahl.denom);
  IF RatZahl.denom = 0 THEN BEGIN
    WriteLn('error');
    Halt;
  END ELSE IF RatZahl.denom < 0 THEN BEGIN
    RatZahl.denom := Abs(RatZahl.denom);
    RatZahl.num := - RatZahl.num;
  END;
END;

PROCEDURE Kuerzen(VAR c : RATIONAL);
VAR
i,Highest,Smallest : INTEGER;
BEGIN
IF c.num >= c.denom THEN BEGIN
  Highest := c.num;
  Smallest := c.denom;
END
ELSE
begin
  Highest := c.denom;
  Smallest := c.num;
end;
  FOR i := Highest DOWNTO 0 DO BEGIN
    IF (Highest MOD i = 0) AND (Smallest MOD i = 0) THEN BEGIN
      c.num := c.num DIV i;
      c.denom := c.denom DIV i;
      EXIT;
    END;
  END; 
END;

PROCEDURE RatSum(a,b : Rational; VAR c : RATIONAL);
BEGIN
  c.num := (b.denom * a.num) + (a.denom * b.num);
  c.denom := a.denom * b.denom;
  Kuerzen(c);
END;

PROCEDURE RatDif(a,b : Rational; VAR c : RATIONAL);
BEGIN
  c.num := (b.denom * a.num) - (a.denom * b.num);
  c.denom := a.denom * b.denom;
  Kuerzen(c);
END;

PROCEDURE RatDiv(a,b : Rational; VAR c : RATIONAL);
BEGIN
 c.num := a.num * b.denom;
 c.denom := a.denom * b.num;
 IF c.denom = 0 THEN BEGIN
  WriteLn('error');
  Halt;
 END;
 Kuerzen(c);
END;

PROCEDURE RatPro(a,b : Rational; VAR c : RATIONAL);
BEGIN
 c.num := a.num * b.num;
 c.denom := a.denom * b.denom;
 Kuerzen(c);
END;

PROCEDURE WriteRecord(a:Rational);
BEGIN
  Write(a.num,'/',a.denom,' ');
END;

VAR
RatZahl1 : Rational;
RatZahl2 : Rational;
RatErg: Rational;
BEGIN
ReadInput(RatZahl1);
ReadInput(RatZahl2);

WriteLn('Summieren von: ');
WriteRecord(RatZahl1);
WriteRecord(RatZahl2);
RatSum(RatZahl1,RatZahl2,RatErg);
Write('Ergebniss: ');
WriteRecord(RatErg);
WriteLn;
WriteLn;

WriteLn('Subtrahieren von: ');
WriteRecord(RatZahl1);
WriteRecord(RatZahl2);
RatDif(RatZahl1,RatZahl2,RatErg);
Write('Ergebniss: ');
WriteRecord(RatErg);
WriteLn;
WriteLn;

WriteLn('Multiplizieren von: ');
WriteRecord(RatZahl1);
WriteRecord(RatZahl2);
RatPro(RatZahl1,RatZahl2,RatErg);
Write('Ergebniss: ');
WriteRecord(RatErg);
WriteLn;
WriteLn;

WriteLn('Dividieren von: ');
WriteRecord(RatZahl1);
WriteRecord(RatZahl2);
RatDiv(RatZahl1,RatZahl2,RatErg);
Write('Ergebniss: ');
WriteRecord(RatErg);
END.