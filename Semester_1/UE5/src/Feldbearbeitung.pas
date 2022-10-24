PROGRAM Feldbearbeitung;

TYPE
intarr = ARRAY[1..100] OF INTEGER;

PROCEDURE Initarr(n : INTEGER; VAR arr : ARRAY OF INTEGER);
VAR
i : INTEGER;
BEGIN
  i := LOW(arr);
  WHILE i <> n DO BEGIN
    Read(arr[i]);
    Inc(i);
  END;
END;

PROCEDURE Merge(a1:ARRAY OF INTEGER;n1: INTEGER;a2: ARRAY OF INTEGER; n2: INTEGER;VAR a3: ARRAY OF INTEGER; VAR n3:INTEGER);
VAR
i,j,k : INTEGER;
BEGIN
  n3 := n1 + n2;
  i:=0;
  j:=0;
  k:=0;
  WHILE (i < n1) AND (j < n2) DO BEGIN
    IF a1[i] <= a2[j] THEN BEGIN
      a3[k] := a1[i];
      Inc(k);
      Inc(i);
    END
    ELSE BEGIN
      a3[k] := a2[j];
      Inc(k);
      Inc(j);
    END;
  END;
  WHILE i < n1 DO BEGIN
    a3[k] := a1[i];
    Inc(i);
    Inc(k);
  END;
  WHILE j < n2 DO BEGIN
    a3[k] := a2[j];
    Inc(j);
    Inc(k);
  END;
END;

PROCEDURE WriteIntArray(yourArray : ARRAY OF INTEGER; n : INTEGER);
VAR
i : INTEGER;
BEGIN
  FOR i := LOW(yourArray) TO n-1 DO BEGIN
    Write(yourArray[i],' ');
  END;
END;

VAR
a1,a2,a3 :intarr;
n1,n2,n3 :INTEGER;
BEGIN
  WriteLn('wie gross ist das erste Feld?');
  Read(n1);
  WriteLn('Zahlen fuers erste Feld eingeben');
  Initarr(n1,a1);
  WriteLn('wie gross ist das zweite Feld?');
  Read(n2);
  WriteLn('Zahlen fuers zweite Feld eingeben');
  Initarr(n2,a2);
  Merge(a1,n1,a2,n2,a3,n3);
  WriteLn('output:');
  WriteIntArray(a3,n3);
END.