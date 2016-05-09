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
                var Street = $('#Street').val();
                var City = $('#City').val();
                var State = $('#State').val();
                var Zip = $('#Zip').val();

                $.ajax({
                    url: "http://localhost:55739/api/location/insert",
                    type: "POST",
                    data: JSON.stringify({ Name: Name, Address: { Street: Street, City: City, State: State, Zip: Zip } }),
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
            <section title="Address">
            <span>
                <label for="Street">Street</label>
                <input type="text"  id="Street"/>
            </span>
            <span>
                <label for="City">City</label>
                <input type="text"  id="City"/>
            </span>
            <span>
                <label for="State">State</label>
                <input type="text"  id="State"/>
            </span>
            <span>
                <label for="Zip">Zip</label>
                <input type="text"  id="Zip"/>
            </span>
            </section>
        </div>
    </div>
        <input id="submit" type="button" value="Submit" />
    </form>
</body>
</html>
