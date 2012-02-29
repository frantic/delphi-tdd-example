unit TestHttpClient;

interface

uses
  TestFramework, HttpClient;

type
  THttpClientTest = class(TTestCase)
  private
    procedure RequestDeadServer;
    procedure Request404Page;
  published
    procedure ItGetsContentByURL;
    procedure ItRaisesAnExceptionWhenServerIsDown;
    procedure ItRaisesAnExceptionWhenServerReturnsError;
  end;

implementation

{ THttpClientTest }

procedure THttpClientTest.ItGetsContentByURL;
var Response: string;
begin
  Response := GetPageByURL('http://delphi.frantic.im/feed/');
  CheckNotEquals(0, Pos('<rss', Response), 'Response doesnt contain RSS feed');
end;

procedure THttpClientTest.ItRaisesAnExceptionWhenServerIsDown;
begin
  CheckException(RequestDeadServer, EHttpClientException);
end;

procedure THttpClientTest.ItRaisesAnExceptionWhenServerReturnsError;
begin
  CheckException(Request404Page, EHttpClientException);
end;

procedure THttpClientTest.Request404Page;
begin
  GetPageByURL('http://delphi.frantic.im/404');
end;

procedure THttpClientTest.RequestDeadServer;
begin
  GetPageByURL('http://127.0.0.1:9919/');
end;

initialization
  RegisterTest(THttpClientTest.Suite);

end.

