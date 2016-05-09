﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Employees</title>
    <script src="../../Content/Scripts/jquery-1.10.2.min.js"></script>
    <script type='text/javascript'>
        $(document).ready(function () {
            $.ajax({
                url: "http://localhost:55739/api/employee/all",
                type: "GET",
                success: function (data) {
                    for (var i = 0; i < data.length; i++)
                    {
                        createEmployeeRow(data[i]);
                    }
                },
                error: function(e)
                {
                    alert(e);
                },
            });            
        });

        function createEmployeeRow(employee) {
            
            var dob = new Date(employee.DateOfBirth);

            $("<div><span>" +
                employee.Name +
            "</span><span>" +
                 (dob.getMonth()+ 1) + "/" + (dob.getDate() + 1) + "/" + dob.getYear() +
            "</span><span>" +
             employee.SocialSecurityNumber +
            "</span><span> <a onClick='seeDetails(" + employee.EmployeeId + ")'>Details</a></span><span><a  onClick='Fire(" + employee.EmployeeId + ")'>Fire</a></span></div>").appendTo("#employeeTable");
        }

        function Fire(id)
        {
            $.ajax({
                url: "http://localhost:55739/api/employee/delete",
                type: "Post",
                data: JSON.stringify({EmployeeId : id}),
                contentType: 'application/json; charset=UTF-8',
                success: function (data) {
                    alert("success");
                },
                error: function (e) {
                    alert(e);
                },
            });
        }

    </script>
</head>
<body>
    <div>
        <div class="button">
           <a href='New'>
               <button>New Employee</button>
           </a>
        </div>
       <div id="employeeTable">
        
        </div>
    </div>
</body>
</html>
