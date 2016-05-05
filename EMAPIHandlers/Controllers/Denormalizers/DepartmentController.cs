using EMAPIHandlers.Controllers.Denormalizers.Models;
using EMSystemModels.Commands;
using EMSystemModels.Models;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace EMAPIHandlers.Controllers.Denormalizers
{
    [RoutePrefix("api/department")]
    public class DepartmentController : ApiController
    {
        private Database _databaseContex;

        public DepartmentController()
        {
            _databaseContex = new Database();
        }

        public IList<Department> GetAllDepartments()
        {
            var departs = _databaseContex.Fetch<dboDepartment>("");
            var retunList = new List<Department>();

            foreach (var d in departs)
            {
                retunList.Add(new Department { DepartmentId = d.DepartmentId, Name = d.Name });
            }

            return retunList;
        }

        [Route("update")]
        public void PostUpdateDepartment(UpdateDepartment command)
        {
            _databaseContex.Update(new dboDepartment{DepartmentId = command.DepartmentId, Name = command.Name});
        }

        [Route("insert")]
        public void PostInsertDepartment(CreateDepartment command)
        {
            _databaseContex.Insert(new dboDepartment{Name = command.Name});
        }

        [Route("delete")]
        public void PostDeleteDepartment(int id)
        {
            var recordWithDepartment = _databaseContex.Query<dboEmployeeRecord>("WHERE DepartmentId = {0}", id).Count();
            if (recordWithDepartment == 0)
            {
                _databaseContex.Delete<dboDepartment>(id);
            }
        }
    }
}
