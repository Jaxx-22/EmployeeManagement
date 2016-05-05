using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EMHandlers.Denormalizers.Models
{
    [TableName("dbo.PersonalInformation")]
    public class dboPersonalInformation
    {
        public int EmployeeId { get; set; }
        public string Name { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string SocialSecurityNumber { get; set; }
    }
}