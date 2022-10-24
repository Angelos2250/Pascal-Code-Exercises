UNIT ModVectorObj;

INTERFACE

  TYPE 
    data = ARRAY [1..1] OF INTEGER;
    VectorPtr = ^Vector;
    Vector = OBJECT
      PUBLIC
        CONSTRUCTOR Init(Capacity: INTEGER);
        PROCEDURE WriteV;
        PROCEDURE Add(val:INTEGER);
        FUNCTION Size: INTEGER;
        PROCEDURE InsertElementAt(pos: INTEGER; val: INTEGER; VAR ok: BOOLEAN);
        PROCEDURE GetElementAt(pos: INTEGER; VAR val: INTEGER; VAR ok: BOOLEAN);
        PROCEDURE Clear;
        FUNCTION Capacity: INTEGER;
      PRIVATE
        VCap: INTEGER;
        DataPtr: ^data;
    END;

IMPLEMENTATION

  CONSTRUCTOR Vector.Init(Capacity: INTEGER);
    VAR
      i: INTEGER;
  BEGIN
    GetMem(DataPtr,(Capacity+1) * SizeOf(INTEGER));
    SELF.VCap := Capacity;
    {$R-}
    FOR i := 1 TO SELF.VCap DO BEGIN
      SELF.DataPtr^[i] := 0;
    END; (* FOR *)
    {$R+}
  END;

  PROCEDURE Vector.WriteV;
    VAR
      i: INTEGER;
  BEGIN (* WriteV *)
    {$R-}
    FOR i := 1 TO SELF.VCap DO BEGIN
      WriteLn(i,': ',SELF.DataPtr^[i])
    END; (* FOR *)
    {$R+}
  END; (* WriteV *)

  PROCEDURE Vector.Add(val:INTEGER);
    VAR
     i: INTEGER;
  BEGIN
    i := 1;
    {$R-}
    WHILE (SELF.DataPtr^[i] <> 0) AND (i <= SELF.VCap) DO BEGIN
      Inc(i);
    END; (* WHILE *)
    {$R+}
    IF (i > SELF.VCap) THEN BEGIN
      WriteLn('No more Space!');
      HALT;
    END ELSE BEGIN
      {$R-}
      SELF.DataPtr^[i] := val;
      {$R+}
    END;
  END;

  FUNCTION Vector.Size: INTEGER;
    VAR
      i,count: INTEGER;
  BEGIN (* Size *)
    i := 1;
    count := 0;
    {$R-}
    WHILE (DataPtr^[i] <> 0) AND (i <> VCap)DO BEGIN
      Inc(count);
      Inc(i);
    END; (* WHILE *)
    {$R+}
    Size := count;
  END; (* Size *)

  PROCEDURE Vector.InsertElementAt(pos: INTEGER; val: INTEGER; VAR ok: BOOLEAN);
    VAR
      j,i, prev, next: INTEGER;
  BEGIN
    i := 1;
    j := pos;
    {$R-}
    WHILE (DataPtr^[i] = 0) AND (i <= VCap)DO BEGIN
      Inc(i);
    END; (* WHILE *)
    IF (i >= VCap) THEN BEGIN
      ok := FALSE;
    END ELSE IF (pos <= 0) THEN BEGIN
      j := 1;
      ok := TRUE;
      prev :=  DataPtr^[j];
      DataPtr^[j] := val;
      WHILE (DataPtr^[j+1] <> 0) DO BEGIN
        next := DataPtr^[j+1];
        DataPtr^[j+1] := prev;
        Inc(j);
        prev := next;
      END; (* WHILE *)
    END ELSE IF (pos > SELF.Size) THEN BEGIN
      ok := TRUE;
      Add(val);
    END ELSE BEGIN
      ok := TRUE;
      prev :=  DataPtr^[j];
      DataPtr^[j] := val;
      WHILE (DataPtr^[j+1] <> 0) DO BEGIN
        next := DataPtr^[j+1];
        DataPtr^[j+1] := prev;
        Inc(j);
        prev := next;
      END; (* WHILE *)
    END;
    {$R+}
  END;

  PROCEDURE Vector.GetElementAt(pos: INTEGER; VAR val: INTEGER; VAR ok: BOOLEAN);
  BEGIN
    {$R-}
    IF (pos > VCap) OR (pos < 1)THEN BEGIN
      ok := FALSE;
    END ELSE BEGIN
      ok := TRUE;
      val := DataPtr^[pos];  
    END; 
    {$R+}
  END;

  PROCEDURE Vector.Clear;
    VAR
      i,curSize: INTEGER;
  BEGIN
    curSize := SELF.Size;
    {$R-}
    FOR i := 1 TO curSize DO BEGIN
      DataPtr^[i] := 0;
    END; (* FOR *)
    {$R+}
  END;

  FUNCTION Vector.Capacity: INTEGER;
  BEGIN
    Capacity := VCap;
  END;

BEGIN (* ModVectorObj *)
  
END. (* ModVectorObj *)