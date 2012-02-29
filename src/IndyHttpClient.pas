unit IndyHttpClient;

interface

uses
  HttpClient;

type
  TIndyHttpClient = class(TInterfacedObject, IHttpClient)
  public
    function GetPageByURL(URL: string): string;
  end;

implementation

uses IdHTTP, SysUtils, Classes;

{ TIndyHttpClient }

function TIndyHttpClient.GetPageByURL(URL: string): string;
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
