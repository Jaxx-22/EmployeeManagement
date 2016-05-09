<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Location</title>
    <style type="text/css">
        #table{
            padding:25px;
        }
        span{
            margin:5px;
            padding:10px;
        }

    </style>
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
                location.Address.zip +
            "</span></section><span><input type='button' onClick='Remove(" + location.LocationId + ")' value='Remove' ></input></span></div>").appendTo("#table");
        }

        function Remove(id) {
            $.ajax({
                url: "http://localhost:55739/api/location/delete",
                type: "Post",
                data: JSON.stringify({ LocationId: id }),
                contentType: 'application/json; charset=UTF-8',
                success: function (data) {
                    window.location.href = "http://localhost:51066/Location/Index";
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
