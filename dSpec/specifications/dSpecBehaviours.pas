(*
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * Contributor(s):
 * Jody Dawkins <jdawkins@delphixtreme.com>
 *)

unit dSpecBehaviours;

interface

uses Classes, dSpec, dSpecIntf;

type
  TAutoDocContext = class(TContext)
  { using a base context simply to turn on AutoDoc }
  public
    constructor Create(MethodName : string); override;
  end;

  AutoDoc = class(TContext)
  private
    FAutoDoc : IAutoDoc;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldDocumentSpecNames;
    procedure ShouldDocumentSpecs;
    procedure ShouldNotOutputAnythingWhenDisabled;
  end;

  Context = class(TAutoDocContext)
  published
    procedure ShouldHaveSpecs;
    procedure ShouldModifyTheEqualSpecifier;
    procedure ShouldEvaluateUnlessModifier;
    procedure ShouldEvaluateToleranceModifier;
    procedure ShouldEvaluateManyModifiers;
    procedure ShouldModifyTheNotEqualSpecifier;
    procedure ShouldAllowMultipleSpecifiers;
    procedure ShouldNegateSpecs;
    procedure ShouldAllowOptionalNamingOfSpecs;
    procedure ShouldHaveAnAutoDocInterface;
    procedure ShouldNotAllowANullAutoDoc;
  end;

  IntegerSpecification = class(TAutoDocContext)
  private
    FInteger: Integer;
  protected
    procedure SetUp; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateEquality;
    procedure ShouldEvaluateInequality;
    procedure ShouldEvaluateRange;
    procedure ShouldEvaluateOdd;
    procedure ShouldEvaluateEven;
    procedure ShouldEvaluatePositive;
    procedure ShouldEvaluateNegative;
    procedure ShouldEvaluatePrime;
    procedure ShouldEvaluateZero;
    procedure ShouldEvaluateComposite;
  end;

  BooleanSpecification = class(TAutoDocContext)
  private
    FBoolean : Boolean;
  protected
    procedure SetUp; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateEquality;
    procedure ShouldEvaluateInequality;
  end;

  FloatSpecification = class(TAutoDocContext)
  private
    FFloat : Extended;
  protected
    procedure SetUp; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateEquality;
    procedure ShouldEvaluateInequality;
    procedure ShouldEvalulateRange;
    procedure ShouldEvaluatePositive;
    procedure ShouldEvaluateNegative;
    procedure ShouldEvaluateZero;
    procedure ShouldEvaluatePercentages;
  end;

  StringSpecification = class(TAutoDocContext)
  private
    FString : string;
  protected
    procedure SetUp; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateEquality;
    procedure ShouldEvaluateInequality;
    procedure ShouldEvaluateNumeric;
    procedure ShouldEvaluateAlpha;
    procedure ShouldEvaluateAlphaNumeric;
    procedure ShouldEvaluateBeginningOfStrings;
    procedure ShouldEvaluateStringContents;
    procedure ShouldEvaluateEndOfStrings;
    procedure ShouldHaveCaseInsentiveModifier;
    procedure ShouldEvaluateEmpty;
  end;

  DateTimeSpecification = class(TAutoDocContext)
  private
    FDateTime : TDateTime;
    FLowDate: TDateTime;
    FHighDate: TDateTime;
  protected
    procedure SetUp; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateEquality;
    procedure ShouldEvaluateInequality;
    procedure ShouldEvalulateRange;
  end;

  ClassSpecification = class(TAutoDocContext)
  private
    FClass : TClass;
  protected
    procedure SetUp; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateInheritance;
    procedure ShouldEvaluateType;
  end;

  ObjectSpecification = class(TAutoDocContext)
  private
    FInterfacedObject : TInterfaceList;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateInheritance;
    procedure ShouldEvaluateType;
    procedure ShouldEvaluateAssignment;
    procedure ShouldEvaluateInterfaceImplementation;
    procedure ShouldEvaluteSupportedInterfaces;
  end;

  PointerSpecification = class(TAutoDocContext)
  private
    FPointer : Pointer;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateAssignment;
  end;

  InterfaceSpecification = class(TAutoDocContext)
  private
    FInterface: IInterfaceList;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ShouldHaveSpecs;
    procedure ShouldEvaluateAssignment;
    procedure ShouldEvaluateSupportedInterfaces;
    procedure ShouldEvaluateImplementingObject;
  end;

