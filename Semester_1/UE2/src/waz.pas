PROGRAM waz;
VAR ues,mis,n : INTEGER; Eingabe,s : String;
begin
  ues := 0;
  mis := 0;
  WriteLn('Bitte Wochenstunden eingeben.(Ende mit EIngabe 0)');
  Read(n);
  Str(n,s);
  Eingabe := Concat(s, ' ');
  WHILE n <> 0 DO begin

    IF n > 40 THEN begin
      ues := ues + n -40;
      Read(n);
      Str(n,s); // Convert n to String and save it to s (Dient nur zur Darstellung)
      Eingabe := Concat(Eingabe, s, ' '); //Verkette Eingabe, s und ' ' in Eingabe (Dient nur zur Darstellung)
    end

    ELSE begin
      mis := mis + 40 - n;
      Read(n);
      Str(n,s);
      Eingabe := Concat(Eingabe, s, ' ');
    end
  end;
  WriteLn('Eingabe: ', Eingabe);
  WriteLn('Ueberstunden :', ues);
  WriteLn('Minusstunden :', mis);

end.
