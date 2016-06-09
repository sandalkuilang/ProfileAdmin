using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models.ConfigurationTable
{
    public class Configuration
    {
        public string ConfigId { get; set; }
        public string ParameterName { get; set; }
        public string Type { get; set; }
        public string Value { get; set; }
        public string AdditionalValue { get; set; }
    }
}