implementation

uses SysUtils, TestFramework, AutoDocObjects;


{ TDSpecContext }

constructor TAutoDocContext.Create(MethodName: string);
begin
  inherited Create(MethodName);
  AutoDoc.Enabled := True;
end;

{ TContextBehaviors }

procedure Context.ShouldAllowMultipleSpecifiers;
var
  TheNumber: Integer;
begin
  TheNumber := 3;
  Specify.That(TheNumber).Should.Equal(3).And_.Not_.Equal(2).And_.Not_.Equal(4); // 5 is right out! :P
end;

procedure Context.ShouldHaveAnAutoDocInterface;
var
  ContextIntf: IContext;
begin
  ContextIntf := Self as IContext;
  Specify.That(ContextIntf.AutoDoc, 'AutoDoc').Should.Be.Assigned;
end;

procedure Context.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True);
end;

procedure Context.ShouldAllowOptionalNamingOfSpecs;
var
  Rate: Extended;
begin
  Rate := 0.15;
  Specify.That(Rate, 'Tax rate').Should.Equal(0.15);
end;

procedure Context.ShouldEvaluateManyModifiers;
var
  TheToleranceDoesntMatter: Boolean;
begin
  TheToleranceDoesntMatter := False;
  Specify.That(3.51).Should.Equal(3.5).WithAToleranceOf(0.1).Unless(TheToleranceDoesntMatter);
end;

procedure Context.ShouldEvaluateUnlessModifier;
var
  ImInAnotherUniverse: Boolean;
begin
  ImInAnotherUniverse := False;
  Specify.That(2 + 2).Should.Equal(4).Unless(ImInAnotherUniverse);
end;

procedure Context.ShouldModifyTheEqualSpecifier;
var
  WeAreInSectorZZ9PluralZAlpha: Boolean;
  TheAnwserToLifeTheUniverseAndEverything: Integer;
begin
  WeAreInSectorZZ9PluralZAlpha := False;
  TheAnwserToLifeTheUniverseAndEverything := 42;
  Specify.That(TheAnwserToLifeTheUniverseAndEverything).Should.Equal(42).Unless(WeAreInSectorZZ9PluralZAlpha);
end;

procedure Context.ShouldModifyTheNotEqualSpecifier;
var
  b: Boolean;
  IWantAnError: Boolean;
begin
  b := True;
  IWantAnError := False;
  Specify.That(b).Should.Not_.Equal(True).Unless(IWantAnError);
end;

procedure Context.ShouldNegateSpecs;
begin
  Specify.That(False).Should.Not_.Be.True.And_.Be.False.And_.Not_.Be.True;
  Specify.That(42).Should.Be.AtLeast(40).And_.Not_.Be.GreaterThan(50).And_.Be.LessThan(50);
end;

procedure Context.ShouldNotAllowANullAutoDoc;
var
  ContextIntf: IContext;
begin
  ContextIntf := Self as IContext;
  ContextIntf.AutoDoc := nil;
  { TBaseAutoDoc defaults Enabled to False .. we have to turn it back on  }
  ContextIntf.AutoDoc.Enabled := True;
  Specify.That(ContextIntf.AutoDoc, 'AutoDoc').Should.Be.Assigned;
end;

procedure Context.ShouldEvaluateToleranceModifier;
begin
  Specify.That(3.51).Should.Equal(3.5).WithAToleranceOf(0.1);
end;

{ TIntegerSpecBehaviors }

procedure IntegerSpecification.SetUp;
begin
  FInteger := 42;
  ContextDescription := 'When an integer = 42';
end;

procedure IntegerSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True);
end;

procedure IntegerSpecification.ShouldEvaluateComposite;
begin
  Specify.That(FInteger).Should.Be.Composite;
end;

procedure IntegerSpecification.ShouldEvaluateEquality;
begin
  Specify.That(FInteger).Should.Equal(42)
