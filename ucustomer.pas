unit uCustomer;

interface

uses
  Classes,
  uRental,
  uMovie;

type
  TCustomer = class(TObject)
  strict private
    FName: string;
    FRentals: TList;
  public
    property Name: string read FName;

    constructor Create(const AName: string);
    destructor Destroy; override;

    procedure AddRental(ARental: TRental);
    function Statement: string;
  end;

implementation

uses
  SysUtils;

constructor TCustomer.Create(const AName: string);
begin
  inherited Create;

  FName := AName;
  FRentals := TList.Create;
end;

destructor TCustomer.Destroy;
begin
  while FRentals.Count > 0 do
  begin
    TRental(FRentals[0]).Free;
    FRentals.Delete(0);
  end;

  FRentals.Free;
  inherited Destroy;
end;

procedure TCustomer.AddRental(ARental: TRental);
begin
  FRentals.Add(ARental);
end;

function TCustomer.Statement: string;
var
  TotalAmount: Double;
  ThisAmount: Double;
  FrequentRenterPoints: Integer;
  Enumeration: TListEnumerator;
  Each: TRental;
begin
  TotalAmount := 0;
  FrequentRenterPoints := 0;
  Result := 'Rental Record for ' + Name + #13#10;

  Enumeration := FRentals.GetEnumerator;
  try
    while Enumeration.MoveNext do
    begin
      ThisAmount := 0;
      Each := TRental(Enumeration.Current);

      case Each.Movie.MovieType of
        mtRegular:
          begin
            ThisAmount := ThisAmount + 2;
            if Each.DaysRented > 2 then
              ThisAmount := ThisAmount + (Each.DaysRented - 2) * 1.5;
          end;

        mtNewRelease:
          ThisAmount := ThisAmount + Each.DaysRented * 3;

        mtChildrens:
          begin
            ThisAmount := ThisAmount + 1.5;
            if Each.DaysRented > 3 then
              ThisAmount := ThisAmount + (Each.DaysRented - 3) * 1.5;
          end;
      end;

      Inc(FrequentRenterPoints);
      if (Each.Movie.MovieType = mtNewRelease) and (Each.DaysRented > 1) then
        Inc(FrequentRenterPoints);

      Result := Result + Format(#9 + '%s' + #9 + '%f' + #13#10, [Each.Movie.Title, ThisAmount]);

      TotalAmount := TotalAmount + ThisAmount;
    end;

    Result := Result + Format('You owed %f' + #13#10, [TotalAmount]);
    Result := Result + Format('You earned %d frequent renter points' + #13#10, [FrequentRenterPoints]);
  finally
    Enumeration.Free;
  end;
end;

end.
