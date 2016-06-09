using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models
{
    public class BaseModelEventArgs<T> : EventArgs
    {
        private Exception exception;
        public Exception Exception
        {
            get
            {
                return exception;
            }
        }

        public bool ExceptionHandled { get; set; }

        private T model;
        public T Model
        {
            get
            {
                return model;   
            }
            set
            {
                model = value;
            }
        }

        public BaseModelEventArgs(Exception exception)
        {
            this.ExceptionHandled = false;
            this.exception = exception;
        }

    }
}