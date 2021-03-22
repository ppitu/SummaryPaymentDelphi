unit Product;

interface

uses
  DatabaseForm, DataAccess, Error, SysUtils;

type
  TProduct = class
  public
    constructor Create(id: Integer; Name: String);
    procedure SetId(id: Integer);
    procedure SetName(Name: String);
    procedure SaveToDatabase;
    function GetId: Integer;
    function GetName: String;
  private
    FId: Integer;
    FName: String;
  end;

implementation

{ TProduct }

constructor TProduct.Create(id: Integer; Name: string);
begin
  FId := id;
  FName := name;
end;

procedure TProduct.SetId(id: Integer);
begin
  FId := id;
end;

procedure TProduct.SetName(Name: string);
begin
  FName := name;
end;

procedure TProduct.SaveToDatabase;
var
  DataAccess: TDataAccess;
begin
  DataAccess := createTableAccess(TTableType.PRODUCTS, false);

  try
    DataAccess.Insert;
    DataAccess.SetString('name', FName);
    DataAccess.Post;
  except
    on E: Exception do
    begin
      Error.SaveToFile(E.ClassName, E.Message);
      DataAccess.Destroy;
    end;
  end;

  FId := DataAccess.GetInt('id');

  DataAccess.Refresh;
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

end.
