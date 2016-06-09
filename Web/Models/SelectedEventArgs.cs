using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models
{
    public class SelectedEventArgs<T> : BaseModelEventArgs<T>
    {
        public SelectedEventArgs(Exception exception)
            : base(exception)
        {

        }
    }
}