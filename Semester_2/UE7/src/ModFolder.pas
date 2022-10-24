UNIT ModFolder;

INTERFACE

  USES ModData,ModFile,sysutils;

  CONST
    maxSize = 30;

  TYPE
    FolderPtr = ^Folder;
    Folder = OBJECT(Data)
    PUBLIC
      CONSTRUCTOR Init(name:STRING;Typestr:STRING);
      DESTRUCTOR Done;VIRTUAL;
      PROCEDURE Add(fileObj: DataPtr);
      FUNCTION Remove(name: STRING):DataPtr;
      PROCEDURE Delete(name: STRING);
      PROCEDURE WriteData;
      FUNCTION Size: LONGINT;
    PRIVATE
      data : ARRAY[1..maxSize] OF DataPtr;
      top: INTEGER;
  END;

IMPLEMENTATION

  CONSTRUCTOR Folder.Init(name,Typestr: STRING);
  BEGIN
    INHERITED Init(name,Typestr);
    top := 0;
  END;

  DESTRUCTOR Folder.Done;
    VAR
      i: INTEGER;
  BEGIN
    INHERITED Done;
    FOR i := 1 TO top DO BEGIN
      Dispose(data[i],Done);
    END; (* FOR *)
  END;

  PROCEDURE Folder.Add(FileObj: DataPtr);
  BEGIN (* add *)
    Inc(top);
    IF (top > maxSize) THEN BEGIN
      WriteLn('Data is Full');
      HALT;
    END; (* IF *)
    data[top] := FileObj;
    UpdateDate;
  END; (* add *)

  FUNCTION Folder.Remove(name: STRING):DataPtr;
    VAR
      i,j: INTEGER;
      temp: DataPtr;
  BEGIN (* Folder.Remove *)
    i := 1;
    WHILE (i <= top) AND (data[i]^.ReturnName <> name) DO BEGIN
      Inc(i);
    END;
    IF (data[i]^.ReturnName = name) THEN BEGIN
      temp := data[i];
      FOR j := i TO top DO BEGIN
        data[j] := data[j+1]; 
      END; (* FOR *)
      Dec(top);
      Remove := temp;
    END ELSE BEGIN
      WriteLn('Data doesnt exist');
      HALT;
    END;
    UpdateDate;
  END; (* Folder.Remove *)

  PROCEDURE Folder.Delete(name: STRING);
    VAR
      i,j: INTEGER;
      temp: DataPtr;
  BEGIN (* Folder.Remove *)
    i := 1;
    WHILE (i <= top) AND (data[i]^.ReturnName <> name) DO BEGIN
      Inc(i);
    END;
    IF (data[i]^.ReturnName = name) THEN BEGIN
      Dispose(data[i],Done);
      FOR j := i TO top DO BEGIN
        data[j] := data[j+1]; 
      END; (* FOR *)
      Dec(top);
    END ELSE BEGIN
      WriteLn('Data doesnt exist');
      HALT;
    END;
    UpdateDate;
  END; (* Folder.Remove *)

  FUNCTION Folder.Size: LONGINT;
  BEGIN (* Folder.Size *)
    Size := top;
  END; (* Folder.Size *)

  PROCEDURE Folder.WriteData;
    VAR
      i: INTEGER;
  BEGIN (* WriteData *)
    FOR i := 1 TO top DO BEGIN
      WriteLn(i,': ',data[i]^.ReturnName);
    END; (* FOR *)
  END; (* WriteData *)
  

BEGIN (* ModData *)
  
END. (* ModData *)