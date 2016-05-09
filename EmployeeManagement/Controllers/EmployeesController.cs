using EMSystemModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EmployeeManagement.Controllers
{
    public class EmployeesController : Controller
    {
        //
        // GET: /Employees/

        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Details(int id)
        {
            ViewData["Id"] = id;
            return View();
        }

        [HttpGet]
        public ActionResult Edit(Employee e)
        {
            return View(e);
        }

        [HttpGet]
        public ActionResult New()
        {
            return View();
        }

    }
}
