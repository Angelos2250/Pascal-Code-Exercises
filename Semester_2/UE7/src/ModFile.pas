UNIT ModFile;

INTERFACE

  USES ModData;

  TYPE
    FilesPtr = ^Files;
    Files = OBJECT(data)
      PUBLIC
        CONSTRUCTOR Init(name,typestr: STRING);
      PRIVATE
        size: LONGINT;
    END;

IMPLEMENTATION

  CONSTRUCTOR Files.Init(name,typestr: STRING);
  BEGIN
    INHERITED Init(name,typestr);
  END;

BEGIN (* ModFile *)
  
END. (* ModFile *)