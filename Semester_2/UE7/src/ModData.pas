UNIT ModData;

INTERFACE

  USES sysutils;

  TYPE
    DataPtr = ^Data;
    Data = OBJECT
    PUBLIC
      CONSTRUCTOR Init(name:STRING;Typestr:STRING);
      DESTRUCTOR Done;VIRTUAL;
      PROCEDURE UpdateDate;
      FUNCTION ReturnName: STRING;
    PRIVATE
      name: STRING;
      Typestr: STRING;
      dateModified: STRING;
  END;

IMPLEMENTATION

  CONSTRUCTOR Data.Init(name,Typestr: STRING);
  BEGIN
    SELF.name := name;
    SELF.Typestr := Typestr;
    SELF.dateModified := DateTimeToStr(Now);
  END;

  DESTRUCTOR Data.Done;
  BEGIN

  END;

  PROCEDURE Data.UpdateDate;
  BEGIN (* Data.UpdateDate *)
    SELF.dateModified := DateTimeToStr(Now);
  END; (* Data.UpdateDate *)
  
  FUNCTION Data.ReturnName: STRING;
  BEGIN (* ReturnName *)
    ReturnName := name;
  END; (* ReturnName *)

BEGIN (* ModData *)
  
END. (* ModData *)