using EMAPIHandlers.Controllers.Denormalizers.Models;
using EMSystemModels.Commands;
using EMSystemModels.Models;
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
    [RoutePrefix("api/department")]
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class DepartmentController : ApiController
    {
        private Database _databaseContex;

        public DepartmentController()
        {
            var m_dbConnection = new SQLiteConnection("Data Source=EMdb.sqlite;Version=3;");
            m_dbConnection.Open();
            _databaseContex = new Database(m_dbConnection);
        }

        [Route("all")]
        public IList<Department> GetAllDepartments()
        {
            var departs = _databaseContex.Fetch<dboDepartment>("");
            var retunList = new List<Department>();

            foreach (var d in departs)
            {
                retunList.Add(new Department { DepartmentId = d.DepartmentId, Name = d.Name });
            }
            _databaseContex.CloseSharedConnection();

            return retunList;
        }

        [Route("insert")]
        public void Insert(CreateDepartment Command)
        {
            _databaseContex.Insert(new dboDepartment { Name = Command.Name });
            _databaseContex.CloseSharedConnection();
        }

        [Route("delete")]
        public void PostDeleteDepartment(DepartmentCommand command)
        {
            var id = command.DepartmentId;
            var recordWithDepartment = _databaseContex.Query<dboEmployeeRecord>(string.Format("WHERE DepartmentId = {0}", id)).Count();
            if (recordWithDepartment == 0)
            {
                _databaseContex.Delete<dboDepartment>(id);
            }
            _databaseContex.CloseSharedConnection();
        }
    }
}
