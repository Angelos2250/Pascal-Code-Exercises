UNIT ModStringBuilder;

INTERFACE
  TYPE
    StringBuilderPtr = ^StringBuilder;
    StringBuilder = OBJECT
      PUBLIC
        CONSTRUCTOR Init;
        FUNCTION CheckIfStart: BOOLEAN;
        PROCEDURE AppendStr(e:STRING); VIRTUAL;
        PROCEDURE AppendChar(e: CHAR); VIRTUAL;
        PROCEDURE AppendInt(e:INTEGER); VIRTUAL;
        PROCEDURE AppendBool(e:BOOLEAN); VIRTUAL;
        FUNCTION AsString: STRING;
      PRIVATE
        data: STRING;
    END;

    TabStringBuilderPtr = ^TabStringBuilder;
    TabStringBuilder = OBJECT(StringBuilder)
      PUBLIC
        CONSTRUCTOR Init(count: INTEGER);
        PROCEDURE AppendStr(e:STRING); VIRTUAL;
        PROCEDURE AppendChar(e: CHAR); VIRTUAL;
        PROCEDURE AppendInt(e:INTEGER); VIRTUAL;
        PROCEDURE AppendBool(e:BOOLEAN); VIRTUAL;
      PRIVATE
        cnt: INTEGER;
    END;

    StringJoinerPtr = ^StringJoiner;
    StringJoiner = OBJECT(StringBuilder)
      PUBLIC
        CONSTRUCTOR Init(d: CHAR);
        PROCEDURE Add(e:STRING);
      PRIVATE
        delim: STRING;
    END;

IMPLEMENTATION

  CONSTRUCTOR StringBuilder.Init;
  BEGIN
    data := '';
  END;

  FUNCTION StringBuilder.CheckIfStart: BOOLEAN;
  BEGIN (* StringBuilder.CheckIfStart *)
    IF (data = '') THEN BEGIN
      CheckIfStart := TRUE
    END ELSE BEGIN
      CheckIfStart := FALSE;
    END;
  END; (* StringBuilder.CheckIfStart *)

  PROCEDURE StringBuilder.AppendStr(e:STRING);
  BEGIN (* StringBuilder.AppendStr *)
    data := data + e;
  END; (* StringBuilder.AppendStr *)

  PROCEDURE StringBuilder.AppendChar(e:CHAR);
  BEGIN (* StringBuilder.AppendChar *)
    data := data + e;
  END; (* StringBuilder.AppendChar *)

  PROCEDURE StringBuilder.AppendInt(e: INTEGER);
    VAR
      s: STRING;
  BEGIN (* StringBuilder.AppendInt *)
    Str(e,s);
    data := data + s;
  END; (* StringBuilder.AppendInt *)

  PROCEDURE StringBuilder.AppendBool(e:BOOLEAN);
  BEGIN (* StringBuilder.AppendBool *)
    IF (e = TRUE) THEN BEGIN
      data := data + 'TRUE';
    END ELSE BEGIN
      data := data + 'FALSE';
    END;
  END; (* StringBuilder.AppendBool *)
  
  FUNCTION StringBuilder.AsString: STRING;
  BEGIN (* AsString *)
    AsString := data;
  END; (* AsString *)

  {-----------------TabStringBuilder-----------------}

  CONSTRUCTOR TabStringBuilder.Init(count: INTEGER);
  BEGIN
    INHERITED Init;
    SELF.cnt := count;
  END;

  PROCEDURE TabStringBuilder.AppendStr(e: STRING);
    VAR
      i: INTEGER;
  BEGIN (* TabStringBuilder.AppendSt *)
    IF (INHERITED CheckIfStart) THEN BEGIN
      INHERITED AppendStr(e);
    END ELSE BEGIN  
      FOR i := 1 TO cnt DO BEGIN
        data := data + ' ';
      END; (* FOR *)
      INHERITED AppendStr(e);
    END;
  END; (* TabStringBuilder.AppendStr *)

  PROCEDURE TabStringBuilder.AppendChar(e: CHAR);
    VAR
      i: INTEGER;
  BEGIN (* TabStringBuilder.AppendChar *)
    IF (INHERITED CheckIfStart) THEN BEGIN
      INHERITED AppendChar(e);
    END ELSE BEGIN  
      FOR i := 1 TO cnt DO BEGIN
        data := data + ' ';
      END; (* FOR *)
      INHERITED AppendChar(e);
    END;
  END; (* TabStringBuilder.AppendChar *)

  PROCEDURE TabStringBuilder.AppendInt(e: INTEGER);
    VAR
      i: INTEGER;
      s: STRING;
  BEGIN (* TabStringBuilder.AppendInt *)
    IF (INHERITED CheckIfStart) THEN BEGIN
      INHERITED AppendInt(e);
    END ELSE BEGIN  
      FOR i := 1 TO cnt DO BEGIN
        data := data + ' ';
      END; (* FOR *)
      INHERITED AppendInt(e);
    END;
  END; (* TabStringBuilder.AppendInt *)

  PROCEDURE TabStringBuilder.AppendBool(e: BOOLEAN);
    VAR
      i: INTEGER;
  BEGIN (* TabStringBuilder.AppendBool *)
    IF (INHERITED CheckIfStart) THEN BEGIN
      INHERITED AppendBool(e);
    END ELSE BEGIN  
      FOR i := 1 TO cnt DO BEGIN
        data := data + ' ';
      END; (* FOR *)
      INHERITED AppendBool(e);
    END;
  END; (* TabStringBuilder.AppendBool *)

 {-----------------StringJoiner-----------------}

  CONSTRUCTOR StringJoiner.Init(d:CHAR);
  BEGIN
    INHERITED Init;
    delim := d;
  END;

  PROCEDURE StringJoiner.Add(e:STRING);
  BEGIN (* StringJoiner.Add *)
    IF (INHERITED CheckIfStart) THEN BEGIN
      INHERITED AppendStr(e);
    END ELSE BEGIN  
      data := data + delim;
      INHERITED AppendStr(e);
    END;
  END; (* StringJoiner.Add *)

BEGIN (* ModStringBuilder *)
  
END. (* ModStringBuilder *)