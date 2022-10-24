PROGRAM WorthaueufigkeitV2;

TYPE
WordNodePtr = ^WordNode;
WordNode = RECORD
  prev,next: WordNodePtr;
  word: STRING;
  n: INTEGER;   (* frequency of word *)
END; (* WordNode*)

PROCEDURE InitList(VAR wl : WordNodePtr);
BEGIN (* InitList *)
  wl := NIL;
END; (* InitList *)

PROCEDURE CheckEmptyness(wl : WordNodePtr);
BEGIN
  IF (wl = NIL) THEN BEGIN
    WriteLn('Your List is empty');
    HALT;
  END; (* IF *)
END;

PROCEDURE AppendNode(VAR wl : WordNodePtr;word : STRING);
VAR
tmp,newWord : WordNodePtr;
BEGIN (* AppendNode *)
  tmp := wl;
  New(newWord);
  newWord^.next := NIL;
  newWord^.prev := NIL;
  newWord^.n := 1;
  newWord^.word := word;
  CheckEmptyness(wl);
  IF (wl = NIL) THEN BEGIN
    wl := newWord;
    wl^.next := wl;
    wl^.prev := wl;
  END ELSE BEGIN
    WHILE (tmp^.next <> wl) AND (tmp^.word <> newWord^.word) DO BEGIN
      tmp := tmp^.next;
    END; (* WHILE *)
    IF (tmp^.word = newWord^.word) THEN BEGIN
      IF (tmp = wl) THEN BEGIN
        Inc(tmp^.n);
      END ELSE BEGIN
        Inc(tmp^.n);
        (*Split duplicate word*)
        tmp^.next^.prev := tmp^.prev;
        tmp^.prev^.next := tmp^.next;
        (*Duplicate word to start*)
        tmp^.prev := wl^.prev;
        tmp^.next := wl;
        tmp^.next^.prev := tmp;
        tmp^.prev^.next := tmp;
        wl := tmp;
      END;
    END ELSE BEGIN
      newWord^.prev := wl^.prev;
      newWord^.next := wl;
      newWord^.next^.prev := newWord;
      newWord^.prev^.next := newWord;
      wl := newWord;
    END;
  END;
END; (* AppendNode *)

PROCEDURE PrintWordList(wl : WordNodePtr);
VAR
tmp : WordNodePtr;
BEGIN (* PrintWordList *)
  CheckEmptyness(wl);
  tmp := wl^.next;
  WriteLn(wl^.word, ' Haeufigkeit: ', wl^.n);
  WHILE (tmp <> wl) DO BEGIN
    WriteLn(tmp^.word, ' Haeufigkeit: ', tmp^.n);
    tmp := tmp^.next;
  END; (* WHILE *)
END; (* PrintWordList *)

PROCEDURE DeleteN1Words(VAR wl : WordNodePtr);
VAR
tmp,prev : WordNodePtr;
BEGIN
 tmp := wl;
 prev := wl;
 CheckEmptyness(wl);
  WHILE (tmp <> wl^.prev) DO BEGIN
    IF (tmp^.n <= 1) THEN BEGIN
      IF (tmp = wl) THEN BEGIN
        wl := tmp^.next;
      END; (* IF *)
      prev := tmp^.prev;
      tmp^.prev^.next := tmp^.next;
      tmp^.next^.prev := tmp^.prev;
      tmp^.next := NIL;
      tmp^.prev := NIL;
      Dispose(tmp);
      tmp := prev;
    END; (* IF *)
    tmp := tmp^.next;
  END; (* WHILE *)
  IF (tmp^.n <= 1) THEN BEGIN
    tmp^.prev^.next := tmp^.next;
    tmp^.next^.prev := tmp^.prev;
    tmp^.next := NIL;
    tmp^.prev := NIL;
    Dispose(tmp);
  END; (* IF *)
END;

VAR
wl : WordNodePtr;
BEGIN (* Worthaueufigkeit *)
  InitList(wl);
  DeleteN1Words(wl);
  PrintWordList(wl);
END. (* Worthaueufigkeit *)