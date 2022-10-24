PROGRAM VectorTest;

USES
  VectorADT;

VAR
  i,j: INTEGER;
  v1,v2: Vector;
BEGIN (* VectorTest *)
  v1 := NewVector(5);
  v2 := NewVector(5);
  WriteLn('Adding 8 ints to v1[Cap = 5]');
  FOR i := 1 TO 8 DO BEGIN
    Add(v1,i);
  END; (* FOR *)
  WriteLn('Adding 5 ints to v2[Cap = 5]');
  FOR j := 1 TO 5 DO BEGIN
    Add(v2,j);
  END; (* FOR *)
  WriteLn('SetElement at v1 at pos 5 to val 88');
  SetElementAt(v1,5,88);
  WriteLn('Remove Element at v1 at pos 1');
  RemoveElementAt(v1,1);
  WriteLn('values in v1');
  WriteVector(v1);
  WriteLn('values in v2');
  WriteVector(v2);
  WriteLn('Size of v1');
  WriteLn(Size(v1));
  WriteLn('Capacity of v1');
  WriteLn(Capacity(v1));
  WriteLn('Size of v2');
  WriteLn(Size(v2));
  WriteLn('Capacity of v2');
  WriteLn(Capacity(v2));

END. (* VectorTest *)