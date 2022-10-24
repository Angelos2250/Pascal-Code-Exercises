PROGRAM AvgPower;

CONST
  weekdays = 7;

TYPE 
  WeekdayValues = ARRAY[1..weekdays] OF REAL;
  measuredValues = ARRAY[1..100] OF REAL;

PROCEDURE InitArray(VAR measuredValues : ARRAY OF REAL;VAR n : INTEGER);
VAR
  input : REAL;
BEGIN
  Read(input);
  n := LOW(measuredValues);
  WHILE input <> 0 DO BEGIN
    measuredValues[n] := input;
    Read(input);
    Inc(n);
  END;
  Dec(n);
END;

PROCEDURE AveragePerWeekday(measuredValues:ARRAY OF REAL;n: INTEGER;VAR avg: WeekdayValues);
VAR
sum : REAL;
week,count : INTEGER;
i :INTEGER;
BEGIN
  FOR i:= LOW(measuredValues) TO weekdays-1 DO BEGIN
    sum := measuredValues[i];
    count := 1;
    week := weekdays;
    WHILE i+week <= n DO BEGIN
      sum := sum + measuredValues[i+week];
      Inc(count);
      week := week + weekdays;
    END;
    avg[i+1] := sum/count;
  END;
END;

VAR
n,i :INTEGER;
inputValues : measuredValues;
avg : WeekdayValues;
BEGIN
  WriteLn('Bitte Zahlen eingeben');
  InitArray(inputValues,n);
  AveragePerWeekday(inputValues,n,avg);
  WriteLn('    MO     DI    MI      DO     FR     SA     SO');
  FOR i:= 1 TO weekdays DO BEGIN
    Write(avg[i]:7:3);
  END;
END.