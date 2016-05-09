using EMAPIHandlers.Controllers.Denormalizers.Models;
using EMSystemModels.Commands;
using EMSystemModels.Models;
using Newtonsoft.Json.Linq;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace EMAPIHandlers.Controllers.Denormalizers
{
    [RoutePrefix("api/employee")]
    public class EmployeeController : ApiController
    {
        private Database _databaseContex;

        public EmployeeController()
        {
            var m_dbConnection = new SQLiteConnection("Data Source=EMdb.sqlite;Version=3;");
            m_dbConnection.Open();
            _databaseContex = new Database(m_dbConnection);
        }

        [Route("get/{id}")]
        public Employee GetEmployee( int id)
        {
            var emp = fetchEmployee(id);
            _databaseContex.CloseSharedConnection();
            return emp;
        }

        [Route("supervisor")]
        public IList<Supervisor> GetSupervisors()
        {
            var empIds = _databaseContex.Fetch<int>("Select EmployeeId From dboEmployeeRecord WHERE IsSupervisor = 1");
            var retunList = new List<Supervisor>();

            foreach (var id in empIds)
            {
                var name = _databaseContex.Fetch<string>(string.Format("Select Name From dboPersonalInformation WHERE employeeId = {0}", id)).First();
                retunList.Add(new Supervisor{SupervisorId = id, SupervisorName = name });
            }

            _databaseContex.CloseSharedConnection();

            return retunList;
        }

        [Route("all")]
        public IList<Employee> GetAllEmployies()
        {
            var empIds = _databaseContex.Query<int>("Select EmployeeId From dboPersonalInformation");
            var retunList = new List<Employee>();

            foreach(var id in empIds)
            {
                retunList.Add(fetchEmployee(id));
            }

            _databaseContex.CloseSharedConnection();

            return retunList;
        }


        private Employee fetchEmployee(int id)
        {
            var emp = new Employee();
            emp.EmployeeId = id;

            var pi = _databaseContex.Fetch<dboPersonalInformation>(string.Format("WHERE EmployeeId = {0}", id)).First();
            emp.Name = pi.Name;
            emp.DateOfBirth = pi.DateOfBirth;
            emp.SocialSecurityNumber = pi.SocialSecurityNumber;

            emp.Addresses = fetchAddresses(id).ToList();
            emp.Records = fetchRecords(id);

            return emp;
        }

        private List<EmployeeRecord> fetchRecords(int id)
        {
            var returnList = new List<EmployeeRecord>();
            var records = _databaseContex.Fetch<dboEmployeeRecord>(string.Format("WHERE EmployeeId = {0}", id));
            foreach(var r in records)
            {
                returnList.Add(new EmployeeRecord
                {
                    HireDate = r.HireDate,
                    IsSupervisor = r.IsSupervisor,
                    Salary = r.Salary,
                    Supervisor = new Supervisor { SupervisorId = r.SupervisorId, SupervisorName = r.SupervisorName },
                    Location = fetchLocation(r.LocationId),
                    Department = fetchDepartment(r.DepartmentId)
                });
            }
            return returnList;
        }

        private Department fetchDepartment(int id)
        {
            var depa = _databaseContex.First<dboDepartment>(string.Format("WHERE DepartmentId = {0}", id));
            return new Department { DepartmentId = id, Name = depa.Name };
        }

        private Location fetchLocation(int id)
        {
            var loca = _databaseContex.First<dboLocation>(string.Format("WHERE LocationId = {0}", id));
            return new Location { LocationId = id, Name = loca.Name, Address = fetchAddress(loca.AddressId) };
        }

        private Address fetchAddress(int id)
        {
            var add = _databaseContex.First<dboAddress>(string.Format("WHERE AddressId = {0}", id));

            return new Address { AddressId = id, City = add.City, State = add.State, Street = add.Street, zip = add.zip };
        }

        private List<Address> fetchAddresses(int id)
        {
            var returnList = new List<Address>();
            var addIds = _databaseContex.Fetch<dboEmployeeAddress>(string.Format("WHERE EmployeeId = {0}", id.ToString())).Select(a => (int)a.AddressId);


            foreach (var add in addIds)
            {
                returnList.Add(fetchAddress(add));
            }

            return returnList;
        }

        [Route("delete")]
        public void PostDeleteEmployee(EmployeeCommand Command)
        {
            var id = Command.EmployeeId;
            _databaseContex.Delete<dboPersonalInformation>(id);
            _databaseContex.Delete<dboEmployeeRecord>(string.Format("WHERE EmployeeId = {0}", id));
            var addresses = _databaseContex.Fetch<dboEmployeeAddress>(string.Format("WHERE EmployeeId = {0}", id));
            foreach(var address in addresses)
            {
                _databaseContex.Delete<dboAddress>(address.AddressId);
            }

            _databaseContex.Delete<dboEmployeeAddress>(string.Format("WHERE EmployeeId = {0}", id));

            _databaseContex.CloseSharedConnection();
        }

        [Route("create")]
        public void PostCreateEmployee(CreateNewEmployee command)
        {
            var employeeId = _databaseContex.Insert(new dboPersonalInformation
            {
                Name = command.Employee.Name,
                DateOfBirth = command.Employee.DateOfBirth,
                SocialSecurityNumber = command.Employee.SocialSecurityNumber
            });

            foreach (var address in command.Adresses)
            {
                var newAddressId = _databaseContex.Insert(new dboAddress
                {
                    City = address.City,
                    State = address.State,
                    Street = address.Street,
                    zip = address.zip
                });

                _databaseContex.Insert(new dboEmployeeAddress
                {
                    EmployeeId = Convert.ToInt32(employeeId),
                    AddressId = Convert.ToInt32(newAddressId)
                });
            }

            foreach (var r in command.Records)
            {
                _databaseContex.Insert(new dboEmployeeRecord
                {
                    EmployeeId = Convert.ToInt32(employeeId),
                    DepartmentId = r.Department.DepartmentId.Value,
                    HireDate = r.HireDate,
                    IsSupervisor = r.IsSupervisor,
                    LocationId = r.Location.LocationId,
                    Salary = r.Salary,
                    SupervisorId = r.Supervisor.SupervisorId,
                    SupervisorName = r.Supervisor.SupervisorName
                });
            }

            _databaseContex.CloseSharedConnection();
        }

        [Route("personal")]
        public void PostPersonalInformation(UpdatePersonalInformation command)
        {
            _databaseContex.Update(new dboPersonalInformation
            {
                EmployeeId = command.EmployeeId,
                Name = command.Employee.Name,
                DateOfBirth = command.Employee.DateOfBirth,
                SocialSecurityNumber = command.Employee.SocialSecurityNumber
            });

            _databaseContex.CloseSharedConnection();
        }

        [Route("record")]
        public void PostEmployeeRecord(UpdateRecord command)
        {
            foreach (var r in command.Records)
            {
                var exsits = _databaseContex.Exists<dboEmployeeRecord>(
                    string.Format("WHERE EmployeeId = {0} AND DepartmentId = {1}",command.EmployeeId, r.Department.DepartmentId.Value));
                if (exsits)
                {
                    _databaseContex.Update(new dboEmployeeRecord
                    {
                        EmployeeId = command.EmployeeId,
                        DepartmentId = r.Department.DepartmentId.Value,
                        HireDate = r.HireDate,
                        IsSupervisor = r.IsSupervisor,
                        LocationId = r.Location.LocationId,
                        Salary = r.Salary,
                        SupervisorId = r.Supervisor.SupervisorId,
                        SupervisorName = r.Supervisor.SupervisorName
                    });
                }
                else
                {
                    _databaseContex.Insert(new dboEmployeeRecord
                    {
                        EmployeeId = command.EmployeeId,
                        DepartmentId = r.Department.DepartmentId.Value,
                        HireDate = r.HireDate,
                        IsSupervisor = r.IsSupervisor,
                        LocationId = r.Location.LocationId,
                        Salary = r.Salary,
                        SupervisorId = r.Supervisor.SupervisorId,
                        SupervisorName = r.Supervisor.SupervisorName
                    });
                }
            }

            foreach(var r in command.RemovedRecords)
            {
                _databaseContex.Delete<dboEmployeeRecord>(string.Format("WHERE EmployeeId = {0} AND DepartmentId = {1}", command.EmployeeId, r));
            }

            _databaseContex.CloseSharedConnection();
        }

        [Route("address")]
        public void PostEmployeeRecord(UpdateEmployeeAddress command)
        {
            foreach(var address in command.Address)
            {
                var addressExsits = _databaseContex.Exists<dboAddress>(address.AddressId.Value);

                if(addressExsits)
                {
                    _databaseContex.Update(new dboAddress
                    { 
                        AddressId =  address.AddressId.Value,
                        City = address.City,
                        State = address.State,
                        Street = address.Street,
                        zip = address.zip
                    });
                }
                else
                {
                    var newAddressId = (int)_databaseContex.Insert(new dboAddress
                    {
                        City = address.City,
                        State = address.State,
                        Street = address.Street,
                        zip = address.zip
                    });

                    _databaseContex.Insert(new dboEmployeeAddress 
                    {
                        EmployeeId = command.EmployeeId,
                        AddressId = newAddressId
                    });
                }
            }

            foreach(var addressId in command.RemovedAddress)
            {
                _databaseContex.Delete<dboEmployeeAddress>(string.Format("WHERE EmployeeId = {0} AND AddressId = {1}", command.EmployeeId,addressId));
                _databaseContex.Delete<dboAddress>(addressId);
            }
            _databaseContex.CloseSharedConnection();
        }        
    }
}
