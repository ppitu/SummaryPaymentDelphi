unit DatabaseForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, Data.DB,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TFormDatabase = class(TForm)
    DBConnection: TFDConnection;
    FDTransaction1: TFDTransaction;
    Products: TFDTable;
    Q_product: TFDQuery;
    up_product: TFDUpdateSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TTableType = (Products = 1);

function GetTable(tableType: TTableType): TFDTable;

var
  FormDatabase: TFormDatabase;

implementation

{$R *.fmx}

procedure TFormDatabase.FormCreate(Sender: TObject);
begin
  DBConnection.Open;
  Products.Open('products');
end;

procedure TFormDatabase.FormDestroy(Sender: TObject);
begin
  Products.Close;
  DBConnection.Close;
end;

function GetTable(tableType: TTableType): TFDTable;
begin
  result := FormDatabase.Products;
end;

end.
