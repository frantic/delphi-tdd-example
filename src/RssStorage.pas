unit RssStorage;

interface

uses
  RssModel;

type
  IRSSStorage = interface
    ['{7F674ACD-6322-4419-BCCB-D8788E75ED53}']
    procedure StoreItem(Item: TRSSItem);
  end;

var
  DefaultRSSStorage: IRSSStorage = nil;

implementation

end.
