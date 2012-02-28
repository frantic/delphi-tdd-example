unit HttpClient;

interface

function GetPageByURL(URL: string): string;

implementation

uses IdHTTP, SysUtils, Classes;

function GetPageByURL(URL: string): string;
var
  HTTP: TIdHTTP;
  Stream: TStringStream;
begin
  HTTP := TIdHTTP.Create;
  Stream := TStringStream.Create;
  try
    HTTP.Get(URL, Stream);
    Result := Stream.DataString;
  finally
    FreeAndNil(HTTP);
    FreeAndNil(Stream);
  end;
end;

end.
