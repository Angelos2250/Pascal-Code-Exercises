(*$B+*)
PROGRAM SeqSearch;

TYPE IntArray = ARRAY[1..3] OF INTEGER;

FUNCTION IsElement(a: ARRAY OF INTEGER; x: INTEGER): BOOLEAN;
VAR
  i: INTEGER;
BEGIN
  i := Low(a);
  FOR i := LOW(a) TO HIGH(a) DO BEGIN
    IF (a[i] <> x) THEN BEGIN
     i := i + 1;
    END; 
  END; (* WHILE *)
  IsElement := (i <= High(a));
END; (* IsElement *)

VAR
arr : IntArray; 
BEGIN
  arr[1] := 1;
  arr[2] := 2;
  arr[3] := 3;
  WriteLn(IsElement(arr, 3));
  WriteLn(IsElement(arr, 4));
END.