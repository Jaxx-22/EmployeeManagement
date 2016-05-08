using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EMAPIHandlers.Controllers.Denormalizers.Models
{
    [TableName("dboLocation")]
    public class dboLocation
    {
        public int LocationId { get; set; }
        public int AddressId { get; set; }
        public string Name { get; set; }
    }
}