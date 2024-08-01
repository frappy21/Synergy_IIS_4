$(document).ready(function() {
    function loadEmployees() {
      $.ajax({
        url: 'http://127.0.0.1/GetEmployees',
        type: 'GET',
        success: function(data) {
          let employees = data;
          let tableBody = $('#employeeTable tbody');
          tableBody.empty();
  
          employees.forEach(employee => {
            let row = $('<tr>');
            row.append('<td>' + employee.EmployeeNumber + '</td>');
            row.append('<td>' + employee.LastName + '</td>');
            row.append('<td>' + employee.FirstName + '</td>');
            row.append('<td>' + employee.MiddleName + '</td>');
            row.append('<td>' + employee.Department + '</td>');
            row.append('<td>' + employee.Salary + '</td>');
            tableBody.append(row);
          });
        }
      });
    }
  
    loadEmployees();
  });
  