library dSpecSpecificationsLib;

uses
  TestFramework,
  dSpecBehaviours in 'dSpecBehaviours.pas',
  Specifiers in '..\source\Specifiers.pas',
  BaseObjects in '..\source\BaseObjects.pas',
  dSpec in '..\source\dSpec.pas',
  dSpecIntf in '..\source\dSpecIntf.pas',
  dSpecUtils in '..\source\dSpecUtils.pas',
  FailureMessages in '..\source\FailureMessages.pas',
  Modifiers in '..\source\Modifiers.pas',
  AutoDocObjects in '..\source\AutoDocObjects.pas';

{$R *.res}

{$DEFINE TESTPROJECT}

exports
  RegisteredTests name 'Test';

begin
end.
