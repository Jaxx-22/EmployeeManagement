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
    [RoutePrefix("api/location")]
    public class LocationController : ApiController
    {
        private Database _databaseContex;

        public LocationController()
        {
            var m_dbConnection = new SQLiteConnection("Data Source=EMdb.sqlite;Version=3;");
            m_dbConnection.Open();
            _databaseContex = new Database(m_dbConnection);
        }

        [Route("all")]
        public IList<Location> GetAllLocation()
        {
            var departs = _databaseContex.Fetch<dboLocation>("");
            var retunList = new List<Location>();

            foreach (var d in departs)
            {
                retunList.Add(new Location { LocationId = d.LocationId, Name = d.Name, Address = fetchAddress(d.AddressId) });
            }

            _databaseContex.CloseSharedConnection();

            return retunList;
        }

        private Address fetchAddress(int id)
        {
            var add = _databaseContex.Fetch<dboAddress>(string.Format("WHERE AddressId = {0}", id)).First(); ;

            return new Address { AddressId = id, City = add.City, State = add.State, Street = add.Street, zip = add.zip };
        }

        [Route("insert")]
        public void PostInsertLocation(CreateLocation command)
        {
            var address = command.Address;
            var newAddressId = Convert.ToInt32( _databaseContex.Insert(new dboAddress
            {
                City = address.City,
                State = address.State,
                Street = address.Street,
                zip = address.zip
            }));

            _databaseContex.Insert(new dboLocation { Name = command.Name, AddressId = newAddressId });

            _databaseContex.CloseSharedConnection();
        }

        [Route("delete")]
        public void PostDeleteLocation(LocationCommand command)
        {
            var id = command.LocationId;
            var recordWithDepartment = _databaseContex.Query<dboEmployeeRecord>(string.Format("WHERE LocationId = {0}", id)).Count();
            if (recordWithDepartment == 0)
            {
                var addressId = _databaseContex.Single<int>(string.Format("SELECT AddressId FROM dboLocation WHERE LocationId = {0}", id));
                _databaseContex.Delete<dboAddress>(addressId);
                _databaseContex.Delete<dboLocation>(id);
            }

            _databaseContex.CloseSharedConnection();
        }
    }
}
