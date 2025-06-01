unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DataSource3: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SQLite3Connection3: TSQLite3Connection;
    SQLQuery3: TSQLQuery;
    SQLTransaction3: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}
uses Unit1;

{ TForm3 }

procedure TForm3.Button1Click(Sender: TObject);
begin
  ComboBox1.Text:='Izaberi';
  Edit1.Text:='';
  Edit2.Text:='';
  Edit3.Text:='';
  Form1.Show;
  Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  if (Edit1.Text='') or (Edit2.Text='') or (Edit3.Text='') then
  begin
    ShowMessage('Sva polja moraju biti popunjena');
    end
  else
begin
  try
      SQLite3Connection3.Close(false);
      SQLite3Connection3.Open;
      SQLTransaction3.Active:=True;
      SQLQuery3.SQL.Text:='UPDATE Data SET link=:Link,korisnik=:Korisnik,sifra=:Sifra WHERE ime=:Ime';
      SQLQuery3.Params.ParamByName('Ime').AsString:=ComboBox1.Text;
      SQLQuery3.Params.ParamByName('Link').AsString:=Edit1.Text;
      SQLQuery3.Params.ParamByName('Korisnik').AsString:=Edit2.Text;
      SQLQuery3.Params.ParamByName('Sifra').AsString:=Edit3.Text;
      SQLQuery3.ExecSQL;
      SQLTransaction3.Commit;
      Edit1.Text:='';
      Edit2.Text:='';
      Edit3.Text:='';
      ComboBox1.Text:='Izaberi';
      ShowMessage('Podaci su uspešno upamćeni');
      SQLite3Connection3.CloseTransactions;
      Form1.Show;
      Close;
    except
      ShowMessage('Nemogu da unesem podatke');
    end;
end;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
Var
nesto:string;
begin
  If ComboBox1.Text<>'Izaberi' then
begin
  nesto:=ComboBox1.Text;
  SQLQuery3.Close;
  SQLite3Connection3.Connected:=true;
  SQLQuery3.Clear;
  SQLQuery3.SQL.Text:='SELECT * FROM Data WHERE Ime=:ja';
  SQLQuery3.Params.ParamByName('ja').AsString:=nesto;
  SQLQuery3.Open;
  DataSource3.DataSet:=SQLQuery3;
  Edit1.Text:=DataSource3.DataSet.FieldByName('link').AsString;
  Edit2.Text:=DataSource3.DataSet.FieldByName('korisnik').AsString;
  Edit3.Text:=DataSource3.DataSet.FieldByName('sifra').AsString;
  Button2.Enabled:=true;
  Edit1.SetFocus;
end;
end;


procedure TForm3.FormShow(Sender: TObject);
begin
 try
   SQLite3Connection3.Close(False);
   SQLite3Connection3.Open;
   SQLite3Connection3.Connected := True;
   SQLQuery3.SQL.Clear;
   SQLQuery3.SQL.Text :=
     'Select ime,link,korisnik,sifra from Data ORDER BY ime ASC';
   SQLQuery3.Open;
   ComboBox1.Items.Clear;
   SQLQuery3.First;
   while not SQLQuery3.EOF do
   begin
     ComboBox1.Items.Add(SQLQuery3.FieldByName('ime').AsString);
     SQLQuery3.Next;
   end;
 except
   SQLite3Connection3.CloseTransactions;
 end;
ComboBox1.SetFocus;
SQLite3Connection3.CloseTransactions;
end;

end.

