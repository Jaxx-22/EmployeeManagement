using EMAPIHandlers.Controllers.Denormalizers.Models;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;

namespace EMHnadlers
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            GlobalConfiguration.Configure(WebApiConfig.Register);

            SQLiteConnection.CreateFile("EMdb.sqlite");
            CreateDatabase();
        }

        private void CreateDatabase()
        {
            var m_dbConnection = new SQLiteConnection("Data Source=EMdb.sqlite;Version=3;");
            m_dbConnection.Open();

            var root = AppDomain.CurrentDomain.BaseDirectory;
            string[] dir = Directory.GetFiles(root + "/SQLFiles");

            using (var db = new Database(m_dbConnection))
            {
                foreach(var file in dir)
                {
                    var sql = File.ReadAllText(file);
                    db.Execute(sql);
                }
            }
            m_dbConnection.Close();
            testDepartments();
        }

        private void testDepartments()
        {
            var m_dbConnection = new SQLiteConnection("Data Source=EMdb.sqlite;Version=3;");
            m_dbConnection.Open();

            using (var db = new Database(m_dbConnection))
            {
                db.Insert(new dboDepartment { Name = "test" });
            }
            m_dbConnection.Close();
        }
    }
}
