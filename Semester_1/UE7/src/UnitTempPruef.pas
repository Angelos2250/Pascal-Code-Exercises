UNIT UnitTempPruef;

INTERFACE

FUNCTION CheckTemps(hour,minute : INTEGER;temp : REAL) : BOOLEAN;

IMPLEMENTATION

VAR
prevTemp : REAL;
prevTime,currentTime,difTime : INTEGER;

FUNCTION CheckTemps(hour,minute : INTEGER; temp : REAL) : BOOLEAN;
BEGIN
  IF prevTime = 0 THEN prevTime := 1;
  currentTime := minute + (hour*60);
  IF prevTemp = 0 THEN prevTemp := currentTime;
  difTime := currentTime - prevTime;
  IF (temp >= 935.5) AND (temp <=1345.6) AND (prevTemp - temp >= -11.5*difTime) AND (prevTemp - temp <= 11.5*difTime)THEN BEGIN
    CheckTemps := TRUE;
    prevTemp := temp;
    prevTime := currentTime;
  END
  ELSE BEGIN
  CheckTemps := FALSE;
  END
END;

BEGIN
WriteLn('UnitTempPruef Loaded');
END.