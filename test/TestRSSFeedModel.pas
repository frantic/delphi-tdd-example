unit TestRSSFeedModel;

interface

uses
  TestFramework, RssModel;

type
  TRSSFeedModelTest = class(TTestCase)
  private
    FFeed: TRSSFeed;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ItHasTitle;
    procedure ItHasDescription;
    procedure ItHasLink;
    procedure ItHasZeroItemsInitialy;
    procedure ItCanBePopulatedWithSomeItems;
    procedure ItsItemsHaveSomeAttributes;
  end;

implementation

uses
  SysUtils;

{ TRSSFeedModel }

procedure TRSSFeedModelTest.ItCanBePopulatedWithSomeItems;
begin
  FFeed.AddItem;
  FFeed.AddItem;
  CheckEquals(2, FFeed.Items.Count);
end;

procedure TRSSFeedModelTest.ItHasDescription;
begin
  FFeed.Description := 'Some feed';
  CheckEquals('Some feed', FFeed.Description);
end;

procedure TRSSFeedModelTest.ItHasLink;
begin
  FFeed.Link := 'http://some.url.com/';
  CheckEquals('http://some.url.com/', FFeed.Link);
end;

procedure TRSSFeedModelTest.ItHasTitle;
begin
  FFeed.Title := 'Title';
  CheckEquals('Title', FFeed.Title);
end;

procedure TRSSFeedModelTest.ItHasZeroItemsInitialy;
begin
  CheckEquals(0, FFeed.Items.Count);
end;

procedure TRSSFeedModelTest.ItsItemsHaveSomeAttributes;
var
  SomeDay: TDate;
  RssItem: TRSSItem;
begin
  SomeDay := Now;
  with FFeed.AddItem do
  begin
    Title := 'Item title';
    Link := 'http://example.com/';
    Description := 'Some text';
    PubDate := SomeDay;
  end;
  RssItem := FFeed.Items[0];
  CheckEquals('Item title', RssItem.Title);
  CheckEquals('http://example.com/', RssItem.Link);
  CheckEquals('Some text', RssItem.Description);
  CheckEquals(SomeDay, RssItem.PubDate);
end;

procedure TRSSFeedModelTest.SetUp;
begin
  FFeed := TRSSFeed.Create;
end;

procedure TRSSFeedModelTest.TearDown;
begin
  FreeAndNil(FFeed);
end;

initialization
  RegisterTest(TRSSFeedModelTest.Suite);

end.
