PROGRAM terminueberschneidungen;
TYPE
AppointmentREC = RECORD
  APname : STRING;
  startHour, startMinute, endHour, endMinute : INTEGER;
END;
AppointmentArray = ARRAY[1..100] OF AppointmentREC;

VAR
appointments : AppointmentArray; 
termin,ueberschneidung,groessteUeberschneidung,positionZ,positionX : INTEGER;
i,j,z,x : INTEGER;

BEGIN
  termin := 1;
  i := 1;
  ueberschneidung := 0;
  groessteUeberschneidung := 0;

  for i:=1 TO Length(appointments) do BEGIN//EINGABE
    WriteLn('Bitte Terminname fuer Termin ', termin,' eingaben (Leerzeichen falls eingabe zu ende)');
    ReadLn(appointments[i].APname);
    if (appointments[i].APname = ' ') then
      BREAK;
    WriteLn('Bitte startHour, startMinute, endHour, endMinute fuer Termin ', termin,' eingeben');
    ReadLn(appointments[i].startHour,appointments[i].startMinute,appointments[i].endHour,appointments[i].endMinute);
    Inc(termin);
  END;//EINGABE ENDE
  
  for z := 1 to termin-1 do BEGIN // z ist immer endhour
    for x := 1 to termin-1 do BEGIN// x ist immer starthour
      if (appointments[z].endHour > appointments[x].startHour) AND (x >= z+1)(*alle starthours die NACH endhour kommen*) then BEGIN //eindeutig dass sich bei den stunden etwas überschneidet
        if appointments[z].endhour > appointments[x].endHour then BEGIN
          ueberschneidung := appointments[x].endHour - appointments[x].startHour;
          ueberschneidung := ueberschneidung * 60;
          ueberschneidung := ueberschneidung + appointments[x].endMinute - appointments[x].startMinute;
        end;
        if appointments[z].endhour < appointments[x].endHour then BEGIN
          ueberschneidung := appointments[z].endHour - appointments[x].startHour;
          ueberschneidung := ueberschneidung * 60;
          ueberschneidung := ueberschneidung + appointments[z].endMinute - appointments[x].startMinute;
        end;
        if ueberschneidung > groessteUeberschneidung then BEGIN
          groessteUeberschneidung := ueberschneidung;
          positionZ := z;
          positionX := x;
        END;//if
      END;//eindeutig dass sich bei den stunden etwas überschneidet

      if (appointments[z].endHour = appointments[x].startHour) AND NOT (appointments[z].endMinute =appointments[x].endMinute) then BEGIN //Nur minuten unterscheiden sich
        if appointments[z].endMinute > appointments[x].startMinute then BEGIN
          ueberschneidung := appointments[z].endMinute - appointments[x].startMinute;
        END;
        if appointments[z].endMinute < appointments[x].startMinute then BEGIN
          ueberschneidung := appointments[x].startMinute - appointments[z].endMinute;
        END;
        if ueberschneidung > groessteUeberschneidung then BEGIN
          groessteUeberschneidung := ueberschneidung;
          positionZ := z;
          positionX := x;
        END;//if
      END;//if //NUR MINUTEN UNTERSCHEIDEN SICH

    END;//for
  END;//for

  for j := 1 to termin - 1 do BEGIN//AUSGABE
    WriteLn(appointments[j].APname);
    WriteLn(appointments[j].startHour,':',appointments[j].startMinute,' - ',appointments[j].endHour,':',appointments[j].endMinute);
  END;
  if groessteUeberschneidung = 0 then
    WriteLn('Es gibt keine Ueberschneidungen');
  if groessteUeberschneidung > 0 then
    WriteLn('Staerkste ueberschneidung an position: ', appointments[positionZ].APname,' und ',appointments[positionX].APname,' um ', groessteUeberschneidung, ' minuten ');
END.