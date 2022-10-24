PROGRAM Dateisystem;

USES ModData,ModFile,ModFolder;

VAR
    fo1: FolderPtr;
    fo2: FolderPtr;
    fi1: FilesPtr;
    fi2: FilesPtr;
    temp: FilesPtr;
BEGIN (* Dateisystem *)
  WriteLn('Create Fi1.png File');
  New(fi1,Init('fi1','png'));
  WriteLn('Create Fi2.png File');
  New(fi2,Init('fi2','png'));
  WriteLn('Create Fo1 Folder');
  New(fo1,Init('fo1','vz'));
  WriteLn('Create Fo2 Folder');
  New(fo2,Init('fo2','vz'));
  WriteLn('Add fi1 into fo1');
  fo1^.Add(fi1);
  WriteLn('Add fo1 into fo2');
  fo2^.Add(fo1);
  WriteLn('Add fi2 into fo2');
  fo2^.Add(fi1);
  WriteLn;
  WriteLn('Write Data of fo1');
  fo1^.WriteData;
  WriteLn;
  WriteLn('Remove f1 of fo1 and return it');
  temp := FilesPtr(fo1^.Remove('fi1'));
  WriteLn('Name of returned Data: ',temp^.ReturnName);
  WriteLn('Check if f1 really got removed from fo1 by Writing its Data');
  fo1^.WriteData;
  WriteLn('Write Data of fo2');
  fo2^.WriteData;
  WriteLn('Delete Data in fo2 called fo1');
  fo2^.Delete('fo1');
  WriteLn('Check if fo1 got deleted by Writing its data');
  fo1^.WriteData;
  WriteLn('Write fo2 Data');
  fo2^.WriteData;
END. (* Dateisystem *)