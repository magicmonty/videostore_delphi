program dSpecSpecifications;

uses
  GUITestRunner,
  dSpecBehaviours in 'dSpecBehaviours.pas',
  BaseObjects in '..\source\BaseObjects.pas',
  dSpec in '..\source\dSpec.pas',
  dSpecUtils in '..\source\dSpecUtils.pas',
  FailureMessages in '..\source\FailureMessages.pas',
  Modifiers in '..\source\Modifiers.pas',
  Specifiers in '..\source\Specifiers.pas',
  dSpecIntf in '..\source\dSpecIntf.pas';

{$R *.res}

begin
  GUITestRunner.RunRegisteredTests;
end.