end;

procedure IntegerSpecification.ShouldEvaluateEven;
begin
  Specify.That(FInteger).Should.Be.Even;
end;

procedure IntegerSpecification.ShouldEvaluateInEquality;
begin
  Specify.That(FInteger).Should.Not_.Equal(0)
end;

procedure IntegerSpecification.ShouldEvaluateNegative;
begin
  Specify.That(FInteger).Should.Not_.Be.Negative;
end;

procedure IntegerSpecification.ShouldEvaluateOdd;
begin
  Specify.That(FInteger).Should.Not_.Be.Odd;
end;

procedure IntegerSpecification.ShouldEvaluatePositive;
begin
  Specify.That(FInteger).Should.Be.Positive;
end;

procedure IntegerSpecification.ShouldEvaluatePrime;
begin
  Specify.That(FInteger).Should.Not_.Be.Prime;
end;

procedure IntegerSpecification.ShouldEvaluateRange;
begin
  Specify.That(FInteger).Should.Be.GreaterThan(40).And_.Be.LessThan(50);
  Specify.That(FInteger).Should.Be.AtLeast(40).And_.Be.AtMost(50);
end;

procedure IntegerSpecification.ShouldEvaluateZero;
begin
  Specify.That(FInteger).Should.Not_.Be.Zero;
end;

{ TBooleanSpecBehaviors }

procedure BooleanSpecification.SetUp;
begin
  FBoolean := True;
  ContextDescription := 'When a boolean = True';
end;

procedure BooleanSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True);
end;

procedure BooleanSpecification.ShouldEvaluateEquality;
begin
  Specify.That(FBoolean).Should.Equal(True);
  Specify.That(FBoolean).Should.Be.True;
end;

procedure BooleanSpecification.ShouldEvaluateInEquality;
begin
  Specify.That(FBoolean).Should.Not_.Equal(False);
  Specify.That(FBoolean).Should.Not_.Be.False;
end;

{ TFloatSpecBehaviors }

procedure FloatSpecification.SetUp;
begin
  FFloat := 1.618;
  ContextDescription := 'When a float = 1.618';
end;

procedure FloatSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True)
end;

procedure FloatSpecification.ShouldEvaluateEquality;
begin
  Specify.That(FFloat).Should.Equal(1.618)
end;

procedure FloatSpecification.ShouldEvaluateInEquality;
begin
  Specify.That(FFloat).Should.Not_.Equal(2)
end;

procedure FloatSpecification.ShouldEvaluateNegative;
begin
  Specify.That(FFloat).Should.Not_.Be.Negative;
end;

procedure FloatSpecification.ShouldEvaluatePercentages;
begin
  Specify.That(FFloat).Should.Equal(161.8).Percent;
end;

procedure FloatSpecification.ShouldEvaluatePositive;
begin
  Specify.That(FFloat).Should.Be.Positive;
end;

procedure FloatSpecification.ShouldEvaluateZero;
begin
  Specify.That(FFloat).Should.Not_.Be.Zero;
end;

procedure FloatSpecification.ShouldEvalulateRange;
begin
  Specify.That(FFloat).Should.Be.GreaterThan(1).And_.Be.LessThan(2);
  Specify.That(FFloat).Should.Be.AtLeast(1).And_.Be.AtMost(2);
end;

{ TStringSpecBehaviors }

procedure StringSpecification.SetUp;
begin
  FString := 'Greetings Footpad!';
  ContextDescription := 'When a string = ''Greetings Footpad!''';
end;

procedure StringSpecification.ShouldHaveCaseInsentiveModifier;
begin
  Specify.That(FString).Should.Equal(UpperCase(FString)).IgnoringCase;
end;

procedure StringSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True)
end;

procedure StringSpecification.ShouldEvaluateAlpha;
begin
  Specify.That(FString).Should.Be.Alpha;
end;

procedure StringSpecification.ShouldEvaluateAlphaNumeric;
begin
  Specify.That(FString).Should.Be.AlphaNumeric;
end;

procedure StringSpecification.ShouldEvaluateBeginningOfStrings;
begin
  Specify.That(FString).Should.StartWith('Greetings');
