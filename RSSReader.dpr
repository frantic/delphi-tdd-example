program RSSReader;

uses
  Forms,
  Unit1 in 'src\Unit1.pas' {Form1},
  HttpClient in 'src\HttpClient.pas',
  RssModel in 'src\RssModel.pas',
  RssParser in 'src\RssParser.pas',
  IndyHttpClient in 'src\IndyHttpClient.pas',
  XmlDocRssParser in 'src\XmlDocRssParser.pas',
  SyncManager in 'src\SyncManager.pas',
  UINotification in 'src\UINotification.pas',
  RssStorage in 'src\RssStorage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
