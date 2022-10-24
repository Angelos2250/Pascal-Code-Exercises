PROGRAM QueueTest;

USES QueueADS;


VAR
  i : INTEGER;
BEGIN (* QueueTest *)
  WriteLn('Is Queue Empty?: ',IsEmpty);
  WriteLn('Filling queue with 20 Numbers');
  FOR i := 1 TO 20 DO BEGIN
    Enque(i);
  END; (* FOR *)
  WriteLn('Dequeing 1 Number');
  Deque;
  WriteLn('Writing Queue');
  WriteQueue;
  WriteLn('Is Queue Empty?: ',IsEmpty);
END. (* QueueTest *)