end;

procedure StringSpecification.ShouldEvaluateEmpty;
begin
  Specify.That(FString).Should.Not_.Be.Empty;
end;

procedure StringSpecification.ShouldEvaluateEndOfStrings;
begin
  Specify.That(FString).Should.EndWith('pad!');
end;

procedure StringSpecification.ShouldEvaluateEquality;
begin
  Specify.That(FString).Should.Equal('Greetings Footpad!');
end;

procedure StringSpecification.ShouldEvaluateInEquality;
begin
  Specify.That(FString).Should.Not_.Equal('');
end;

procedure StringSpecification.ShouldEvaluateNumeric;
begin
  Specify.That(FString).Should.Not_.Be.Numeric;
end;

procedure StringSpecification.ShouldEvaluateStringContents;
begin
  Specify.That(FString).Should.Contain('Foot');
end;

{ TDateTimeSpecBehaviors }

procedure DateTimeSpecification.SetUp;
begin
  FDateTime := EncodeDate(1999, 1, 1);
  FLowDate := EncodeDate(1998, 12, 31);
  FHighDate := EncodeDate(2000, 1, 1);
  ContextDescription := 'When a date = ' + DateToStr(FDateTime);
end;

procedure DateTimeSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True)
end;

procedure DateTimeSpecification.ShouldEvaluateEquality;
begin
  Specify.That(FDateTime).Should.Equal(EncodeDate(1999, 1, 1))
end;

procedure DateTimeSpecification.ShouldEvaluateInEquality;
begin
  Specify.That(FDateTime).Should.Not_.Equal(EncodeDate(1999, 1, 2))
end;

procedure DateTimeSpecification.ShouldEvalulateRange;
begin
  Specify.That(FDateTime).Should.Be.GreaterThan(FLowDate).And_.Be.LessThan(FHighDate);
  Specify.That(FDateTime).Should.Be.AtLeast(FLowDate).And_.Be.AtMost(FHighDate);
end;

{ TClassSpecBehaviors }

procedure ClassSpecification.SetUp;
begin
  FClass := TStringList;
  ContextDescription := 'When a class = TStringList';
end;

procedure ClassSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True);
end;

procedure ClassSpecification.ShouldEvaluateInheritance;
begin
  Specify.That(FClass).Should.DescendFrom(TObject);
end;

procedure ClassSpecification.ShouldEvaluateType;
begin
  Specify.That(FClass).Should.Be.OfType(TStringList)
end;

{ TObjectSpecBehaviors }

procedure ObjectSpecification.SetUp;
begin
  FInterfacedObject := TInterfaceList.Create;
  ContextDescription := 'When an object = TInterfaceList';
end;

procedure ObjectSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True)
end;

procedure ObjectSpecification.ShouldEvaluateAssignment;
begin
  Specify.That(FInterfacedObject).Should.Not_.Be.Nil_;
  Specify.That(FInterfacedObject).Should.Be.Assigned;
  FInterfacedObject := nil; 
  Specify.That(FInterfacedObject).Should.Be.Nil_;
  Specify.That(FInterfacedObject).Should.Not_.Be.Assigned;
end;

procedure ObjectSpecification.ShouldEvaluateInheritance;
begin
  Specify.That(FInterfacedObject).Should.DescendFrom(TObject)
end;

procedure ObjectSpecification.ShouldEvaluateInterfaceImplementation;
begin
  Specify.That(FInterfacedObject).Should.Implement(IInterfaceList);
end;

procedure ObjectSpecification.ShouldEvaluateType;
begin
  Specify.That(FInterfacedObject).Should.Be.OfType(TInterfaceList)
end;

procedure ObjectSpecification.ShouldEvaluteSupportedInterfaces;
begin
  Specify.That(FInterfacedObject).Should.Support(IInterfaceList);
end;

procedure ObjectSpecification.TearDown;
begin
  FInterfacedObject := nil;
end;

{ TPointerSpecBehaviors }

procedure PointerSpecification.SetUp;
begin
  GetMem(FPointer, 255);
  ContextDescription := 'When a pointer = allocated memory';
end;

