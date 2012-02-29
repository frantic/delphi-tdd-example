unit TestSyncManager;

interface

uses
  TestFramework, SyncManager;

type
  TSyncManagerTest = class(TTestCase)
  published
    procedure ItGetsAndStoresNewItemsWithNotification;
  end;


implementation

{ TSyncManagerTest }

procedure TSyncManagerTest.ItGetsAndStoresNewItemsWithNotification;
begin
  Sync('http://delphi.frantic.im/feed/');
end;

initialization
  RegisterTest(TSyncManagerTest.Suite);

end.
