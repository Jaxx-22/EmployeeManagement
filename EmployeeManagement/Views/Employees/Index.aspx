<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Employees</title>
    <script src="../../Content/Scripts/jquery-1.10.2.min.js"></script>
    <script type='text/javascript'>
        $(document).ready(function () {
            var employees = new Array();
            $.ajax({
                url: "http://localhost:55739/api/employee/all",
                type: "GET",
                success: function (data) {
                    employees = data;
                    for(var i = 0; i > employees.length; i++)
                    {
                        createEmployeeRow(employees[i]);
                    }
                },
                error: function(e)
                {
                    alert(e);
                },
            });            
        });

        function createEmployeeRow(employee) {
            $("<div><span hidden='hidden'>" +
                employee.EmployeeId +
            "</span><span>" +
                employee.Name +
            "</span><span>" +
                 employee.DateOfBirth +
            "</span><span>" +
             employee.SocialSecurityNumber +
            "</span><span> <a onclick=''>Details</a></span><span><a href=''>Fire</a></span></div>").appendTo(".employeeTable");
        }

    </script>
</head>
<body>
    <div>
        <div class="button">
           <input type="button" value="New Employee" />
        </div>
       <div id="employeeTable">
        
        </div>
    </div>
</body>
</html>
