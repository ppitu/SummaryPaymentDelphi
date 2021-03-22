unit DataAccess;

interface

uses
  Data.DB, DatabaseForm, FireDAC.Comp.Client, Error, SysUtils;

type
  TDataAccess = class
  public
    constructor Create(dataSet: TDataSet; close: Boolean);
    destructor Destroy; override;
    procedure Insert;
    procedure Post;
    procedure SetString(field, value: String);

  private
    FDataSet: TDataSet;
    FClose: Boolean;
  end;

function createTableAccess(tableType: TTableType; close: Boolean): TDataAccess;

implementation

constructor TDataAccess.Create(dataSet: TDataSet; close: Boolean);
begin
  FDataSet := dataSet;
  FClose := close;
end;

destructor TDataAccess.Destroy;
begin
  if FClose then
    FDataSet.close;

end;

procedure TDataAccess.Insert;
begin
  try
    FDataSet.Insert;
  except
    on E: Exception do
    begin
      Error.SaveToFile(E.ClassName, E.Message);
    end;
  end;
end;

procedure TDataAccess.Post;
begin
  try
    FDataSet.Post;
  except
    on E: Exception do
      Error.SaveToFile(E.ClassName, E.Message);
  end;
end;

procedure TDataAccess.SetString(field: String; value: String);
begin
  FDataSet.FieldByName(field).AsString := value;
end;

function createTableAccess(tableType: TTableType; close: Boolean): TDataAccess;
var
  table: TFDTable;
begin
  table := GetTable(tableType);
  if not table.Active then
    table.Open;

  result := TDataAccess.Create(table, close);
end;

end.
