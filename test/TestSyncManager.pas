unit TestSyncManager;

interface

uses
  TestFramework, SyncManager, RssModel,
  SysUtils,
  HttpClient, FakeHttpClient,
  RssParser, FakeRSSParser,
  UINotification, FakeUINotification,
  RssStorage, FakeRSSStorage;

type
  TSyncManagerTest = class(TTestCase)
  private
    FRSSFeed: TRSSFeed;
    FFirstFeedItem: TRSSItem;
    FSecondFeedItem: TRSSItem;

    FFakeHttpClient: TFakeHttpClient;
    FFakeRSSParser: TFakeRSSParser;
    FFakeUINotification: TFakeUINotificationService;
    FFakeRSSStorage: TFakeRSSStorage;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ItGetsAndStoresNewItemsWithNotification;
  end;


implementation

{ TSyncManagerTest }

procedure TSyncManagerTest.ItGetsAndStoresNewItemsWithNotification;
var
  StoredItemsCount: Integer;
  NotificationsCount: Integer;
begin
  // HttpClient will return some dummy XML
  FFakeHttpClient.OnGetPageByURL :=
    function (URL: string): string
    begin
      CheckEquals('http://delphi.frantic.im/feed/', URL);
      Result := 'SomeXML';
    end;

  // Parser should be called with that dummy XML
  FFakeRSSParser.OnParseRSSFeed :=
    function (XML: string): TRSSFeed
    begin
      CheckEquals('SomeXML', XML);
      Result := FRSSFeed;
    end;

  // Storage should receive both items from RSS
  StoredItemsCount := 0;
  FFakeRSSStorage.OnStoreItem :=
    procedure (Item: TRSSItem)
    begin
      Check((Item = FFirstFeedItem) or (Item = FSecondFeedItem),
        'StoreItem() was called with unknown item');
      Inc(StoredItemsCount);
    end;

  // Sync should call Notify function for each stored item
  FFakeUINotification.OnNotify :=
    procedure (Item: TRSSItem)
    begin
      Check((Item = FFirstFeedItem) or (Item = FSecondFeedItem),
        'Notify() was called with unknown item');
      Inc(NotificationsCount);
    end;
  Sync('http://delphi.frantic.im/feed/');
  CheckEquals(2, StoredItemsCount, 'StoreItem should have been called 2 times');
  CheckEquals(2, NotificationsCount, 'Notify should have been called 2 times');
end;

procedure TSyncManagerTest.SetUp;
begin
  FFakeHttpClient := TFakeHttpClient.Create;
  FFakeRSSParser := TFakeRSSParser.Create;
  FFakeUINotification := TFakeUINotificationService.Create;
  FFakeRSSStorage := TFakeRSSStorage.Create;

  DefaultHttpClient := FFakeHttpClient;
  DefaultRSSStorage := FFakeRSSStorage;
  DefaultRSSParser := FFakeRSSParser;
  DefaultUINotification := FFakeUINotification;

  // Construct test data
  FRSSFeed := TRSSFeed.Create;
  FFirstFeedItem := FRSSFeed.AddItem;
  FSecondFeedItem := FRSSFeed.AddItem;
end;

procedure TSyncManagerTest.TearDown;
begin
  DefaultHttpClient := nil;
  DefaultRSSStorage := nil;
  DefaultRSSParser := nil;
  DefaultUINotification := nil;
  FreeAndNil(FRSSFeed);
end;

initialization
  RegisterTest(TSyncManagerTest.Suite);

end.
