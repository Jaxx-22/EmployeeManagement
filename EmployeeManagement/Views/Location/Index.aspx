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
                url: "http://localhost:55739/api/location/all",
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

        function createRow(location) {
            $("<div><span>" +
                location.Name +
            "</span><section title='Address'><span>" +
                location.Address.Street +
            "</span><span>" +
                location.Address.City +
            "</span><span>" +
                location.Address.State +
            "</span><span>" +
                location.Address.Zip +
            "</span></section><span><a onClick='Remove(" + location.LocationId + ")' >Remove</a></span></div>").appendTo("#table");
        }

        function Remove(id) {
            $.ajax({
                url: "http://localhost:55739/api/location/delete",
                type: "Post",
                data: JSON.stringify({ LocationId: id }),
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
               <button>New Location</button>
           </a>
        </div>
       <div id="table">
        
        </div>
    </div>
</body>
</html>
