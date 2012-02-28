unit TestRSSParser;

interface

uses
  TestFramework;

type
  TRSSParserTest = class(TTestCase)
  published
    procedure ItParsesRSSDate1;
    procedure ItParsesRSSDate2;
    procedure ItParsesRSSFeed;
  end;

implementation

uses
  SysUtils, IOUtils,  RssModel, RssParser, StrUtils;

{ TRSSParserTest }

procedure TRSSParserTest.ItParsesRSSDate1;
var
  d: TDateTime;
begin
  d := ParseRSSDate('Mon, 06 Sep 2009 16:45:00 +0000');
  CheckEquals('2009-09-06 16:45:00', FormatDateTime('yyyy-mm-dd hh:nn:ss', d));
end;

procedure TRSSParserTest.ItParsesRSSDate2;
var
  d: TDateTime;
begin
  d := ParseRSSDate('Sat, 25 Feb 2012 15:30:18 +0000');
  CheckEquals('2012-02-25 15:30:18', FormatDateTime('yyyy-mm-dd hh:nn:ss', d));
end;

procedure TRSSParserTest.ItParsesRSSFeed;
var
  FeedContent: string;
  RSSFeed: TRSSFeed;
  FirstItem: TRSSItem;
begin
  FeedContent := IOUtils.TFile.ReadAllText('feed.xml', TEncoding.UTF8);
  RSSFeed := ParseRSSFeed(FeedContent);
  CheckEquals('Delphi Zen', RSSFeed.Title);
  CheckEquals('http://delphi.frantic.im', RSSFeed.Link);
  CheckEquals('Food for thoughts', RSSFeed.Description);
  CheckEquals(9, RSSFeed.Items.Count);

  FirstItem := RSSFeed.Items[0];
  CheckEquals('Используете ли вы Unit-testing/TDD при разработке проектов на Delphi?',
    FirstItem.Title);
  CheckEquals('http://delphi.frantic.im/do-you-use-td/', FirstItem.Link);
  CheckTrue(ContainsText(FirstItem.Description, 'delphifeeds.ru'));
  CheckEquals('2012-02-25 15:30:18', FormatDateTime('yyyy-mm-dd hh:nn:ss', FirstItem.PubDate));
end;

initialization
  RegisterTest(TRSSParserTest.Suite);

end.
