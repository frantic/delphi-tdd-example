unit HttpClient;

interface

uses
  Classes, SysUtils;

type
  EHttpClientException = class(Exception);

function GetPageByURL(URL: string): string;

implementation

uses IdHTTP;

function GetPageByURL(URL: string): string;
var
  HTTP: TIdHTTP;
  Stream: TStringStream;
begin
  HTTP := TIdHTTP.Create;
  Stream := TStringStream.Create;
  try
    try
      HTTP.Get(URL, Stream);
    except
      on E: Exception do
        raise EHttpClientException.Create(E.Message);
    end;
    Result := Stream.DataString;
  finally
    FreeAndNil(HTTP);
    FreeAndNil(Stream);
  end
end;

end.
