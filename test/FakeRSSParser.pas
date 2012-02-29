unit FakeRSSParser;

interface

uses
  RssParser, RssModel, SysUtils;

type
  TFakeRssParserProcStub = reference to function(XML: string): TRSSFeed;

  TFakeRSSParser = class(TInterfacedObject, IRSSParser)
  public
    OnParseRSSFeed: TFakeRssParserProcStub;
    function ParseRSSFeed(XML: string): TRSSFeed;
  end;

implementation

{ TFakeRSSParser }

function TFakeRSSParser.ParseRSSFeed(XML: string): TRSSFeed;
begin
  if Assigned(OnParseRSSFeed) then
    Result := OnParseRSSFeed(XML)
  else
    raise Exception.Create('No stub for "ParseRSSFeed"');
end;

end.
