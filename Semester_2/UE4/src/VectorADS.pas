UNIT VectorADS;

INTERFACE

  PROCEDURE Assert(cond: BOOLEAN; msg: STRING); 
  PROCEDURE InitVector;
  PROCEDURE DoubleSize;
  PROCEDURE Add(val: INTEGER);
  PROCEDURE SetElementAt(pos: INTEGER; val: INTEGER);
  FUNCTION ElementAt(pos: INTEGER): INTEGER;
  PROCEDURE RemoveElementAt(pos: INTEGER);
  FUNCTION Size: INTEGER;
  FUNCTION Capacity: INTEGER;
  PROCEDURE WriteVector;


IMPLEMENTATION
  CONST
    startSize = 10;
  TYPE
    Vector = ARRAY [1..1] OF INTEGER;
  VAR
    Vsize: INTEGER;
    VPtr: ^Vector;

  PROCEDURE Assert(cond: BOOLEAN;msg: STRING);
  BEGIN (* Asser *)
    IF (cond) THEN BEGIN
      WriteLn('ERROR: assertion failed - ', msg);
      HALT;
    END;
  END; (* Asser *)

  PROCEDURE InitVector;
  VAR
    i: INTEGER;
  BEGIN (* InitVector *)
    {$R-}
    FOR i := 1 TO Vsize DO BEGIN
      VPtr^[i] := 0;
    END; (* FOR *)
    {$R+}
  END; (* InitVector *)

  PROCEDURE DoubleSize;
  VAR
    newVPtr : ^Vector;
    i,j,prevSize: INTEGER;
  BEGIN (* DoubleSize *)
    prevSize := VSize;
    Vsize := Vsize*2;
    GetMem(newVPtr, Vsize * SizeOf(INTEGER));
    {$R-}
    FOR i := 1 TO Vsize DO BEGIN
      newVPtr^[i] := 0;
    END; (* FOR *)
    FOR j := 1 TO prevSize DO BEGIN
      newVPtr^[j] := VPtr^[j];
    END; (* FOR *)
    {$R+}
    FreeMem(VPtr, preVsize * SizeOf(INTEGER));
    GetMem(VPtr, Vsize * SizeOf(INTEGER));
    VPtr := newVPtr;
  END; (* DoubleSize *)

  PROCEDURE Add(val: INTEGER);
  VAR
    i: INTEGER;
  BEGIN
    i := 1;
    {$R-}
    WHILE (VPtr^[i] <> 0) AND (i <= Vsize) DO BEGIN
      Inc(i);
    END; (* WHILE *)
    {$R+}
    IF (i > Vsize) THEN BEGIN
      DoubleSize;
      {$R-}
      VPtr^[i] := val;
      {$R+}
    END ELSE BEGIN
      {$R-}
      VPtr^[i] := val;
      {$R+}
    END;
  END;

  PROCEDURE SetElementAt(pos: INTEGER; val: INTEGER);
  BEGIN (* SetElementAt *)
    Assert((pos >= Vsize),'Stack Overflow');
    {$R-}
    VPtr^[pos] := val;
    {$R+}
  END; (* SetElementAt *)

  FUNCTION ElementAt(pos: INTEGER): INTEGER;
  BEGIN (* ElementAt *)
    Assert((pos >= Vsize),'pos doesnt exist');
    ElementAt:= VPtr^[pos];
  END; (* ElementAt *)

  PROCEDURE RemoveElementAt(pos:INTEGER);
    VAR
      i: INTEGER;
  BEGIN (* RemoveElementAt *)
    Assert((pos >= Vsize),'pos doesnt exist');
    {$R-}
    VPtr^[pos] := 0;
    FOR i := pos TO Vsize DO BEGIN
      VPtr^[i] := VPtr^[i+1];
    END; (* FOR *)
    VPtr^[VSize] := 0;
    {$R+}
  END; (* RemoveElementAt *)

  FUNCTION Size: INTEGER;
    VAR
      i,count: INTEGER;
  BEGIN (* Size *)
    i := 1;
    count := 0;
    {$R-}
    WHILE (VPtr^[i] <> 0) AND (i <> Vsize+1) DO BEGIN
      Inc(count);
      Inc(i);
    END; (* WHILE *)
    {$R+}
    Size := count;
  END; (* Size *)

  FUNCTION Capacity: INTEGER;
  BEGIN (* Capacity *)
    Capacity := Vsize;
  END; (* Capacity *)

  PROCEDURE WriteVector;
  VAR
    i: INTEGER;
  BEGIN (* WriteVector *)
    {$R-}
    FOR i := 1 TO Vsize DO BEGIN
      WriteLn(i,': ',VPtr^[i]);
    END; (* FOR *)
    {$R+}
  END; (* WriteVector *)


BEGIN
  Vsize := startSize;
  GetMem(VPtr, Vsize * SizeOf(INTEGER));
  InitVector;
  WriteLn('Loaded VectorADS');
END.