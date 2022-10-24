PROGRAM Vtest;

USES ModVectorObj;

VAR
  v: VectorPtr;
  v2: VectorPtr;
  ok: BOOLEAN;
  test: INTEGER;
BEGIN (* Vtest *)
  WriteLn('Create new Vector v1 and fill it with numbers');
  New(v,Init(10));
  v^.Add(20);
  v^.Add(3);
  v^.Add(3);
  v^.Add(3);
  v^.Add(3);
  v^.Add(3);
  v^.InsertElementAt(10,99,ok);
  v^.WriteV;
  v^.GetElementAt(4,test,ok);
  WriteLn('Size of Vector: ',v^.Size);
  v^.Clear;
  WriteLn('Size After Clear: ',v^.Size);
  WriteLn('Value at pos 4: ',test);
  WriteLn('Write Vector');
  v^.WriteV;
  WriteLn('Create and Write another Vector with size 5');
  New(v2,Init(5));
  v2^.WriteV;
END. (* Vtest *)