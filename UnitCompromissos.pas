unit UnitCompromissos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.DateTimeCtrls,
  FMX.Edit, FMX.Layouts, System.Notification, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdTime;

type
  TFrmCompromissos = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Line1: TLine;
    EditComp: TEdit;
    EditLocal: TEdit;
    Layout1: TLayout;
    img_save: TImage;
    img_voltar: TImage;
    Label5: TLabel;
    DateEdit1: TDateEdit;
    procedure img_saveClick(Sender: TObject);
    procedure img_voltarClick(Sender: TObject);
  private
    { Private declarations }
  public
  modo : string;
  id_lanc : Integer;
    { Public declarations }
  end;

var
  FrmCompromissos: TFrmCompromissos;

implementation

{$R *.fmx}

uses cCategoria, cCompromissos, uFormat,
  UnitCategorias, UnitCategoriasCad, UnitComboCategoria, UnitDM, UnitLogin,UnitPrincipal;




procedure TFrmCompromissos.img_saveClick(Sender: TObject);
var
  comp : TCompromissos;
    erro : string;
begin
  try

    if (EditComp.Text = EmptyStr)  then
    begin
       showmessage('Informe o nome do compromisso.');
      exit;
    end
    else
     if (EditLocal.Text  = EmptyStr) then
     begin
       showmessage('Informe o local do compromisso.');
      exit;
     end;





    comp := TCompromissos.Create(dm.conn);
        comp.DESCRICAO := EditComp.Text;
        comp.LOCAL := EditLocal.Text;
        comp.DATA := DateEdit1.Date;

        {$IFDEF AUTOREFCOUNT}
        //comp.ID_COMPROMISSO := TIntegerWrapper(cmb_compromisso.Items.Objects[cmb_compromisso.ItemIndex]).Value;
        {$ELSE}
        //comp.ID_COMPROMISSO := Integer(cmb_compromisso.Items.Objects[cmb_compromisso.ItemIndex]);
        {$ENDIF}



        if modo = 'I' then
            comp.Inserir(erro)
        else
        begin
            comp.ID_COMPROMISSO := id_lanc;
            //comp.Alterar(erro);
        end;

        if erro <> '' then
        begin
            showmessage(erro);
            exit;
        end;

        close;

    finally
    end;

end;
procedure TFrmCompromissos.img_voltarClick(Sender: TObject);
begin
  close;
end;





end.
