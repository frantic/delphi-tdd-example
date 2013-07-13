unit TestHttpClient;

interface

uses
  TestFramework, HttpClient;

type
  THttpClientTest = class(TTestCase)
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
  ExpectedException := EHttpClientException;
  DefaultHttpClient.GetPageByURL('http://127.0.0.1:9919/');
end;

procedure THttpClientTest.ItRaisesAnExceptionWhenServerReturnsError;
begin
  ExpectedException := EHttpClientException;
  DefaultHttpClient.GetPageByURL('http://delphi.frantic.im/404');
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

