PROGRAM StringTest;

USES ModStringBuilder;


VAR
  s: StringBuilderPtr;
  t: TabStringBuilderPtr;
  j: StringJoinerPtr;
BEGIN (* StringTest *)
  WriteLn('Testing StringBuilder');
  New(s,Init);
  s^.AppendStr('eins');
  s^.AppendChar(' ');
  s^.AppendInt(2);
  s^.AppendChar(' ');
  s^.AppendBool(TRUE);
  WriteLn(s^.AsString);
  WriteLn;

  WriteLn('Testing TabStringBuilder');
  New(t, Init(8));
  t^.AppendStr('Eins');
  t^.AppendInt(2);
  t^.AppendBool(TRUE);
  WriteLn(t^.AsString);
  WriteLn;
  
  WriteLn('Testing StringJoiner');
  New(j, Init(','));
  j^.Add('Eins');
  j^.Add('Zwei');
  j^.Add('Drei');
  WriteLn(j^.AsString);
END. (* StringTest *)