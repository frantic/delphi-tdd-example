unit TestHttpClient;

interface

uses
  TestFramework, HttpClient;

type
  THttpClientTest = class(TTestCase)
  published
    procedure ItGetsContentByURL;
  end;

implementation

{ THttpClientTest }

procedure THttpClientTest.ItGetsContentByURL;
var Response: string;
begin
  Response := GetPageByURL('http://delphi.frantic.im/feed/');
  CheckNotEquals(0, Pos('<rss', Response), 'Response doesnt contain RSS feed');
end;

initialization
  RegisterTest(THttpClientTest.Suite);

end.

