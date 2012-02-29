unit FakeHttpClient;

interface

uses
  HttpClient, SysUtils;

type
  TFakeHttpClientProcStub = reference to function(URL: string): string;

  TFakeHttpClient = class(TInterfacedObject, IHttpClient)
  public
    OnGetPageByURL: TFakeHttpClientProcStub;
    function GetPageByURL(URL: string): string;
  end;

implementation

{ TFakeHttpClient }

function TFakeHttpClient.GetPageByURL(URL: string): string;
begin
  if Assigned(OnGetPageByURL) then
    Result := OnGetPageByURL(URL)
  else
    raise Exception.Create('No stub for "GetPageByURL"');
end;

end.
