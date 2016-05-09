<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Home</title>
    <style type="text/css">
       .button{
            margin-top: 10px
        }

    </style>
</head>
<body>
    <div>
       <div class="button">
           <a href="/Employees/Index">
               <button>View Employees</button>
           </a>
       </div>
        <div class="button">
           <a href="/Location/Index">
               <button>View Locations</button>
           </a>
       </div>
        <div class="button">
           <a href="/Department/Index">
               <button>View Departments</button>
           </a>
       </div>
    </div>
</body>
</html>
