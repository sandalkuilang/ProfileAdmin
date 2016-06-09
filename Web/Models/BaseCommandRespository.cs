using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Krokot.Database;
using WebPlatform; 

namespace Krokot.ProfileAdmin.Models
{
    public abstract class BaseCommandRespository 
    {
        public bool ExceptionHandled { get; set; }

        public dynamic Parameter { get; set; }

        public IDataCommand Database { get; private set; }
        public ApplicationSettings ApplicationSettings { get; private set; }
         
        public delegate int ExecuteAction();
        public delegate IList<T> QueryAction<T>();
        public delegate int GetAction();

     
        public BaseCommandRespository()
            : this(DatabaseNames.DefaultDB)
        {

        }

        public BaseCommandRespository(string databaseName)
            : this(databaseName, false)
        {
        
        }

        public BaseCommandRespository(string databaseName, bool exceptionHandled)
        { 
            Database = DatabaseManager.GetInstance.GetDatabase(databaseName);
            ApplicationSettings = ApplicationSettings.Instance;
            ExceptionHandled = exceptionHandled;
        }

        private int Execute(ExecuteAction executeAction, Action<Exception> notifyAction)
        {
            int result = -1;
            if (ExceptionHandled)
            {
                try
                {
                    result = executeAction.Invoke();
                }
                catch (Exception ex)
                {
                    notifyAction.Invoke(ex);
                }
            }
            else
            {
                result = executeAction.Invoke();
                notifyAction.Invoke(null);
            }
            return result;
        }

        private IList<T> Query<T>(QueryAction<T> executeAction, Action<Exception> notifyAction)
        {
            IList<T> result = new List<T>();
            if (ExceptionHandled)
            {
                try
                {
                    result = executeAction.Invoke();
                }
                catch (Exception ex)
                {
                    notifyAction.Invoke(ex);
                }
            }
            else
            {
                result = executeAction.Invoke();
                notifyAction.Invoke(null);
            }
            return result;
        }
          
         
    }
}