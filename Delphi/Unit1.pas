unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  DataSnap.DBClient, ADODB, JSON, Config;

type
  TForm1 = class(TForm)
  private
    ADOConnection1: TADOConnection;
  public
    function GetEmployees: TJSONArray;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.GetEmployees: TJSONArray;
var
  ADOQuery: TADOQuery;
  JSONEmployees: TJSONArray;
  JSONEmployee: TJSONObject;
begin
  ADOQuery := TADOQuery.Create(nil);
  try
    ADOQuery.Connection := ADOConnection1;
    ADOQuery.SQL.Text := 'SELECT EmployeeNumber, LastName, FirstName, MiddleName, Department, Salary FROM Employees';
    ADOQuery.Open;
    JSONEmployees := TJSONArray.Create;
    while not ADOQuery.EOF do
    begin
      JSONEmployee := TJSONObject.Create;
      JSONEmployee.AddPair('EmployeeNumber', VarToStr(ADOQuery.FieldByName('EmployeeNumber').Value));
      JSONEmployee.AddPair('LastName', ADOQuery.FieldByName('LastName').AsString);
      JSONEmployee.AddPair('FirstName', ADOQuery.FieldByName('FirstName').AsString);
      JSONEmployee.AddPair('MiddleName', ADOQuery.FieldByName('MiddleName').AsString);
      JSONEmployee.AddPair('Department', ADOQuery.FieldByName('Department').AsString);
      JSONEmployee.AddPair('Salary', VarToStr(ADOQuery.FieldByName('Salary').Value));
      JSONEmployees.AddElement(JSONEmployee);
      ADOQuery.Next;
    end;
  finally
    ADOQuery.Free;
  end;
  Result := JSONEmployees;
end;

end.
