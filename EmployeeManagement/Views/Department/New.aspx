<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Employee</title>
    <script src="../../Content/Scripts/jquery-1.10.2.min.js"></script>
    <script type='text/javascript'>
        $(document).ready(function () {
            $('#submit').click(function()
            {
                var Name = $('#Name').val();
                $.ajax({
                    url: "http://localhost:55739/api/department/insert",
                    type: "POST",
                    data: JSON.stringify({ Name : Name }),
                    contentType: 'application/json; charset=UTF-8',
                    success: function (data) {
                        alert('success');
                    },
                    error: function (e) {
                        alert(e);
                    },
                });
            });
        
    });
    </script>
</head>
<body>
    <form id="Form">
    <div>
        <div>
            <span>
                <label for="Name">Name</label>
                <input type="text"  id="Name"/>
            </span>
        </div>
    </div>
        <input id="submit" type="button" value="Submit" />
    </form>
</body>
</html>
