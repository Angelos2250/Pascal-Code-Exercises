PROGRAM balTree;

TYPE 
  NodePtr = ^Node;
  Node = RECORD
            value : INTEGER;
            left, right : NodePtr;
          END;
  Tree = NodePtr;
  DynIntArray = ARRAY[1..1] OF INTEGER;
  DynIntArrayPtr = ^DynIntArray;

PROCEDURE CopyBinTreeToDynArr(t : Tree;
                              arr : DynIntArrayPtr;
                              VAR pos : LONGINT);
BEGIN
  IF t <> NIL THEN BEGIN
    (* in-order traversal *)
    CopyBinTreeToDynArr(t^.left, arr, pos);
    (*$R-*) 
    arr^[pos] := t^.value;
    (*$R+*)
    Inc(pos);
    CopyBinTreeToDynArr(t^.right, arr, pos);
  END;
END;

FUNCTION NewNode(val : INTEGER) : NodePtr;
VAR n : NodePtr;
BEGIN
  New(n);
  n^.value := val;
  n^.left := NIL;
  n^.right := NIL;
  NewNode := n;
END;

PROCEDURE InsertSorted(v : INTEGER; VAR t : Tree);
BEGIN (* InsertSorted *)
  IF (t = NIL) THEN BEGIN
    t := NewNode(v);
  END ELSE IF (v > t^.value) THEN BEGIN
    InsertSorted(v,t^.right);
  END ELSE IF (v < t^.value) THEN BEGIN
    InsertSorted(v,t^.left);
  END;
END; (* InsertSorted *)

FUNCTION NumNodes(t : Tree) : LONGINT;
VAR
count : LONGINT;
BEGIN (* NumNodes *)  IF (t <> NIL) THEN BEGIN
    count := 1 + NumNodes(t^.left);
    count := 1 + NumNodes(t^.right);
  END ELSE BEGIN
    count := 0;
  END;
  NumNodes := count;
END; (* NumNodes *)

PROCEDURE Balance(arr : DynIntArrayPtr; start,ende : INTEGER; VAR t : Tree);
VAR
median : INTEGER;
BEGIN (* NewBalancedTree *)
  IF (start > ende) THEN BEGIN
    t := NIL;
  END ELSE BEGIN
    median := (start+ende) DIV 2;
    (*$R-*)
    t := NewNode(arr^[median]);
    WriteLn('NODE ',arr^[median]);
    (*$R+*)
    Balance(arr,start,median-1,t^.left);
    Balance(arr,median+1,ende,t^.right);
  END;
END; (* NewBalancedTree *)
//1234 5 678910
//67 8 9

FUNCTION GetLengthDyn(arr : DynIntArrayPtr): INTEGER;
VAR
count,i : INTEGER;
BEGIN (* GetLengthDyn *)
  count := 0;
  FOR i := LOW(arr^) TO HIGH(arr^) DO BEGIN
    WriteLn(arr^[i]);
    Inc(count);
  END; (* FOR *)
  GetLengthDyn := count;
END; (* GetLengthDyn *)

PROCEDURE WriteTreeInOrder(t : Tree);
BEGIN
  IF t <> NIL THEN BEGIN
    WriteTreeInOrder(t^.left);
    Write(t^.value, ' ');
    WriteTreeInOrder(t^.right);
  END;
END;

VAR t,bt : Tree;
    v, n : INTEGER;
    pos : LONGINT;
    arr : ^DynIntArray;

BEGIN (* balTree *)
  WriteLn('Eingabe: ');
  t := NIL;
  REPEAT 
    Read(v);
    IF v <> 0 THEN 
      InsertSorted(v, t);
  UNTIL v = 0;
  (* allocate dynamic array with correct length *)
  n := NumNodes(t);
  pos := 1;
  IF n > 0 THEN BEGIN
    GetMem(arr, SIZEOF(INTEGER) * n);
    CopyBinTreeToDynArr(t, arr, pos);
  END;
  WriteLn('Ordnung wie die Werte im Baum gespeichert werden: ');
  Balance(arr,1,n,bt);
  WriteLn('In-Order WriteTree: ');
  WriteTreeInOrder(bt);
  FreeMem(arr, SIZEOF(INTEGER) * n)
END. (* balTree *)