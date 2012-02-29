unit SyncManager;

interface

procedure Sync(URL: string);

implementation

uses
  HttpClient, RssParser, RssModel, RssStorage, UINotification;

procedure Sync(URL: string);
var
  Xml: string;
  RSS: TRSSFeed;
  i: Integer;
begin
  Xml := DefaultHttpClient.GetPageByURL(URL);
  RSS := DefaultRSSParser.ParseRSSFeed(Xml);
  for i := 0 to RSS.Items.Count - 1 do
  begin
    DefaultRSSStorage.StoreItem(RSS.Items[i]);
    DefaultUINotification.Notify(RSS.Items[i]);
  end;
end;

end.
