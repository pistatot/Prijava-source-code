unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DataSource4: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SQLite3Connection4: TSQLite3Connection;
    SQLQuery4: TSQLQuery;
    SQLTransaction4: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

uses Unit1;

  { TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  Form1.Show;
  Close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  try
    SQLite3Connection4.Close(False);
    SQLite3Connection4.Open;
    SQLTransaction4.Active := True;
    SQLQuery4.SQL.Text :=
      'DELETE FROM Data WHERE link=:Link AND korisnik=:Korisnik AND sifra=:Sifra';
    SQLQuery4.Params.ParamByName('Link').AsString := Label1.Caption;
    SQLQuery4.Params.ParamByName('Korisnik').AsString := Label2.Caption;
    SQLQuery4.Params.ParamByName('Sifra').AsString := Label3.Caption;
    SQLQuery4.ExecSQL;
    SQLTransaction4.Commit;
    ShowMessage('Podaci su uspešno obrisani');
    SQLite3Connection4.CloseTransactions;
    Form1.Show;
    Close;
  except
    ShowMessage('Nemogu da unesem podatke');
  end;
end;

procedure TForm4.ComboBox1Change(Sender: TObject);
var
  nesto: string;
begin
  if ComboBox1.Text <> 'Izaberi' then
  begin
    nesto := ComboBox1.Text;
    SQLQuery4.Close;
    SQLite3Connection4.Connected := True;
    SQLQuery4.Clear;
    SQLQuery4.SQL.Text := 'SELECT * FROM Data WHERE Ime=:ja';
    SQLQuery4.Params.ParamByName('ja').AsString := nesto;
    SQLQuery4.Open;
    DataSource4.DataSet := SQLQuery4;
    Label1.Caption := DataSource4.DataSet.FieldByName('link').AsString;
    Label2.Caption := DataSource4.DataSet.FieldByName('korisnik').AsString;
    Label3.Caption := DataSource4.DataSet.FieldByName('sifra').AsString;
    SQLite3Connection4.CloseTransactions;
    Button2.Enabled := True;
  end;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  ComboBox1.Text := 'Izaberi';
  Label1.Caption := '';
  Label2.Caption := '';
  Label3.Caption := '';
  try
    SQLite3Connection4.Close(False);
    SQLite3Connection4.Open;
    SQLite3Connection4.Connected := True;
    SQLQuery4.SQL.Clear;
    SQLQuery4.SQL.Text :=
      'Select ime,link,korisnik,sifra from Data ORDER BY ime ASC';
    SQLQuery4.Open;
    ComboBox1.Items.Clear;
    SQLQuery4.First;
    while not SQLQuery4.EOF do
    begin
      ComboBox1.Items.Add(SQLQuery4.FieldByName('ime').AsString);
      SQLQuery4.Next;
    end;
  except
    SQLite3Connection4.CloseTransactions;
  end;
  ComboBox1.SetFocus;
  SQLite3Connection4.CloseTransactions;
end;

end.
