<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Details</title>
    <style type="text/css">
        label{
            padding:25px;
        }
        section{
            margin-top: 15px
        }
        span{
            margin:5px;
            padding:10px;
        }
        #submit{
            margin-top: 10px
        }

    </style>
    <script src="../../Content/Scripts/jquery-1.10.2.min.js"></script>
    <script type='text/javascript'>
        var addressCount = 0;
        var recordCount = 0;
        var departmentList = new Array();
        var supervisorList = new Array();
        var locationList = new Array();
        $(document).ready(function () {
            var id = $('#empId').val();


            $.ajax({
                url: "http://localhost:55739/api/employee/supervisor",
                type: "GET",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var id = data[i].SupervisorId;
                        var name = data[i].SupervisorName;
                        supervisorList.push({ Id: id, Name: name });
                    }
                },
                error: function (e) {
                    alert(e);
                },
            });

            $.ajax({
                url: "http://localhost:55739/api/department/all",
                type: "GET",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var id = data[i].DepartmentId;
                        var name = data[i].Name;
                        departmentList.push({ Id: id, Name: name });
                    }
                },
                error: function (e) {
                    alert(e);
                },
            });

            $.ajax({
                url: "http://localhost:55739/api/location/all",
                type: "GET",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var id = data[i].LocationId;
                        var name = data[i].Name;
                        locationList.push({ Id: id, Name: name });
                    }
                },
                error: function (e) {
                    alert(e);
                },
            });

            $.ajax({
                url: "http://localhost:55739/api/employee/get/" + id,
                type: "GET",
                success: function (data) {
                    $('#Name').val(data.Name)
                    var dob = new Date(data.DateOfBirth);
                    $('#DateOfBirth').val((dob.getMonth()+1) + '/' + (dob.getDate()+1) + '/' + dob.getYear());
                    $('#SocialSecurityNumber').val(data.SocialSecurityNumber);
                    for (var i = 0; i < data.Addresses.length; i++) {
                        addAddress();
                        var add = data.Addresses[i];
                        $('#Street' + i).val(add.Street)
                        $('#City' + i).val(add.City);
                        $('#State' + i).val(add.State);
                        $('#Zip' + i).val(add.zip);
                    }

                    for (var i = 0; i < data.Records.length; i++) {
                        addNewRecord();
                        var rec = data.Records[i];
                        var hd = new Date(rec.HireDate);
                        $('#selectDepartment' + i).val(rec.Department.DepartmentId + ',' + rec.Department.Name);
                        $('#selectLocation' + i).val(rec.Location.LocationId + ',' + rec.Location.Name);
                        $('#selectSupervisor' + i).val(rec.Supervisor.SupervisorId + ',' + rec.Supervisor.SupervisorName);
                        $('#IsSupervisor' + i).prop( "checked",rec.IsSupervisor);
                        $('#Salary' + i).val(rec.Salary);
                        $('#HireDate' + i).val((hd.getMonth()+1) + '/' + (hd.getDate()+1) + '/' + hd.getYear());
                    }
                },
                error: function (e) {
                    alert(e);
                },
            });
        });

            

        function addAddress()
        {
            $('<div id="AddDiv'+
                addressCount+
                '"><span> <label for="Street'+
                addressCount +
                '">Street</label><input type="text"  id="Street'+
                addressCount +
                '"/></span><span><label for="City'+
                addressCount +
                '">City</label><input type="text"  id="City'+
                addressCount +
                '"/></span><span><label for="State'+
                addressCount +
                '">State</label><input type="text"  id="State'+
                addressCount +
                '"/></span><span><label for="Zip'+
                addressCount +
                '">Zip</label><input type="text"  id="Zip'+
                addressCount +
                '"/></span></div>').appendTo('#divAddresses');

            addressCount = addressCount + 1;
        }

                function addNewRecord()
        {
            $('<div id="RecDiv'+
                recordCount+
                '"></span><span id="department'+
                recordCount +
                '><label for="selectDepartment' +
                recordCount +
                '">Department</lable>'+
                CreateCombobox('selectDepartment'+recordCount,'department'+ recordCount, departmentList) +
                '</span><span id="location'+
                recordCount +
                '><label for="selectLocation' +
                recordCount +
                '">Location</label>' +
                CreateCombobox('selectLocation'+recordCount,'location'+ recordCount, locationList) +
                '</span><span><label for="IsSupervisor'+
                recordCount +
                '">Is Supervisor</label><input type="checkbox" id="IsSupervisor'+
                recordCount +
                '"/></span><span id="supervisor'+
                recordCount +
                '><label for="selectSupervisor' +
                recordCount +
                '">Supervisor</label>' +
                 CreateCombobox('selectSupervisor'+recordCount,'supervisor'+ recordCount, supervisorList) +
                 '</span></span><span><label for="Salary'+
                recordCount +
                '">Salary</label><input type="text"  id="Salary'+
                recordCount +
                '"/></span><span><label for="HireDate'+
                recordCount +
                '">Hire Date</label><input type="text"  id="HireDate'+
                recordCount +
                '"/></span></div>').appendTo('#divRecords');

            recordCount = recordCount + 1;
        }

        function CreateCombobox(id, parentid, list)
        {
            var returnstring = '<select id="' + id +'"><option>Select</option>';
            for(var i=0; i < list.length; i++)
            {
                var name = list[i].Name;
                var optionId = list[i].Id;
                returnstring = returnstring + '<option value="'+optionId+','+name+'">'+name+'</option>';
            }
            returnstring = returnstring + '</select>';
            return returnstring;
        }
    </script>
</head>
<body>
    <input type="hidden" hidden="hidden" value="<%=ViewData["Id"] %>" id="empId"/>
    <form id="newEmployeeForm">
    <div>
        <div>
            <span>
                Name
                <input type="text"  id="Name"/>
            </span>
            <span>
                 Date Of Birth
                <input type="text"  id="DateOfBirth"/>
            </span>
            <span>
                Social Security Number
                <input type="text"  id="SocialSecurityNumber"/>
            </span>
            <section title="Addresses">
                <div id="divAddresses"></div>
            </section>
            <section title="Records">
                <div id="divRecords"></div>
            </section>
        </div>
    </div>
    </form>
</body>
</html>
