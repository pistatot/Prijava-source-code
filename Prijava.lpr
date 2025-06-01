program Prijava;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Windows, Forms, unit1, unit2, unit3, unit4
  { you can add units after this };

{$R *.res}
var
  Mutex : THandle;
begin
Mutex := CreateMutex(nil, True, 'MyAppName');
if (Mutex <> 0) and (GetLastError = 0) then
begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
  end;
end.

