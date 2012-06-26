unit uMovie;

interface

type
  TMovieType = (mtRegular, mtNewRelease, mtChildrens);

  TMovie = class
  strict private
    FMovieType: TMovieType;
    FTitle: string;
  public
    property MovieType: TMovieType read FMovieType write FMovieType;
    property Title: string read FTitle;

    constructor Create(const ATitle: string; const AMovieType: TMovieType);
  end;

implementation

{ TMovie }

constructor TMovie.Create(const ATitle: string; const AMovieType: TMovieType);
begin
  inherited Create;
  
  FTitle := ATitle;
  FMovieType := AMovieType;
end;

end.
