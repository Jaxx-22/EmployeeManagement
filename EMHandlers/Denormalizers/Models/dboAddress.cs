using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EMHandlers.Denormalizers.Models
{
    [TableName("dbo.Adress")]
    public class dboAddress
    {
        public int AddressId { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string zip { get; set; }
    }
}