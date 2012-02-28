unit TestRSSParser;

interface

uses
  TestFramework;

type
  TRSSParserTest = class(TTestCase)
  published
    procedure ItParsesRSSFeed;
  end;

implementation


{ TRSSParserTest }

procedure TRSSParserTest.ItParsesRSSFeed;
var
  FeedContent: string;
begin
  FeedContent := '';  // TODO: Load dummy feed content
  // THIS TEST IS PENDING
  // ParseRSSFeed(FeedContent);
end;

initialization
  RegisterTest(TRSSParserTest.Suite);

end.
