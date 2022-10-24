UNIT QueueADS;

INTERFACE
  PROCEDURE InitQueue;
  PROCEDURE DoubleSize;
  FUNCTION IsEmpty : BOOLEAN;
  PROCEDURE Enque(val: INTEGER);
  FUNCTION GetLast: INTEGER;
  PROCEDURE Deque;
  PROCEDURE WriteQueue;

IMPLEMENTATION

  TYPE
    Queue = ARRAY [1..1] OF INTEGER;
  VAR
    size: INTEGER;
    QPtr: ^Queue;

  PROCEDURE InitQueue;
    VAR
      i: INTEGER;
  BEGIN (* InitQueue *)
    {$R-}
    FOR i := 1 TO size DO BEGIN
      QPtr^[i] := 0;
    END; (* FOR *)
    {$R+}
  END; (* InitQueue *)

  PROCEDURE DoubleSize;
  VAR
    newQPtr : ^Queue;
    i,j,prevSize: INTEGER;
  BEGIN (* DoubleSize *)
    prevSize := size;
    size := size*2;
    GetMem(newQPtr, size * SizeOf(INTEGER));
    {$R-}
    FOR i := 1 TO size DO BEGIN
      newQPtr^[i] := 0;
    END; (* FOR *)
    FOR j := 1 TO prevSize DO BEGIN
      newQPtr^[j] := QPtr^[j];
    END; (* FOR *)
    {$R+}
    FreeMem(QPtr, prevsize * SizeOf(INTEGER));
    GetMem(QPtr, size * SizeOf(INTEGER));
    QPtr := newQPtr;
  END; (* DoubleSize *)

  FUNCTION IsEmpty: BOOLEAN;
  BEGIN (* IsEmpty *)
    {$R-}
    IsEmpty := (QPtr^[1] = 0);
    {$R+}
  END; (* IsEmpty *)

  PROCEDURE Enque(val: INTEGER);
    VAR
      i,prev,temp: INTEGER;
  BEGIN (* Enque *)
    {$R-}
    prev := QPtr^[1];
    i := 2;
    WHILE (QPtr^[i] <> 0) AND (i <> size) DO BEGIN
      temp := QPtr^[i];
      QPtr^[i] := prev;
      prev := temp;
      Inc(i);
    END; (* WHILE *)
    IF (QPtr^[i] = 0) THEN BEGIN
      temp := QPtr^[i];
      QPtr^[i] := prev;
      prev := temp;
    END; 
    {$R+}
    IF (i = size) THEN BEGIN
      DoubleSize;
    END; (* IF *)
    {$R-}
    QPtr^[1] := val;
    {$R+}
  END; (* Enque *)

  FUNCTION GetLast: INTEGER;
    VAR
      i : INTEGER;
  BEGIN (* GetLast *)
    i := 1;
    {$R-}
    WHILE QPtr^[i] <> 0 DO BEGIN
      Inc(i);
    END;
    {$R+}
    GetLast := i;
  END; (* GetLast *)

  PROCEDURE Deque;
    VAR
      i,prev,temp: INTEGER;
  BEGIN (* Deque *)
    i := size-1;
    {$R-}
    prev := QPtr^[size];
    QPtr^[1] := 0;
    WHILE (i <> 1) DO BEGIN
      temp := QPtr^[i];
      QPtr^[i] := prev;
      prev := temp;
      Dec(i);
    END; (* WHILE *)
    QPtr^[1] := prev;
    {$R+}
  END; (* Deque *)

  PROCEDURE WriteQueue;
    VAR
      i : INTEGER;
  BEGIN (* WriteQueue *)
    {$R-}
    FOR i := 1 TO 20 DO BEGIN
      WriteLn(i,': ',QPtr^[i]);
    END; (* FOR *)
    {$R+}
  END; (* WriteQueue *)

BEGIN
size := 10;
GetMem(QPtr,size*SizeOf(INTEGER));
InitQueue;
WriteLn('Unit QueueADS Loaded');
END.