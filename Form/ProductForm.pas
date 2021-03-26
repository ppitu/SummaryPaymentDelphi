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
    edtDescription: TEdit;
    edtPrice: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
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

procedure TFormProduct.btnCancelClick(Sender: TObject);
begin
  Close();
end;

procedure TFormProduct.btnOKClick(Sender: TObject);
begin
  FProduct.SetName(edtName.Text);
  FProduct.SetDescription(edtdescription.Text);
  FProduct.SetPrice(StrToCurr(edtPrice.Text));
  Close();
end;

constructor TFormProduct.CreateWithProduct(AOwner: TComponent;
  var Product: TProduct);
begin
  inherited Create(AOwner);
  FProduct := Product;
end;

procedure TFormProduct.FormShow(Sender: TObject);
begin
  edtName.Text := FProduct.GetName;
  edtDescription.Text := FProduct.GetDescription;
  edtPrice.Text := CurrToStr(FProduct.GetPrice);
end;

end.
