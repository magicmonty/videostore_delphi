program VideoStoreTest;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  uMovie in 'uMovie.pas',
  uCustomer in 'uCustomer.pas',
  uRental in 'uRental.pas',
  uTestVideoStore in 'uTestVideoStore.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
end.

