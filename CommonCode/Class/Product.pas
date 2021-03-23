unit Product;

interface

uses
  DatabaseForm, DataAccess, Error, SysUtils, Data.DB, Messages, FMX.Dialogs;

type
  TProduct = class
  public
    constructor Create(id: Integer; Name: String); overload;
    constructor Create(id: String); overload;
    procedure SetId(id: Integer);
    procedure SetName(Name: String);
    procedure Save;
    procedure Delete;
    procedure insertDataFromDatabase;
    function GetId: Integer;
    function GetName: String;
  private
    FId: Integer;
    FName: String;
    FDescription: String;
  end;

procedure Remove(dataSource: Data.DB.TDataSource);

implementation

{ TProduct }

constructor TProduct.Create(id: Integer; Name: string);
begin
  FId := id;
  FName := name;
end;

constructor TProduct.Create(id: string);
var
  DataAccess: TDataAccess;
begin
  DataAccess := createTableAccess(TTableType.Products, false);

  DataAccess.Load('id', id);

  DataAccess.Destroy;

  insertDataFromDatabase;

  FMX.Dialogs.ShowMessage(FName);


end;

procedure TProduct.SetId(id: Integer);
begin
  FId := id;
end;

procedure TProduct.SetName(Name: string);
begin
  FName := name;
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
