UNIT VectorADT;

INTERFACE
  
  TYPE
    Vector = Pointer;

  PROCEDURE Assert(cond: BOOLEAN; msg: STRING); 
  FUNCTION NewVector(size: INTEGER): Vector;
  PROCEDURE InitVector(VAR v: Vector);
  PROCEDURE DoubleSize(VAR v: Vector);
  PROCEDURE Add(VAR v: Vector; val: INTEGER);
  PROCEDURE SetElementAt(v: Vector; pos: INTEGER; val: INTEGER);
  FUNCTION ElementAt(v: Vector; pos: INTEGER): INTEGER;
  PROCEDURE RemoveElementAt(v: Vector; pos: INTEGER);
  FUNCTION Size(v: Vector): INTEGER;
  FUNCTION Capacity(v: Vector): INTEGER;
  PROCEDURE WriteVector(v: Vector);


IMPLEMENTATION

  TYPE
    VPtr = ^VRec;
    VRec = RECORD
      Vsize: INTEGER;
      data: ARRAY [1..1] OF INTEGER;
    END;

  PROCEDURE Assert(cond: BOOLEAN;msg: STRING);
  BEGIN (* Asser *)
    IF (cond) THEN BEGIN
      WriteLn('ERROR: assertion failed - ', msg);
      HALT;
    END;
  END; (* Asser *)

  FUNCTION NewVector(size: INTEGER): Vector;
    VAR
      v : VPtr;
  BEGIN (* NewVector *)
    GetMem(v,(size+1) * SizeOf(INTEGER));
    VPtr(v)^.Vsize := size;
    InitVector(v);
    NewVector := v;
  END; (* NewVector *)

  PROCEDURE InitVector(VAR v: Vector);
  VAR
    i: INTEGER;
  BEGIN (* InitVector *)
    {$R-}
    FOR i := 1 TO VPtr(v)^.Vsize DO BEGIN
      VPtr(v)^.data[i] := 0;
    END; (* FOR *)
    {$R+}
  END; (* InitVector *)

  PROCEDURE DoubleSize(VAR v: Vector);
  VAR
    newVPtr : Vector;
    i,j,prevSize,currentSize: INTEGER;
  BEGIN (* DoubleSize *)
    prevSize := VPtr(v)^.Vsize;
    currentSize := prevSize * 2;
    newVPtr := NewVector(currentSize);
    {$R-}
    FOR i := 1 TO currentSize DO BEGIN
      VPtr(newVPtr)^.data[i] := 0;
    END; (* FOR *)
    FOR j := 1 TO prevSize DO BEGIN
      VPtr(newVPtr)^.data[j] := VPtr(v)^.data[j];
    END; (* FOR *)
    {$R+}
    FreeMem(v, (preVsize+1) * SizeOf(INTEGER));
    GetMem(v, ((prevSize*2)+1) * SizeOf(INTEGER));
    v := newVPtr;
    //WriteLn(VPtr(v)^.Vsize);
  END; (* DoubleSize *)

  PROCEDURE Add(VAR v: Vector;val: INTEGER);
  VAR
    i: INTEGER;
  BEGIN
    i := 1;
    //WriteLn(VPtr(v)^.Vsize,' start ',val);
    {$R-}
    WHILE (VPtr(v)^.data[i] <> 0) AND (i <= VPtr(v)^.Vsize) DO BEGIN
      //WriteLn(VPtr(v)^.Vsize,' start ',val);
      Inc(i);
    END; (* WHILE *)
    {$R+}
    IF (i > VPtr(v)^.Vsize) THEN BEGIN
      //WriteLn('here: ',i);
      DoubleSize(v);
      //WriteLn(VPtr(v)^.Vsize);
      {$R-}
      VPtr(v)^.data[i] := val;
      {$R+}
    END ELSE BEGIN
      {$R-}
      VPtr(v)^.data[i] := val;
      {$R+}
    END;
    //WriteLn(VPtr(v)^.Vsize);
  END;

  PROCEDURE SetElementAt(v: Vector;pos: INTEGER; val: INTEGER);
  BEGIN (* SetElementAt *)
    Assert((pos >= VPtr(v)^.Vsize),'Stack Overflow');
    {$R-}
    VPtr(v)^.data[pos] := val;
    {$R+}
  END; (* SetElementAt *)

  FUNCTION ElementAt(v: Vector;pos: INTEGER): INTEGER;
  BEGIN (* ElementAt *)
    Assert((pos >= VPtr(v)^.Vsize),'pos doesnt exist');
    ElementAt:= VPtr(v)^.data[pos];
  END; (* ElementAt *)

  PROCEDURE RemoveElementAt(v: Vector;pos:INTEGER);
    VAR
      i: INTEGER;
  BEGIN (* RemoveElementAt *)
    Assert((pos >= VPtr(v)^.Vsize),'pos doesnt exist');
    {$R-}
    VPtr(v)^.data[pos] := 0;
    FOR i := pos TO VPtr(v)^.Vsize DO BEGIN
      VPtr(v)^.data[i] := VPtr(v)^.data[i+1];
    END; (* FOR *)
    VPtr(v)^.data[VPtr(v)^.VSize] := 0;
    {$R+}
  END; (* RemoveElementAt *)

  FUNCTION Size(v: Vector): INTEGER;
    VAR
      i,count: INTEGER;
  BEGIN (* Size *)
    i := 1;
    count := 0;
    {$R-}
    WHILE (VPtr(v)^.data[i] <> 0) AND (i <> VPtr(v)^.Vsize)DO BEGIN
      Inc(count);
      Inc(i);
    END; (* WHILE *)
    {$R+}
    Size := count;
  END; (* Size *)

  FUNCTION Capacity(v: Vector): INTEGER;
  BEGIN (* Capacity *)
    Capacity := VPtr(v)^.Vsize;
  END; (* Capacity *)

  PROCEDURE WriteVector(v: Vector);
  VAR
    i: INTEGER;
  BEGIN (* WriteVector *)
    {$R-}
    FOR i := 1 TO VPtr(v)^.Vsize DO BEGIN
      WriteLn(i,': ',VPtr(v)^.data[i]);
    END; (* FOR *)
    {$R+}
  END; (* WriteVector *)


BEGIN
  WriteLn('Loaded VectorADS');
END.