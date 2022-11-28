unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, System.IOUtils, FireDAC.Phys.SQLiteWrapper.Stat;

type
  Tdm = class(TDataModule)
    conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure connBeforeConnect(Sender: TObject);
   procedure connAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

 procedure Tdm.connAfterConnect(Sender: TObject);
  var
    strSQL: string;
  begin
        strSQL :='create table IF NOT EXISTS TAB_USUARIO(                          '+
                 'ID_USUARIO integer not null primary key autoincrement, '+
                 'NOME varchar (100), '+
                'EMAIL varchar (100),'  +
                'SENHA varchar (100),'  +
                'IND_LOGIN char (1),'  +
                 'FOTO blob)';
   Conn.ExecSQL(strSQL);
  end;

procedure Tdm.connBeforeConnect(Sender: TObject);
begin
  var
  strPath: string;
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'banco.db');
{$ENDIF}
{$IFDEF MSWINDOWS}
  strPath:=System.IOUtils.TPath.Combine('D:\Users\aluno\Downloads\MyTime- Sharline-Diego Roeder- Ryan (1)\MyTime- Sharline-Diego Roeder- Ryan (2)\MyTime- Sharline-Diego Roeder- Ryan\DB\',
  'banco.db');
  {$ENDIF}
  Conn.Params.Values['UseUnicode'] := 'False';
  Conn.Params.Values['DATABASE'] := strPath;
end;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
    with Conn do
    begin
        {$IFDEF MSWINDOWS}
        try
            Params.Values['Database'] := 'D:\Users\aluno\Downloads\MyTime- Sharline-Diego Roeder- Ryan (1)\MyTime- Sharline-Diego Roeder- Ryan (2)\MyTime- Sharline-Diego Roeder- Ryan\DB\banco.db';
            Connected := true;
        except on E:Exception do
                raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
        end;

        {$ELSE}

        Params.Values['DriverID'] := 'SQLite';
        try
               Params.Values['Database'] := 'D:\Users\aluno\Downloads\MyTime- Sharline-Diego Roeder- Ryan (1)\MyTime- Sharline-Diego Roeder- Ryan (2)\MyTime- Sharline-Diego Roeder- Ryan\DB\banco.db';
            Connected := true;
        except on E:Exception do
            raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
        end;
        {$ENDIF}
    end;
end;

end.
