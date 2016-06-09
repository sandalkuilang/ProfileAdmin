using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models
{
    public class CreatedEventArgs<T> : BaseModelEventArgs<T>
    {
        public CreatedEventArgs(Exception exception)
            : base(exception)
        {

        }
    }
}