procedure PointerSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True);
end;

procedure PointerSpecification.ShouldEvaluateAssignment;
begin
  Specify.That(FPointer).Should.Not_.Be.Nil_;
  Specify.That(FPointer).Should.Be.Assigned;
  FreeMem(FPointer, 255);
  FPointer := nil;
  Specify.That(FPointer).Should.Be.Nil_;
  Specify.That(FPointer).Should.Not_.Be.Assigned;
end;

procedure PointerSpecification.TearDown;
begin
  if Assigned(FPointer) then
    FreeMem(FPointer, 255);
end;

{ TInterfaceSpecBehaviors }

procedure InterfaceSpecification.ShouldEvaluateAssignment;
begin
  Specify.That(FInterface).Should.Be.Assigned;
  Specify.That(FInterface).Should.Not_.Be.Nil_;
  FInterface := nil;
  Specify.That(FInterface).Should.Not_.Be.Assigned;
  Specify.That(FInterface).Should.Be.Nil_;
end;

procedure InterfaceSpecification.ShouldEvaluateImplementingObject;
begin
  Specify.That(FInterface).Should.Be.ImplementedBy(TInterfaceList);
end;

procedure InterfaceSpecification.ShouldEvaluateSupportedInterfaces;
begin
  Specify.That(FInterface).Should.Support(IInterfaceList);
end;

procedure InterfaceSpecification.ShouldHaveSpecs;
begin
  Specify.That(True, 'I''ve got specs').Should.Equal(True);
end;

procedure InterfaceSpecification.SetUp;
begin
  FInterface := TInterfaceList.Create;
  ContextDescription := 'When an interface = IInterfaceList';
end;

procedure InterfaceSpecification.TearDown;
begin
  FInterface := nil;
end;

{ AutoDoc }

procedure AutoDoc.SetUp;
begin
  inherited;
  FAutoDoc := TBaseAutoDoc.Create(Self);
  FAutoDoc.Enabled := True;
end;

procedure AutoDoc.ShouldDocumentSpecNames;
var
  SpecDoc: string;
begin
  SpecDoc := FAutoDoc.BeginSpec('AutoDoc', 'ShouldDoSomething');
  Specify.That(SpecDoc, 'SpecDoc').Should.Equal('AutoDoc - Should do something');
end;

procedure AutoDoc.ShouldDocumentSpecs;
var
  SpecDoc: string;
begin
  ContextDescription := 'With IAutoDoc';
  SpecDoc := FAutoDoc.DocSpec('Specify.That(SpecDoc).Should.Not.Be.Empty');
  Specify.That(SpecDoc, 'SpecDoc').Should.Equal('  With IAutoDoc, Specify.That(SpecDoc).Should.Not.Be.Empty');
end;

procedure AutoDoc.ShouldHaveSpecs;
begin
  Specify.That(True, 'Got specs').Should.Be.True;
end;

procedure AutoDoc.ShouldNotOutputAnythingWhenDisabled;
var
  SpecDoc: string;
begin
  FAutoDoc.Enabled := False;
  SpecDoc := FAutoDoc.BeginSpec('AutoDoc', 'DontOutputThis');
  Specify.That(SpecDoc, 'SpecDoc').Should.Be.Empty;
  SpecDoc := FAutoDoc.DocSpec('Don''t output this');
  Specify.That(SpecDoc, 'SpecDoc').Should.Be.Empty;
end;

procedure AutoDoc.TearDown;
begin
  FAutoDoc := nil;
  inherited;
end;

initialization
  RegisterSpec(AutoDoc.Suite);
  RegisterSpec(Context.Suite);
  RegisterSpec(IntegerSpecification.Suite);
  RegisterSpec(BooleanSpecification.Suite);
  RegisterSpec(FloatSpecification.Suite);
  RegisterSpec(StringSpecification.Suite);
  RegisterSpec(DateTimeSpecification.Suite);
  RegisterSpec(ClassSpecification.Suite);
  RegisterSpec(ObjectSpecification.Suite);
  RegisterSpec(PointerSpecification.Suite);
  RegisterSpec(InterfaceSpecification.Suite);

end.
