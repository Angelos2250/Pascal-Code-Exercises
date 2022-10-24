PROGRAM commonSubstring;

  PROCEDURE Swap(VAR s1, s2 : STRING);
    VAR 
      h : STRING;
  BEGIN 
    h := s1;
    s1 := s2;
    s2 := h;
  END;

  PROCEDURE FindLongestMatchv2(s1, s2 : STRING; VAR sub : STRING; VAR start1, start2 : INTEGER);
    VAR 
      sLen, pLen, i, j, count, longest, z, k : INTEGER;
      consec,swapped : BOOLEAN;
  BEGIN 
    count := 0;
    longest := 0;
    swapped := FALSE;
    IF Length(s1) < Length(s2) THEN BEGIN
      Swap(s1, s2);
      swapped := TRUE;
    END;
    sLen := Length(s1);
    pLen := Length(s2);
    i := 1;
    WHILE (i <= sLen) AND (i + pLen - 1 <= sLen) DO BEGIN 
      j := 1;
      WHILE (j <= pLen) DO BEGIN 
        k := j;
        count := 0;
        WHILE (k <= plen) DO BEGIN
          IF (s1[i + k - j] = s2[k]) THEN BEGIN
            Inc(count);
            consec := TRUE;
          END ELSE BEGIN
            consec := FALSE;
          END;
          IF (count > longest) AND (consec = FALSE) THEN BEGIN
              longest := count;
              start1 := i+k-j-longest;
              start2 := k-longest;
              count := 0;
          END; (* IF *)
          Inc(k);
        END; (* WHILE *)
        Inc(j);
      END;
      Inc(i);
    END;
    IF (swapped = TRUE) THEN BEGIN
      count := start1;
      start1 := start2;
      start2 := count;
      FOR z := start1 TO start1+longest-1 DO BEGIN
        sub := Concat(sub,s2[z])
      END; (* FOR *)
    END ELSE BEGIN
      FOR z := start1 TO start1+longest-1 DO BEGIN
        sub := Concat(sub,s1[z])
      END; (* FOR *)
    END;
  END;

  FUNCTION BruteForceLR2(s, p : STRING) : INTEGER;
  VAR 
    i, j, n, m, count : INTEGER;
  BEGIN
    m := Length(p);
    n := Length(s);
    i := 1; j := 1;
    count := 0;
    WHILE (i <= n) AND (j <= m) DO BEGIN
      IF (s[i] = '_') THEN BEGIN
        Inc(i);
        Inc(count);
      END ELSE IF (s[i] = p[j]) OR (p[j] = '?') THEN BEGIN
        Inc(i);
        Inc(j);
      END ELSE BEGIN
        i := i - j + 2;
        j := 1;
      END;
    END;
    IF j > m THEN 
      BruteForceLR2 := i - j + 1 - count
    ELSE
      BruteForceLR2 := 0;
  END;

VAR
  start1,start2 : INTEGER;
  sub,s1,s2 : STRING;
BEGIN (* commonSubstring *)
  start1 := 0;
  start2 := 0;
  s1 := 'uvwxy';
  s2 := 'rstqvwxz';
  WriteLn('FindLongestMatch wird getestet');
  WriteLn('s1: ',s1, ' s2:', s2);
  FindLongestMatchv2(s1,s2,sub,start1,start2);
  WriteLn('pos in s1: ',start1,' pos in s2: ',start2);
  WriteLn('Longest String: ',sub);

  WriteLn;
  WriteLn('BruteForcePatternSearchingExtended wird getestet');  
  s1 := 'ab____c___de';
  s2 := 'ab?de';
  WriteLn('s: ',s1,' p: ',s2);
  WriteLn('Match gefunden an Stelle: ',BruteForceLR2(s1,s2));
END. (* commonSubstring *)