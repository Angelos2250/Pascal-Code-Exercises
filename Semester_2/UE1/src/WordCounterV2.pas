(* WordCounterV2:                                  HDO, 2003-02-28 *)
(* -----------                                                   *)
(*===============================================================*)
PROGRAM WordCounter;

  USES
    Crt, Timer, WordReader;

  CONST
    size = 11000;

  TYPE
    NodePtr = ^NodeRec;
    NodeRec = RECORD
      key: STRING;
      freq : INTEGER;
      (*data: AnyType*)
    END; (* NodeRec *)
    HashTable = ARRAY[0..size-1] OF NodePtr;

  VAR
    ht: HashTable;

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
    HashCode := HashCode1(key);
  END; (* HashCode *)

(* --- hashtable handling --- *)
  FUNCTION NewNode(key: STRING): NodePtr;
    VAR
      n: NodePtr;
  BEGIN (* NewNode *)
    New(n);
    n^.key := key;
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
  BEGIN (* WriteHashTable *)
    FOR h := 0 TO size-1 DO BEGIN
      IF ht[h] <> NIL THEN BEGIN
        WriteLn(h, ': ', ht[h]^.key,' ', ht[h]^.freq);
      END; (*IF*)
    END; (*FOR*)
  END; (* WriteHashTable *)

  FUNCTION Lookup(key: STRING): NodePtr;
    CONST
      c = 7; (* c > 1, no common divisior with size *)
      c2 = 11; 
    VAR
      h: INTEGER;
      n: NodePtr;
      nrOfColls: INTEGER;
  BEGIN (* Lookup *)
    h := HashCode(key);
    nrOfColls := 0;
    WHILE (nrOFColls <= size) DO BEGIN
      n := ht[h];
      IF n = NIL THEN BEGIN
        n := NewNode(key);
        ht[h] := n;
        Lookup := n;
        Exit;
      END
      ELSE IF n^.key = key THEN BEGIN
        n^.freq := n^.freq + 1;
        Lookup := n;
        Exit;
      END;
      (*linear probing*)
      h := (h + 1) MOD size;
      nrOfColls := nrOFColls + 1;
    END; (*WHILE*)
    WriteLn('ERROR: Hashtable overflow.')
  END; (* Lookup *)

  FUNCTION MostUsed : NodePtr;
  VAR
    n,count: NodePtr;
    i : INTEGER;
  BEGIN (* MostUsed *)
    count := NewNode('count');
    n := ht[0];
    FOR i := 0 TO size-1 DO BEGIN
      n := ht[i];
      IF (n <> NIL) AND (n^.freq > count^.freq) THEN BEGIN
        count := n;
      END;
    END; (* FOR *)
    MostUsed := count;
  END; (* MostUsed *)

PROCEDURE DeleteUniq;
VAR
  n: NodePtr;
  i : INTEGER;
BEGIN 
  FOR i := 0 TO size-1 DO BEGIN
    IF (ht[i] <> NIL) AND (ht[i]^.freq = 1) THEN BEGIN
      n := ht[i];
      ht[i] := NIL;
      Dispose(n);
    END; (* IF *)
  END; (* FOR *)
END;

FUNCTION CountNonUniq: INTEGER;
VAR
  count, i : INTEGER;
BEGIN (* CountNonUniq *)
  count := 0;
  FOR i := 0 TO size-1 DO BEGIN
    IF (ht[i] <> NIL) THEN BEGIN
      Inc(count);
    END; (* IF *)
  END; (* FOR *)
  CountNonUniq := count;
END; (* CountNonUniq *)

VAR
  w: Word;
  n: LONGINT;
  test : NodePtr;
BEGIN (*WordCounter*)
  WriteLn('WordCounter:');
  OpenFile('Semester_2/Uebung_1/WordStuff/Kafka.txt', toLower);
  StartTimer;
  InitHashTable;
  n := 0;
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
  DeleteUniq;
  WriteLn('Non Unique Words: ',CountNonUniq);
  //WriteHashTable;

END. (*WordCounter*)