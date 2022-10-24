PROGRAM Buchstabesalat;

TYPE
stringArr = ARRAY[1..100] OF String;

PROCEDURE removeSpace(VAR inputWords : ARRAY OF STRING);
VAR
i,j : INTEGER;
space : CHAR;
BEGIN
  space := CHAR(32);
  FOR i:= LOW(inputWords) TO HIGH(inputWords)DO BEGIN
    FOR j:= 1 TO Length(inputWords[i]) DO BEGIN
      IF inputWords[i][j] = space THEN
          DELETE(inputWords[i],j,1);
    END;
  END;
END;

PROCEDURE splitInput (input : STRING; VAR inputWords : stringArr);
VAR 
i,pos1,pos2,j,NextWord : INTEGER;
space : CHAR;
BEGIN
space := CHAR(32);
pos1 := 1;
NextWord := 1;
  FOR i := 1 TO Length(input) DO BEGIN
    IF (input[i] = space) OR (i = Length(input)) THEN BEGIN
      pos2 := i;
      FOR j := pos1 TO pos2 DO BEGIN
        inputWords[NextWord] := Concat(inputWords[NextWord],input[j]);
      END;//FOR
      pos1 := pos2 +1;
      Inc(NextWord);
    END;//IF
  END;//FOR
  removeSpace(inputWords);
END;//splitInput

PROCEDURE WriteStrArray(yourArray : ARRAY OF STRING; Length : INTEGER);
VAR
i : INTEGER;
BEGIN
  FOR i := LOW(yourArray) TO HIGH(yourArray) DO BEGIN
    Write(yourArray[i],' ');
  END;
END;

PROCEDURE Swap(VAR a,b : CHAR);
VAR c : CHAR;
begin
  c := a;
  a:= b;
  b := c;
end;

PROCEDURE swapChars(VAR inputWords : ARRAY OF STRING);
VAR
i,j : INTEGER;
BEGIN
  FOR i:= LOW(inputWords) TO HIGH(inputWords) DO BEGIN
    FOR j := 1 TO Length(inputWords[i]) DO BEGIN
      IF(j <> 1) AND (j <> Length(inputWords[i])) AND (j+1 <> Length(inputWords[i])) AND (Ord(inputWords[i][j+1]) < 64) AND (Ord(inputWords[i][j+1]) > 91) AND (Ord(inputWords[i][j+1]) < 96) AND (Ord(inputWords[i][j+1]) > 123)THEN BEGIN
        swap(inputWords[i][j],inputWords[i][j+1]);
        Inc(j)
      END;
    END;
  END;
END;

VAR
inputWords : stringArr;
input : STRING;
BEGIN
WriteLn('Bitte Satz eingeben der gemischt werden soll');
ReadLn(input);
splitInput(input,inputWords); //DONE
swapChars(inputWords);//DONE
WriteStrArray(inputWords,Length(inputWords));//DONE
END.