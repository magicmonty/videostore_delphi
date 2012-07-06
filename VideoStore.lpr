program VideoStore;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, uCustomer, uMovie, uRental, uTestVideoStore, GuiTestRunner;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

