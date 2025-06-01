unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, Menus, Clipbrd;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button1MouseEnter(Sender: TObject);
    procedure Button1MouseLeave(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button2MouseEnter(Sender: TObject);
    procedure Button2MouseLeave(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button3MouseEnter(Sender: TObject);
    procedure Button3MouseLeave(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses Unit2, Unit3, Unit4;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  newFile: boolean;
begin
  SQLite3Connection1.Close;
  try
    newFile := not FileExists(SQLite3Connection1.DatabaseName);
    if newFile then
    begin
      try
        SQLite3Connection1.Open;
        SQLTransaction1.Active := True;
        SQLite3Connection1.ExecuteDirect('CREATE TABLE "Data"(' +
          ' "ID" Integer NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
          ' "ime" Char (100) NOT NULL, ' + ' "link" Char (100) NOT NULL, ' +
          ' "korisnik" Char (100) NOT NULL, ' + ' "sifra" Char (100) NOT NULL);');
        SQLTransaction1.Commit;
        SQLite3Connection1.CloseTransactions;
      except
        ShowMessage('Fajl baze nemože biti creiran');
      end;
    end
    else
      newFile := True;
  except
    ShowMessage('GREŠKA');
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.Text <> 'Izaberi' then
  begin
    Button1.Enabled := True;
    Button2.Enabled := True;
    Button3.Enabled := True;
    Shape1.Brush.Color := clLime;
    Shape2.Brush.Color := clLime;
    Shape3.Brush.Color := clLime;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  nesto: string;
  link: string;
begin
  Shape1.Brush.Color := clred;
  Shape2.Brush.Color := clLime;
  Shape3.Brush.Color := clLime;
  nesto := ComboBox1.Text;
  SQLQuery1.Close;
  SQLite3Connection1.Connected := True;
  SQLQuery1.Clear;
  SQLQuery1.SQL.Text := 'SELECT * FROM Data WHERE Ime=:ja';
  SQLQuery1.Params.ParamByName('ja').AsString := nesto;
  SQLQuery1.Open;
  DataSource1.DataSet := SQLQuery1;
  link := DataSource1.DataSet.FieldByName('link').AsString;
  Clipboard.AsText := link;
  SQLite3Connection1.CloseTransactions;
end;

procedure TForm1.Button1MouseEnter(Sender: TObject);
begin
  if Button1.Enabled then
  begin
    Button1.Width:=110;
    Button1.Left:=21;
    Button1.Font.Size:=14;
  end;
end;

procedure TForm1.Button1MouseLeave(Sender: TObject);
begin
  if Button1.Enabled then
  begin
    Button1.Width:=88;
    Button1.Left:=32;
    Button1.Font.Size:=12;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  nesto: string;
  korisnik: string;
begin
  Shape1.Brush.Color := clLime;
  Shape2.Brush.Color := clred;
  Shape3.Brush.Color := clLime;
  nesto := ComboBox1.Text;
  SQLQuery1.Close;
  SQLite3Connection1.Connected := True;
  SQLQuery1.Clear;
  SQLQuery1.SQL.Text := 'SELECT * FROM Data WHERE Ime=:ja';
  SQLQuery1.Params.ParamByName('ja').AsString := nesto;
  SQLQuery1.Open;
  DataSource1.DataSet := SQLQuery1;
  korisnik := DataSource1.DataSet.FieldByName('korisnik').AsString;
  Clipboard.AsText := korisnik;
  SQLite3Connection1.CloseTransactions;
end;

procedure TForm1.Button2MouseEnter(Sender: TObject);
begin
  if Button2.Enabled then
  begin
    Button2.Width:=110;
    Button2.Left:=21;
    Button2.Font.Size:=14;
  end;
end;

procedure TForm1.Button2MouseLeave(Sender: TObject);
begin
  if Button2.Enabled then
  begin
    Button2.Width:=88;
    Button2.Left:=32;
    Button2.Font.Size:=12;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  nesto: string;
  sifra: string;
begin
  Shape1.Brush.Color := clLime;
  Shape2.Brush.Color := clLime;
  Shape3.Brush.Color := clred;
  nesto := ComboBox1.Text;
  SQLQuery1.Close;
  SQLite3Connection1.Connected := True;
  SQLQuery1.Clear;
  SQLQuery1.SQL.Text := 'SELECT * FROM Data WHERE Ime=:ja';
  SQLQuery1.Params.ParamByName('ja').AsString := nesto;
  SQLQuery1.Open;
  DataSource1.DataSet := SQLQuery1;
  sifra := DataSource1.DataSet.FieldByName('sifra').AsString;
  Clipboard.AsText := sifra;
  SQLite3Connection1.CloseTransactions;
end;

procedure TForm1.Button3MouseEnter(Sender: TObject);
begin
  if Button3.Enabled then
  begin
    Button3.Width:=110;
    Button3.Left:=21;
    Button3.Font.Size:=14;
  end;
end;

procedure TForm1.Button3MouseLeave(Sender: TObject);
begin
  if Button3.Enabled then
  begin
    Button3.Width:=88;
    Button3.Left:=32;
    Button3.Font.Size:=12;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  try
    SQLite3Connection1.Close(False);
    SQLite3Connection1.Open;
    SQLite3Connection1.Connected := True;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Text :=
      'Select ime,link,korisnik,sifra from Data ORDER BY ime ASC';
    SQLQuery1.Open;
    ComboBox1.Items.Clear;
    SQLQuery1.First;
    while not SQLQuery1.EOF do
    begin
      ComboBox1.Items.Add(SQLQuery1.FieldByName('ime').AsString);
      SQLQuery1.Next;
    end;
  except
    SQLite3Connection1.CloseTransactions;
  end;
  ComboBox1.Text := 'Izaberi';
  ComboBox1.SetFocus;
  SQLite3Connection1.CloseTransactions;
  Button1.Enabled := False;
  Button2.Enabled := False;
  Button3.Enabled := False;
  Shape1.Brush.Color := clLime;
  Shape2.Brush.Color := clLime;
  Shape3.Brush.Color := clLime;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Form1.Hide;
  Form2.ShowModal;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Form1.Hide;
  Form3.ShowModal;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Form1.Hide;
  Form4.ShowModal;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  ShowMessage('Ovo je program za '#13#10'pamćenje i brzo biranje '#13#10'parametara za pristup sajta.'#13#10#13#10'Pisan Mart 2025.');
end;

end.
