unit DataAccess;

interface

uses
  Data.DB, DatabaseForm, FireDAC.Comp.Client, Error, SysUtils, Messages;

type
  TDataAccess = class
  public
    constructor Create(dataSet: TDataSet; close: Boolean);
    destructor Destroy; override;
    procedure Insert;
    procedure Post;
    procedure Delete;
    procedure Refresh;
    procedure SetString(field, value: String);
    function GetInt(field: String): Integer;

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

procedure TDataAccess.Delete;
begin
  try
    FDataSet.Delete;
  except
    on E: Exception do
    begin
      Error.SaveToFile(E.ClassName, E.Message);
      Messages.showMessage(EMessageValue.MSG_RECORD_REMOVE_ERROR);
    end;
  end;
end;

procedure TDataAccess.Refresh;
begin
  FDataSet.close;
  FDataSet.Open;
end;

procedure TDataAccess.SetString(field: String; value: String);
begin
  FDataSet.FieldByName(field).AsString := value;
end;

function TDataAccess.GetInt(field: String): Integer;
begin
  try
    result := FDataSet.FieldByName(field).AsInteger;
  except
    on E: Exception do
    begin
      Error.SaveToFile(E.ClassName, E.Message);
      result := 0;
    end;
  end;
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
