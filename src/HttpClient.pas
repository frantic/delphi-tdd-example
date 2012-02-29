unit HttpClient;

interface

uses
  SysUtils;

type
  EHttpClientException = class(Exception);

  IHttpClient = interface
    ['{CDE443FE-8249-4557-8F26-D0EC6432F274}']
    function GetPageByURL(URL: string): string;
  end;

var
  DefaultHttpClient: IHttpClient;

implementation

end.
