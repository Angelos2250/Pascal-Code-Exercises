PROGRAM wordNodeList;
USES UnitWordNodeList;

VAR l: WordListPtr;
BEGIN

  l := NewWordList;// l := NIL;
  AppendWord(l,'The ');
  AppendWord(l,'quick ');
  AppendWord(l,'brown ');
  AppendWord(l,'fox ');
  AppendWord(l,'jumps ');
  AppendWord(l,'over ');
  AppendWord(l,'the ');
  AppendWord(l,'lazy ');
  AppendWord(l,'dog.');
  PrintWordList(l);
  WriteLn;
  Write('Copied List: ');
  PrintWordList(CopyWordList(l));
  WriteLn;
  WriteLn('WordListLength: ',WordListLength(l));
  Write('Spliting at pos 18: ');
  PrintWordList(SplitWordList(l,18));

  WriteLn;
  WriteLn;
  WriteLn;

  WriteLn('Testing empty List');
  Dispose(l);
  l := NewWordList;
  //PrintWordList(l);

  WriteLn;
  WriteLn;
  WriteLn;

  AppendWord(l,'OneWordOnly');
  WriteLn('List with only 1 Node');
  PrintWordList(l);
  WriteLn;
  Write('Spliting at pos 18: ');
  PrintWordList(SplitWordList(l,2));
  WriteLn;
  Write('Other Part of the List: ');
  //PrintWordList(l);

  WriteLn;
  WriteLn;
  WriteLn;

  DisposeWordList(l);
  l := NewWordList;
  AppendWord(l,'The ');
  AppendWord(l,'quick ');
  AppendWord(l,'brown ');
  AppendWord(l,'fox ');
  AppendWord(l,'jumps ');
  AppendWord(l,'over ');
  AppendWord(l,'the ');
  AppendWord(l,'lazy ');
  AppendWord(l,'dog.');
  PrintWordList(l);
  WriteLn;
  Write('Spliting at a blank pos 10: ');
  PrintWordList(SplitWordList(l,10));
  WriteLn;
  PrintWordList(l);
END.