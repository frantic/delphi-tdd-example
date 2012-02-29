unit FakeRSSStorage;

interface

uses
  RssModel, RssStorage, SysUtils;

type
  TFakeRSSStorageStoreItemStub = reference to procedure (Item: TRSSItem);

  TFakeRSSStorage = class(TInterfacedObject, IRSSStorage)
  public
    OnStoreItem: TFakeRSSStorageStoreItemStub;
    procedure StoreItem(Item: TRSSItem);
  end;

implementation

{ TFakeRSSStorage }

procedure TFakeRSSStorage.StoreItem(Item: TRSSItem);
begin
  if Assigned(OnStoreItem) then
    OnStoreItem(Item);
end;

end.
