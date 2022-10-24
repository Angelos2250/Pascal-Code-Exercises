(* WordCounter:                                  HDO, 2003-02-28 *)
(* -----------                                                   *)
(*===============================================================*)
PROGRAM WordCounter;

  USES
    Crt, Timer, WordReader;

  CONST
    size = 3000;

  TYPE
    NodePtr = ^NodeRec;
    NodeRec = RECORD
      key : WORD;
      freq : INTEGER;
      next :NodePtr;
    END;
    ListPtr = NodePtr;
    Hashtable = ARRAY [0..size-1] OF ListPtr;

  VAR
    ht: HashTable;
    hcount : INTEGER;

  (* --- hash functions --- *)
  FUNCTION HashCode1(key: STRING): INTEGER;
  BEGIN (* HashCode1 *)
    HashCode1 := Ord(key[1]) MOD size;
  END; (* HashCode1 *)

  FUNCTION HashCode2(key: STRING): INTEGER;
  BEGIN (* HashCode2 *)
    HashCode2 := (Ord(key[1]) + Length(key)) MOD size;
  END; (* HashCode2 *)  

  FUNCTION HashCode3(key: STRING): INTEGER;
  BEGIN (* HashCode3 *)
    IF Length(key) = 1 THEN
      HashCode3 := ((Ord(key[1]) * 7 + 1) * 17) MOD size
    ELSE
      HashCode3 := ((Ord(key[1]) * 7 + Ord(key[2]) + Length(key)) * 17) MOD size;
  END; (* HashCode3 *)

  FUNCTION HashCode4(key: STRING): INTEGER;
    VAR
      hc, i: INTEGER;
  BEGIN (* HashCode4 *)
    hc := 0;
    FOR i:=1 TO Length(key) DO BEGIN
      hc := hc + Ord(key[i]);
    END; (*FOR*)
    HashCode4 := hc MOD size;
  END; (* HashCode4 *)      

  FUNCTION HashCode5(key: STRING): INTEGER;
    VAR
      hc, i: INTEGER;
  BEGIN (* HashCode5 *)
    hc := 0;
    FOR i:=1 TO Length(key) DO BEGIN
(*$Q-*)    
(*$R-*)
      hc := hc * 31 + Ord(key[i]);
(*$R+*)
(*$Q+*)      
    END; (*FOR*)  
    HashCode5 := Abs(hc) MOD size;
  END; (* HashCode5 *)

  FUNCTION HashCode(key: STRING): INTEGER;
  BEGIN (* HashCode *)
    HashCode := HashCode4(key);
  END; (* HashCode *)

(* --- hashtable handling ---*)
  FUNCTION NewNode(key: STRING; next: NodePtr): NodePtr;
    VAR
      n: NodePtr;
  BEGIN (* NewNode *)
    New(n);
    n^.key := key;
    n^.next := next;
    n^.freq := 1;
    NewNode := n;
  END; (* NewNode *)

  PROCEDURE InitHashTable;
    VAR
      h: INTEGER;
  BEGIN
    FOR h:= 0 TO size-1 DO BEGIN
      ht[h] := NIL;
    END; (*FOR*)
  END; (*InitHashTable*)

  PROCEDURE WriteHashTable;
    VAR
      h: INTEGER;
      n: NodePtr;
  BEGIN (* WriteHashTable *)
    FOR h := 0 TO size-1 DO BEGIN
      IF ht[h] <> NIL THEN BEGIN
        Write(h, ': ');
        n := ht[h];
        WHILE n <> NIL DO BEGIN
          Write(n^.key, ' ' ,n^.freq);
          n := n^.next;
        END; (*WHILE*)
        WriteLn;
      END; (*IF*)
    END; (*FOR*)
  END; (* WriteHashTable *)

PROCEDURE DeleteUniq;
VAR
  e,n,prev: NodePtr;
  i : INTEGER;
BEGIN
  prev := ht[0];
  IF prev <> NIL THEN n := prev^.next ELSE n := NIL; 
  FOR i := 0 TO size-1 DO BEGIN
    prev := ht[i];
    IF prev <> NIL THEN n := prev^.next ELSE n := NIL; 
    WHILE (ht[i] <> NIL) AND (ht[i]^.freq = 1) DO BEGIN
      e := ht[i];
      ht[i] := n;
      prev^.next := NIL;
      prev := ht[i];
      Dispose(e);
      IF prev <> NIL THEN n := prev^.next ELSE n := NIL; 
    END; (* WHILE *)
    WHILE (n <> NIL) DO BEGIN
      IF (n^.freq = 1) THEN BEGIN
        e := n;
        n := n^.next;
        prev^.next^.next := NIL;
        prev^.next := n;
        Dispose(e);
      END ELSE BEGIN (* IF *)
        n := n^.next;
        prev := prev^.next;
      END
    END; (* WHILE *)
  END; (* FOR *)
END;

FUNCTION CountNonUniq: INTEGER;
VAR
  n: NodePtr;
  i,count : LONGINT;
BEGIN 
  DeleteUniq;
  count := 0;
  FOR i := 0 TO size-1 DO BEGIN
    n := ht[i];
    WHILE (n <> NIL) DO BEGIN
      Inc(count);
      n := n^.next;
    END; (* WHILE *)
  END; (* FOR *)
  CountNonUniq := count;
END;

FUNCTION Lookup(key: STRING): NodePtr;
VAR
  h: INTEGER;
  n: NodePtr;
  collPossible: BOOLEAN;
BEGIN (* Lookup *)
  h := HashCode(key);
  n := ht[h];
  collPossible := FALSE;
  WHILE (n <> NIL) AND (n^.key <> key) DO BEGIN
    n := n^.next;
    collPossible := TRUE;
  END; (*WHILE*)
  IF n = NIL THEN BEGIN
    n := NewNode(key, ht[h]);  (*prepend*)
    ht[h] := n;
  END ELSE IF (n^.key = key) THEN BEGIN
    n^.freq := n^.freq +1;
    collPossible := FALSE;
  END; (*IF*)
  Lookup := n;
END; (* Lookup *)

  FUNCTION MostUsed : NodePtr;
  VAR
    n,count: NodePtr;
    i : INTEGER;
  BEGIN (* MostUsed *)
    count := NewNode('count',NIL);
    n := ht[0];
    FOR i := 0 TO size-1 DO BEGIN
      WHILE (n <> NIL) DO BEGIN
        IF (n^.freq >= count^.freq) THEN BEGIN
          count := n;
          n := n^.next;
        END ELSE n := n^.next;
      END; (* WHILE *)
      n := ht[i];
    END; (* FOR *)
    MostUsed := count;
  END; (* MostUsed *)

VAR
  w: Word;
  n: LONGINT;
  test : NodePtr;
BEGIN (*WordCounter*)
  WriteLn('WordCounter:');
  OpenFile('Semester_2/Uebung_1/WordStuff/Kek.txt', toLower);
  StartTimer;
  InitHashTable;
  n := 0;
  hcount := 0;
  ReadWord(w);
  WHILE w <> '' DO BEGIN
    n := n + 1;
    (*insert word in data structure and count its occurence*)
    ReadWord(w);
    Lookup(w);
  END; (*WHILE*)
  StopTimer;
  CloseFile;
  WriteLn('number of words: ', n);
  WriteLn('elapsed time:    ', ElapsedTime);
  (*search in data structure for word with max. occurrence*)
  WriteLn('Most Used Word: ',MostUsed^.key, ' ', MostUsed^.freq);
  WriteLn('Non Unique Words: ',CountNonUniq);

END. (*WordCounter*)