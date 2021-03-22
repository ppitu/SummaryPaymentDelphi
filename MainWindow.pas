unit MainWindow;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox,
  DatabaseForm, FMX.StdCtrls, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  FMX.Bind.Grid, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, ProductForm, Product,
  FMX.TabControl;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Button2: TButton;
    TabControl1: TTabControl;
    tabProduct: TTabItem;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  FormProduct: TFormProduct;
  Product: TProduct;
begin
  Product := TProduct.Create(-1, '');
  FormProduct := TFormProduct.CreateWithProduct(Self, Product);

  FormProduct.ShowModal;

  Product.SaveToDatabase;

  ShowMessage(Product.GetName);

end;

end.
