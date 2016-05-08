<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Index</title>
</head>
<body>
    <div>
       <div class="button">
           <a href="/Employees/Index">
               <button>View Employees</button>
           </a>
       </div>
        <div class="button">
           <a href="">
               <button>View Locations</button>
           </a>
       </div>
        <div class="button">
           <a href="">
               <button>View Departments</button>
           </a>
       </div>
    </div>
</body>
</html>
