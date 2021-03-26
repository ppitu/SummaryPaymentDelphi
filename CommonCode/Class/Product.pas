unit Product;

interface

uses
  DatabaseForm, DataAccess, Error, SysUtils, Data.DB, Messages, FMX.Dialogs;

type
  TProduct = class
  public
    constructor Create(id: Integer; Name, Description: String; Price: Currency); overload;
    constructor Create(id: String); overload;
    procedure SetId(id: Integer);
    procedure SetName(Name: String);
    procedure SetDescription(Description: String);
    procedure SetPrice(Price: Currency);
    procedure Save;
    procedure Update;
    procedure Delete;
    procedure insertDataFromDatabase;
    function GetId: Integer;
    function GetName: String;
    function GetDescription: String;
    function GetPrice: Currency;
  private
    FId: Integer;
    FName: String;
    FDescription: String;
    FPrice: Currency;
  end;

procedure Remove(dataSource: Data.DB.TDataSource);

implementation

{ TProduct }

constructor TProduct.Create(id: Integer; Name, Description: string; Price: Currency);
begin
  FId := id;
  FName := name;
  FDescription := Description;
  FPrice := Price;
end;

constructor TProduct.Create(id: string);
var
  DataAccess: TDataAccess;
begin
  DataAccess := createTableAccess(TTableType.Products, false);

  DataAccess.Load('id', id);

  DataAccess.Destroy;

  insertDataFromDatabase;
end;

procedure TProduct.SetId(id: Integer);
begin
  FId := id;
end;

procedure TProduct.SetName(Name: string);
begin
  FName := name;
end;

procedure TProduct.SetDescription(Description: string);
begin
  FDescription := Description;
end;

procedure TProduct.SetPrice(Price: Currency);
begin
  FPrice := Price;
end;

procedure TProduct.Save;
var
  DataAccess: TDataAccess;
begin
  DataAccess := createTableAccess(TTableType.Products, false);

  DataAccess.Insert;
  DataAccess.SetString('name', FName);
  DataAccess.Post;

  FId := DataAccess.GetInt('id');

  DataAccess.Refresh;
  DataAccess.Destroy;

end;

procedure TProduct.Update;
var
  DataAccess: TDataAccess;
begin
  DataAccess := createTableAccess(TTableType.Products, false);

  DataAccess.Edit;
  DataAccess.SetInt('id', FId);
  DataAccess.SetString('name', FName);
  DataAccess.SetString('description', FDescription);
  DataAccess.SetCurrency('price', FPrice);
  DataAccess.Post;

  DataAccess.Refresh;
  DataAccess.Destroy;
end;

procedure TProduct.Delete;
var
  DataAccess: TDataAccess;
begin
  DataAccess := createTableAccess(TTableType.Products, false);
  DataAccess.Delete;

  DataAccess.Refresh;
  DataAccess.Destroy;

end;

procedure TProduct.insertDataFromDatabase;
var
  DataAccess: TDataAccess;
begin
  DataAccess := createTableAccess(TTableType.Products, false);

  FId := DataAccess.GetInt('id');
  FName := DataAccess.GetString('name');
  FDescription := DataAccess.GetString('description');
  FPrice := DataAccess.GetCurrency('price');

  DataAccess.Destroy;
end;

function TProduct.GetId;
begin
  Result := FId;
end;

function TProduct.GetName;
begin
  Result := FName;
end;

function TProduct.GetDescription;
begin
  Result := FDescription;
end;

function TProduct.GetPrice;
begin
  Result := FPrice;
end;

procedure Remove(dataSource: Data.DB.TDataSource);
begin
  try
    dataSource.DataSet.Delete;
    dataSource.DataSet.Refresh;
  except
    on E: Exception do
    begin
      Error.SaveToFile(E.ClassName, E.Message);
      Messages.showMessage(EMessageValue.MSG_RECORD_REMOVE_ERROR);
    end;
  end;
end;


end.
