PROGRAM TempPruefung;
(*save state using Unit*)
USES UnitTempPruef;

TYPE
measurement = RECORD
Hour : INTEGER;
Minute : INTEGER;
Temps : REAL;
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