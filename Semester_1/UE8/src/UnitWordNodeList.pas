UNIT UnitWordNodeList;

INTERFACE
CONST
  maxWordLength = 20;
  
TYPE
  WordNodePtr = ^WordNode;
  WordNode = RECORD
    next: WordNodePtr;
    word: STRING[maxWordLength];
    END;(* WordNode*)
  WordListPtr=WordNodePtr;

FUNCTION NewWordList: WordListPtr;
PROCEDURE DisposeWordList(VAR wl: WordListPtr);
PROCEDURE AppendWord(VAR wl: WordListPtr; word:STRING);
FUNCTION WordListLength(wl: WordListPtr): INTEGER;
PROCEDURE PrintWordList(wl: WordListPtr);
FUNCTION CopyWordList(wl: WordListPtr): WordListPtr;
FUNCTION SplitWordList(VAR wl: WordListPtr; pos: INTEGER): WordListPtr;

  

IMPLEMENTATION

FUNCTION NewWordList: WordListPtr;
BEGIN (* NewWordList *)
  NewWordList := NIL;
END; (* NewWordList *)

PROCEDURE CheckEmptyness(wl : WordListPtr);
BEGIN
  IF (wl = NIL) THEN BEGIN
    WriteLn('Your List is empty');
    HALT;
  END; (* IF *)
END;

PROCEDURE DisposeWordList(VAR wl : WordListPtr);
VAR tmp : WordListPtr;
BEGIN (* DisposeWordList *)
  WHILE (wl <> NIL) DO BEGIN
    tmp := wl;
    wl := wl^.next;
    Dispose(tmp);
  END; (* WHILE *)
END; (* DisposeWordList *)

PROCEDURE AppendWord(VAR wl : WordListPtr; word : STRING);
VAR
tmp : WordListPtr;
newWord : WordListPtr;
BEGIN (* AppendWord *)
  New(newWord);
  newWord^.word := word;
  newWord^.next := NIL;
  IF wl = NIL THEN BEGIN
    wl := newWord;
  END ELSE BEGIN 
    tmp := wl;
    WHILE (tmp^.next <> NIL) DO BEGIN
      tmp := tmp^.next;
    END; (* WHILE *)
    tmp^.next := newWord;
  END;
END; (* AppendWord *)

FUNCTION WordListLength(wl: WordListPtr): INTEGER;
VAR 
tmp : WordListPtr;
count : INTEGER;
BEGIN
  tmp := wl;
  count := Length(wl^.word);
  CheckEmptyness(wl);
  WHILE (tmp^.next <> NIL) DO BEGIN
    tmp := tmp^.next;
    count := count + Length(tmp^.word); 
  END; (* WHILE *)
  WordListLength := count;
END;

PROCEDURE PrintWordList(wl : WordListPtr);
VAR
tmp : WordListPtr;
BEGIN (* PrintWordList *)
  tmp := wl;
  CheckEmptyness(wl);
  WHILE (tmp <> NIL) DO BEGIN
    Write(tmp^.word);
    tmp := tmp^.next;
  END; (* WHILE *)
END; (* PrintWordList *)

FUNCTION CopyWordList(wl : WordListPtr): WordListPtr;
VAR
tmp : WordListPtr;
copiedList : WordListPtr;
BEGIN (* CopyWordList *)
  tmp := wl;
  copiedList := NewWordList;
  CheckEmptyness(wl);
  WHILE(tmp <> NIL) DO BEGIN
    AppendWord(copiedList, tmp^.word);
    tmp := tmp^.next;
  END;
  CopyWordList := copiedList;
END; (* CopyWordList *)

FUNCTION SplitWordList(VAR wl : WordListPtr; pos : INTEGER): WordListPtr;
VAR
  tmp: WordListPtr;
  splittedWordList: WordListPtr;
  count: INTEGER;
BEGIN (* SplitWordList *)
  tmp := wl;
  splittedWordList := wl;
  count:= Length(tmp^.word);
  CheckEmptyness(wl);
  IF (count >= pos) THEN BEGIN
    wl := NIL;
  END ELSE BEGIN
    WHILE (count < pos) DO BEGIN
      splittedWordList := splittedWordList^.next;
      count := count + Length(splittedWordList^.word);
      IF (count < pos) THEN BEGIN
        tmp := tmp^.next;
      END; (* IF *)
    END; (* WHILE *)
    tmp^.next := NIL;
  END; (* IF *)
  SplitWordList := splittedWordList;
END;
  

BEGIN (* UnitWordNodeList *)
  
END. (* UnitWordNodeList *)