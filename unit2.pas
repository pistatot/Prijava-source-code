unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource2: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SQLite3Connection2: TSQLite3Connection;
    SQLQuery2: TSQLQuery;
    SQLTransaction2: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public
    procedure LoadData;
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

uses Unit1;

  { TForm2 }

procedure TForm2.LoadData;
begin
  try
    SQLite3Connection2.Connected := True;
    SQLQuery2.SQL.Clear;
    SQLQuery2.SQL.Text := 'Select * from Data';
    SQLQuery2.Open;
    DataSource2.DataSet := SQLQuery2;
  except
    ShowMessage('Nemogu da priđjem bazi')
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  SQLite3Connection2.CloseTransactions;
  Form1.Show;
  Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  if (Edit1.Text = '') or (Edit2.Text = '') or (Edit3.Text = '') or (Edit4.Text = '') then
  begin
    ShowMessage('Sva polja moraju biti popunjena');
  end
  else
  begin
    try
      SQLite3Connection2.Close(False);
      SQLite3Connection2.Open;
      SQLTransaction2.Active := True;
      SQLQuery2.SQL.Text :=
        'INSERT INTO Data(ime, link, korisnik, sifra) VALUES(:Ime, :Link, :Korisnik, :Sifra)';
      SQLQuery2.Params.ParamByName('Ime').AsString := Edit1.Text;
      SQLQuery2.Params.ParamByName('Link').AsString := Edit2.Text;
      SQLQuery2.Params.ParamByName('Korisnik').AsString := Edit3.Text;
      SQLQuery2.Params.ParamByName('Sifra').AsString := Edit4.Text;
      SQLQuery2.ExecSQL;
      SQLTransaction2.Commit;
      Edit1.Text := '';
      Edit2.Text := '';
      Edit3.Text := '';
      Edit4.Text := '';
      Edit1.SetFocus;
      LoadData;
      ShowMessage('Podaci su uspešno upamćeni');
      SQLite3Connection2.CloseTransactions;
      Form1.Show;
      Close;
    except
      ShowMessage('Nemogu da unesem podatke');
    end;
  end;
end;

end.
