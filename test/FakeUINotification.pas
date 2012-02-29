unit FakeUINotification;

interface

uses
  UINotification, RssModel, SysUtils;

type
  TFakeNotificationProcStub = reference to procedure(Item: TRSSItem);
  TFakeErrorNotificationProcStub = reference to procedure(E: Exception);

  TFakeUINotificationService = class(TInterfacedObject, IUINotificationService)
  public
    OnNotify: TFakeNotificationProcStub;
    OnNotifyError: TFakeErrorNotificationProcStub;

    procedure Notify(Item: TRSSItem);
    procedure NotifyError(E: Exception);
  end;

implementation

{ TFakeUINotificationService }

procedure TFakeUINotificationService.Notify(Item: TRSSItem);
begin
  if Assigned(OnNotify) then
    OnNotify(Item);
end;

procedure TFakeUINotificationService.NotifyError(E: Exception);
begin
  if Assigned(OnNotifyError) then
    OnNotifyError(E);
end;

end.
