unit uTestVideoStore;

interface

uses
  Classes,
  fpcunit, testregistry,
  uMovie, uRental, uCustomer;

type
  TestVideoStore = class(TTestCase)
  strict private
    FCustomer: TCustomer;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSingleNewReleaseStatement;
    procedure TestDualNewReleaseStatement;
    procedure TestSingleChildrenStatement;
    procedure TestMultipleRegularStatement;
  end;

implementation

procedure TestVideoStore.SetUp;
begin
  FCustomer := TCustomer.Create('Fred');
end;

procedure TestVideoStore.TearDown;
begin
  FCustomer.Free;
  FCustomer := nil;
end;

procedure TestVideoStore.TestSingleNewReleaseStatement;
begin
  FCustomer.AddRental(TRental.Create(TMovie.Create('The Cell', mtNewRelease), 3));
  CheckEquals('Rental Record for Fred' + #13#10 + #9 + 'The Cell' + #9 + '9.00' + #13#10 + 'You owed 9.00' + #13#10 + 'You earned 2 frequent renter points' + #13#10, FCustomer.Statement);
end;

procedure TestVideoStore.TestDualNewReleaseStatement;
begin
  FCustomer.AddRental(TRental.Create(TMovie.Create('The Cell', mtNewRelease), 3));
  FCustomer.AddRental(TRental.Create(TMovie.Create('The Tigger Movie', mtNewRelease), 3));
  CheckEquals('Rental Record for Fred' + #13#10 + #9 + 'The Cell' + #9 + '9.00' + #13#10 + #9 + 'The Tigger Movie' + #9 + '9.00' + #13#10 + 'You owed 18.00' + #13#10 + 'You earned 4 frequent renter points' + #13#10, FCustomer.Statement);
end;

procedure TestVideoStore.TestSingleChildrenStatement;
begin
  FCustomer.AddRental(TRental.Create(TMovie.Create('The Tigger Movie', mtChildrens), 3));
  CheckEquals('Rental Record for Fred' + #13#10 + #9 + 'The Tigger Movie' + #9 + '1.50' + #13#10 + 'You owed 1.50' + #13#10 + 'You earned 1 frequent renter points' + #13#10, FCustomer.Statement);
end;

procedure TestVideoStore.TestMultipleRegularStatement;
begin
  FCustomer.AddRental(TRental.Create(TMovie.Create('Plan 9 from Outer Space', mtRegular), 1));
  FCustomer.AddRental(TRental.Create(TMovie.Create('8 1/2', mtRegular), 2));
  Fcustomer.addRental(TRental.Create(TMovie.Create('Eraserhead', mtRegular), 3));

  CheckEquals('Rental Record for Fred' + #13#10 + #9 + 'Plan 9 from Outer Space' + #9 + '2.00' + #13#10 + #9 + '8 1/2' + #9 + '2.00' + #13#10 + #9 + 'Eraserhead' + #9 + '3.50' + #13#10 + 'You owed 7.50' + #13#10 + 'You earned 3 frequent renter points' + #13#10, FCustomer.Statement);
end;

initialization
  RegisterTest(TestVideoStore);
end.
