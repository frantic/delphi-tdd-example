program RSSReader;

uses
  Forms,
  Unit1 in 'src\Unit1.pas' {Form1},
  HttpClient in 'src\HttpClient.pas',
  RssModel in 'src\RssModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
