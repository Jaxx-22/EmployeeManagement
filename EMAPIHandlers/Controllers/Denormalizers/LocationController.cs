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
    [RoutePrefix("api/location")]
    public class LocationController : ApiController
    {
        private Database _databaseContex;

        public LocationController()
        {
            _databaseContex = new Database();
        }

        public IList<Location> GetAllLocation()
        {
            var departs = _databaseContex.Fetch<dboLocation>("");
            var retunList = new List<Location>();

            foreach (var d in departs)
            {
                retunList.Add(new Location { LocationId = d.LocationId, Name = d.Name, Address = fetchAddress(d.AddressId) });
            }

            return retunList;
        }

        private Address fetchAddress(int id)
        {
            var add = _databaseContex.First<dboAddress>(id.ToString());

            return new Address { AddressId = id, City = add.City, State = add.State, Street = add.Street, zip = add.zip };
        }

        [Route("update")]
        public void PostUpdateLocation(UpdateLocation command)
        {
            var address = command.Address;
                _databaseContex.Update(new dboAddress
                {
                    AddressId = command.Address.AddressId.Value,
                    City = address.City,
                    State = address.State,
                    Street = address.Street,
                    zip = address.zip
                });
            _databaseContex.Update(new dboLocation { LocationId = command.LocationId, Name = command.Name, AddressId = command.Address.AddressId.Value });
        }

        [Route("insert")]
        public void PostInsertLocation(CreateLocation command)
        {
            var address = command.Address;
            var newAddressId = (int)_databaseContex.Insert(new dboAddress
            {
                City = address.City,
                State = address.State,
                Street = address.Street,
                zip = address.zip
            });

            _databaseContex.Insert(new dboLocation { Name = command.Name, AddressId = newAddressId });
        }

        [Route("delete")]
        public void PostDeleteLocation(int id)
        {
            var recordWithDepartment = _databaseContex.Query<dboEmployeeRecord>("WHERE LocationId = {0}", id).Count();
            if (recordWithDepartment == 0)
            {
                var addressId = _databaseContex.Single<int>("SELECT AddressId FROM dbo.Location WHERE LocationId = {0}", id);
                _databaseContex.Delete<dboAddress>(addressId);
                _databaseContex.Delete<dboLocation>(id);
            }
        }
    }
}
