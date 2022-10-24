PROGRAM TempPruefung;
TYPE
measurement = RECORD
Hour : INTEGER;
Minute : INTEGER;
Temps : REAL;
END;
(*Save state using global Variables*)
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

VAR
tempsMeasurement : measurement;
ovenState : STRING;
BEGIN
  WriteLn('Soll die Temperatur weiter gemessen werden? Bitte mit ja / nein Antworten');
  ReadLn(ovenState);
  WHILE ovenState = 'ja' DO BEGIN

    WriteLn('Bitte Stunden, Minuten , Temperauter der Messung eingeben');
    ReadLn(tempsMeasurement.Hour,tempsMeasurement.Minute,tempsMeasurement.Temps);

    WriteLn(CheckTemps(tempsMeasurement.Hour, tempsMeasurement.Minute, tempsMeasurement.Temps));

    WriteLn('Soll die Temperatur weiter gemessen werden? Bitte mit ja / nein Antworten');
    ReadLn(ovenState);
  END;
  WriteLn('Ok das Messen hört auf');
END.