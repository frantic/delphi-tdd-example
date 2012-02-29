unit TestHttpClient;

interface

uses
  TestFramework, HttpClient;

type
  THttpClientTest = class(TTestCase)
  private
    procedure RequestDeadServer;
    procedure Request404Page;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ItGetsContentByURL;
    procedure ItRaisesAnExceptionWhenServerIsDown;
    procedure ItRaisesAnExceptionWhenServerReturnsError;
  end;

implementation

uses IndyHttpClient;

{ THttpClientTest }

procedure THttpClientTest.ItGetsContentByURL;
var Response: string;
begin
  Response := DefaultHttpClient.GetPageByURL('http://delphi.frantic.im/feed/');
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
  DefaultHttpClient.GetPageByURL('http://delphi.frantic.im/404');
end;

procedure THttpClientTest.RequestDeadServer;
begin
  DefaultHttpClient.GetPageByURL('http://127.0.0.1:9919/');
end;

procedure THttpClientTest.SetUp;
begin
  DefaultHttpClient := TIndyHttpClient.Create;
end;

procedure THttpClientTest.TearDown;
begin
  DefaultHttpClient := nil;
end;

initialization
  RegisterTest(THttpClientTest.Suite);

end.

