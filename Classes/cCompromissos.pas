unit cCompromissos;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.Graphics;

type
    TCompromissos = class
    private
        Fconn: TFDConnection;
        FID_COMPROMISSO: Integer;
        FDESCRICAO: string;
        FDATA: TDateTime;
        FLOCAL: string;
    public
        constructor Create(conn: TFDConnection);
        property ID_COMPROMISSO: Integer read FID_COMPROMISSO write FID_COMPROMISSO;
        property DESCRICAO: string read FDESCRICAO write FDESCRICAO;
        property DATA: TDateTime read FDATA write FDATA;
        property LOCAL: string read FLOCAL write FLOCAL;

        function ListarCompromissos(qtd_result: integer; out erro: string): TFDQuery;
        function Inserir(out erro: string): Boolean;
        function ListarResumo(out erro: string): TFDQuery;
        //function Alterar(out erro: string): Boolean;
        function Excluir(out erro: string): Boolean;
end;

implementation
{TCompromissos}

uses UnitCompromissos, UnitDM;

constructor TCompromissos.Create(conn: TFDConnection);
begin
    Fconn := conn;
end;


//INSERIR --------------------------------------------------------------
function TCompromissos.Inserir(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    // Validacoes...
    if ID_COMPROMISSO <= 0 then
    begin
        erro := 'Informe o compromisso';
        Result := false;
        exit;
    end;

    if DESCRICAO = EmptySTR then
    begin
        erro := 'Informe a descrição';
        Result := false;
        exit;
    end;


    try
        try
            qry := TFDQuery.Create(nil);
            qry.Connection := Fconn;

            with qry do
            begin
                Active := false;
                SQL.Clear;
                SQL.Add('INSERT INTO TAB_COMPROMISSOS(ID_COMPROMISSO, DESCRICAO, DATA_HORA, LOCAL)');
                SQL.Add('VALUES(:ID_COMPROMISSO, :DESCRICAO, :DATA_HORA, :LOCAL)');
                ParamByName('ID_COMPROMISSO').Value := ID_COMPROMISSO;
                ParamByName('DESCRICAO').Value := DESCRICAO;
                ParamByName('DATA_HORA').Value := DATA;
                ParamByName('LOCAL').Value := LOCAL;
                ExecSQL;
            end;

            Result := true;
            erro := '';

        except on ex:exception do
        begin
            Result := False;
            erro := 'Erro ao inserir lançamento: ' + ex.Message;
        end;
        end;

    finally
    end;
end;



//EXCLUIR-------------------------------------------
function TCompromissos.Excluir(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    // Validacoes...
    if ID_COMPROMISSO <= 0 then
    begin
        erro := 'Informe o lançamento';
        Result := false;
        exit;
    end;

    try
        try
            qry := TFDQuery.Create(nil);
            qry.Connection := Fconn;

            with qry do
            begin
                Active := false;
                SQL.Clear;
                SQL.Add('DELETE FROM TAB_COMPROMISSOS');
                SQL.Add('WHERE ID_COMPROMISSO = :ID_COMPROMISSO');
                ParamByName('ID_COMPROMISSO').Value := ID_COMPROMISSO;
                ExecSQL;
            end;

            Result := true;
            erro := '';

        except on ex:exception do
        begin
            Result := False;
            erro := 'Erro ao excluir o compromisso: ' + ex.Message;
        end;
        end;

    finally
        qry.DisposeOf;
    end;
end;




//LISTAR COMPROMISSO-----------------------------------

function TCompromissos.ListarCompromissos(qtd_result: integer;
                                      out erro: string): TFDQuery;

var
    qry : TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Fconn;

        with qry do
        begin
            Active := false;
            sql.Clear;
            sql.Add('SELECT C.DESCRICAO AS DESCRICAO_CATEGORIA, C.DATA_HORA, C.LOCAL');
            sql.Add('FROM TAB_COMPROMISSOS C');
            sql.Add('WHERE 1 = 1');

            if ID_COMPROMISSO > 0 then
            begin
                SQL.Add('AND C.ID_COMPROMISSO = :ID_COMPROMISSO');
                ParamByName('ID_COMPROMISSO').Value := ID_COMPROMISSO;
            end;

            if qtd_result > 0 then
                sql.Add('LIMIT ' + qtd_result.ToString);

            Active := true;
        end;

        Result := qry;
        erro := '';

    except on ex:exception do
    begin
        Result := nil;
        erro := 'Erro ao consultar compromissos: ' + ex.Message;
    end;
    end;
end;


//LISTAR RESUMO-----------------


function TCompromissos.ListarResumo(out erro: string): TFDQuery;
var
    qry : TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Fconn;

        with qry do
        begin
            Active := false;
            sql.Clear;
            sql.Add('SELECT C.DESCRICAO, C.DATA_HORA, C.LOCAL');
            sql.Add('FROM    TAB_COMPROMISSO C');
            Active := true;
        end;

        Result := qry;
        erro := '';

    except on ex:exception do
    begin
        Result := nil;
        erro := 'Erro ao consultar Compromissos: ' + ex.Message;
    end;
    end;
end;

end.
