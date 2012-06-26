unit uRental;

interface

uses
  uMovie;

type
  TRental = class
  strict private
    FMovie: TMovie;
    FDaysRented: Integer;
  public
    property Movie: TMovie read FMovie;
    property DaysRented: Integer read FDaysRented;

    constructor Create(const AMovie: TMovie; const ADaysRented: Integer);
    destructor Destroy; override;
  end;

implementation

constructor TRental.Create(const AMovie: TMovie; const ADaysRented: Integer);
begin
  inherited Create;
  FMovie := AMovie;
  FDaysRented := ADaysRented;
end;

destructor TRental.Destroy;
begin
  FMovie.Free;
  inherited Destroy;
end;

end.

