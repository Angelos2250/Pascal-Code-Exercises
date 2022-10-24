PROGRAM VectorTest;

USES
  VectorADS;

VAR
  i: INTEGER;
BEGIN (* VectorTest *)
  WriteLn('Add 20 ints to Vector');
  FOR i := 1 TO 20 DO BEGIN
    Add(i);
  END; (* FOR *)
  WriteLn('SetElement at pos 11 to val 88');
  SetElementAt(11,88);
  WriteLn('RemoveElement At 12');
  RemoveElementAt(12);
  WriteLn('Writing Vector its Size and Capacity');
  WriteVector;
  WriteLn('Size: ',Size);
  WriteLn('Capacity: ',Capacity);

END. (* VectorTest *)