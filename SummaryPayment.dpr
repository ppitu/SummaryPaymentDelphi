program SummaryPayment;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainWindow in 'MainWindow.pas' {Form1} ,
  DatabaseForm in 'Database\DatabaseForm.pas' {FormDatabase} ,
  ProductForm in 'Form\ProductForm.pas' {FormProduct} ,
  DataAccess in 'Database\DataAccess.pas',
  Error in 'CommonCode\Error\Error.pas',
  Product in 'CommonCode\Class\Product.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormDatabase, FormDatabase);
  Application.CreateForm(TFormProduct, FormProduct);
  Application.Run;

end.
