<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Employees</title>
    <script src="../../Content/Scripts/jquery-1.10.2.min.js"></script>
    <script type='text/javascript'>
        $(document).ready(function () {
            $.ajax({
                url: "http://localhost:55739/api/department/all",
                type: "GET",
                success: function (data) {
                    for (var i = 0; i < data.length; i++)
                    {
                        createRow(data[i]);
                    }
                },
                error: function(e)
                {
                    alert(e);
                },
            });            
        });

        function createRow(departments) {
            $("<div><span>" +
                departments.Name +
            "</span><span><a onClick='Remove(" + departments.DepartmentId + ")' >Remove</a></span></div>").appendTo("#table");
        }

        function Remove(id) {
            $.ajax({
                url: "http://localhost:55739/api/department/delete",
                type: "Post",
                data: JSON.stringify({ DepartmentId: id }),
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
               <button>New Department</button>
           </a>
        </div>
       <div id="table">
        
        </div>
    </div>
</body>
</html>
