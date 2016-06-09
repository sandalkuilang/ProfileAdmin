using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models
{
    public interface ICommandRepository<T>
    {
        int Update();
        int Delete();
        IList<T> Select();
        int Create();
    }
}