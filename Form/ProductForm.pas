unit ProductForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, Product;

type
  TFormProduct = class(TForm)
    edtName: TEdit;
    lblName: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateWithProduct(AOwner: TComponent; var Product: TProduct);
  end;

var
  FormProduct: TFormProduct;

  FProduct: TProduct;

implementation

{$R *.fmx}

constructor TFormProduct.CreateWithProduct(AOwner: TComponent;
  var Product: TProduct);
begin
  inherited Create(AOwner);
  FProduct := Product;
end;

procedure TFormProduct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FProduct.SetName(edtName.Text);
end;

end.
