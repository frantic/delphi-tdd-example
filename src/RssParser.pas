unit RssParser;

interface

uses
  RssModel, SysUtils;

type
  ERSSParserException = class(Exception);

  IRSSParser = interface
    ['{263159EC-F94D-4BA6-9D34-5D93277D4DDC}']
    function ParseRSSFeed(XML: string): TRSSFeed;
  end;

implementation

end.
