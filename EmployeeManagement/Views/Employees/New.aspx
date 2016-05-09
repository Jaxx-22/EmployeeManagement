<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Employee</title>
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
            $.ajax({
                url: "http://localhost:55739/api/employee/supervisor",
                type: "GET",
                success: function (data) {
                    for(var i = 0; i < data.length; i++)
                    {
                        var id = data[i].SupervisorId;
                        var name = data[i].SupervisorName;
                        supervisorList.push({Id: id, Name:name});
                    }
                },
                error: function(e)
                {
                    alert(e);
                },
            }); 

            $.ajax({
                url: "http://localhost:55739/api/department/all",
                type: "GET",
                success: function (data) {
                    for(var i = 0; i < data.length; i++)
                    {
                        var id = data[i].DepartmentId;
                        var name = data[i].Name;
                        departmentList.push({Id: id, Name:name});
                    }
                },
                error: function(e)
                {
                    alert(e);
                },
            }); 
            
            $.ajax({
                url: "http://localhost:55739/api/location/all",
                type: "GET",
                success: function (data) {
                    for(var i = 0; i < data.length; i++)
                    {
                        var id = data[i].LocationId;
                        var name = data[i].Name;
                        locationList.push({Id: id, Name:name});
                    }
                },
                error: function(e)
                {
                    alert(e);
                },
            });

            $('#submit').click(function()
            {
                var name = $('#Name').val();
                var dateofbirth = $('#DateOfBirth').val();
                var socialSecurityNumber = $('#SocialSecurityNumber').val();
                $.ajax({
                    url: "http://localhost:55739/api/employee/create",
                    type: "POST",
                    data: CreateJSONString(),
                    contentType: 'application/json; charset=UTF-8',
                    success: function (data) {
                        window.location.href = "http://localhost:51066/Employees/Index";
                    },
                    error: function (e) {
                        alert(e);
                    },
                });
            });
        
        });

        function addNewAddress()
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
                '"/></span><span><input type="button" onclick="RemoveAddress('+
                addressCount+
                ')" value="Remove"></input></span></div>').appendTo('#divAddresses');

            addressCount = addressCount + 1;
        }

        function RemoveAddress(addId)
        {
            $('#AddDiv'+addId).remove();
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
                '"/></span><span><input type="button" onclick="RemoveRecord('+
                recordCount+
                ')" value="Remove"></input></span></div>').appendTo('#divRecords');

            recordCount = recordCount + 1;
        }

        function RemoveRecord(recId)
        {
            $('#RecDiv'+recId).remove();
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

        function CreateJSONString()
        {
            var name = $('#Name').val();
            var dateofbirth = $('#DateOfBirth').val();
            var socialSecurityNumber = $('#SocialSecurityNumber').val();
            var Adresses = new Array();
            var Records = new Array();

            for(var i = 0; i < addressCount; i++)
            {
                var street = $('#Street'+i).val();
                var city = $('#City'+i).val();
                var state = $('#State'+i).val();
                var zip = $('#Zip'+i).val();
                if(street !== undefined)
                {
                    Adresses.push({Street: street, City: city, State:state, zip:zip});
                }
            }

            for(var i = 0; i < recordCount; i++)
            {
                var department = $('#selectDepartment'+i).val();
                var location = $('#selectLocation'+i).val();
                var Supervisor = $('#selectSupervisor'+i).val();
                var IsSupervisor = $('#IsSupervisor'+i).val() === 'on';
                var Salary = $('#Salary'+i).val();
                var HireDate = $('#HireDate'+i).val();
                if(Salary !== undefined)
                {
                    var departmentValues = department.split(',');
                    var departmentId = departmentValues[0];
                    var locationId = location.split(',')[0];
                    var supId = 0;
                    var supName = null;
                    if(Supervisor !=="Select")
                    {
                        supId = Supervisor.split(',')[0];
                        supName = Supervisor.split(',')[1];
                    }

                    Records.push({department: {DepartmentId:departmentId}, 
                        Location:{LocationId:locationId},
                        Supervisor : {SupervisorId :supId, SupervisorName: supName},
                        IsSupervisor: IsSupervisor,
                        HireDate : HireDate,
                        Salary : Salary});
                }
            }
            return JSON.stringify({Employee : {name,dateofbirth,socialSecurityNumber}, Adresses : Adresses, Records : Records})
        }


    </script>
</head>
<body>
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
                <input id="AddAddressBtn" type="button" onclick="addNewAddress()" value="Add Address"/>
                <div id="divAddresses"></div>
            </section>
            <section title="Records">
                <input id="AddRecordBtn" type="button" onclick="addNewRecord()" value="Add Record"/>
                <div id="divRecords"></div>
            </section>
        </div>
    </div>
        <input id="submit" type="button" value="Submit"/>
    </form>
</body>
</html>
