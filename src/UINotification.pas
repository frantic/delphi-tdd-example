unit UINotification;

interface

uses
  RssModel, SysUtils;

type
  IUINotificationService = interface
    ['{A8E7E1F7-E60F-465A-9D8C-0B6186CA7A06}']
    procedure Notify(Item: TRSSItem);
    procedure NotifyError(E: Exception);
  end;

var
  DefaultUINotification: IUINotificationService = nil;

implementation

end.
