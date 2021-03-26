unit DataAccess;

interface

uses
  Data.DB, DatabaseForm, FireDAC.Comp.Client, Error, SysUtils, Messages, FMX.Dialogs;

type
  TDataAccess = class
  public
    constructor Create(dataSet: TDataSet; close: Boolean);
    destructor Destroy; override;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure Refresh;
    procedure SetInt(field: String; value: Integer);
    procedure SetString(field, value: String);
    procedure SetCurrency(field: String; value: Currency);
    function Load(field, value: String): Boolean;
    function GetInt(field: String): Integer;
    function GetString(field: String): String;
    function GetCurrency(field: String): Currency;

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

procedure TDataAccess.Edit;
begin
  try
    FDataSet.Edit;
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

function TDataAccess.Load(field: String; value: String): Boolean;
var
  locateOptions: TLocateOptions;
begin
  if not FDataSet.Active then
    FDataSet.Open;
  try
    result := FDataSet.Locate(field, value, locateOptions);
  except
    on E: Exception do
      Error.SaveToFile(E.ClassName, E.Message);
  end;
  result := false;
end;

procedure TDataAccess.SetInt(field: string; value: Integer);
begin
  FDataSet.FieldByName(field).AsInteger := value;
end;

procedure TDataAccess.SetString(field: String; value: String);
begin
  FDataSet.FieldByName(field).AsString := value;
end;

procedure TDataAccess.SetCurrency(field: string; value: Currency);
begin
  FDataSet.FieldByName(field).AsCurrency := value;
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

function TDataAccess.GetString(field: string): String;
begin
  try
    result := FDataSet.FieldByName(field).AsString;
  except
    on E: Exception do
    begin
      Error.SaveToFile(E.ClassName, E.Message);
      result := '';
    end;
  end;
end;

function TDataAccess.GetCurrency(field: string): Currency;
begin
  try
    Result := FDataSet.FieldByName(field).AsCurrency;
  except
    on E: Exception do
    begin
      Error.SaveToFile(E.ClassName, E.Message);
      Result := 0;
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
