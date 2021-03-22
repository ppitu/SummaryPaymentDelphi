unit Error;

interface

uses
  System.Classes;

procedure SaveToFile(className, message: String);

implementation

procedure SaveToFile(className: String; message: String);
var
  text: TStringList;
begin
  text := TStringList.Create;

  try
    text.Add(className);
    text.Add(message);
    text.SaveToFile('log');
  finally
    text.Free;
  end;
end;

end.
