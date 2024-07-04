using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PiStore
{
    internal class DBConnect
    {
        private static SqlConnection conn = null;

        public static SqlConnection GetInstance()
        {
            if (conn == null)
            {
                var connectionString = "Data Source=DESKTOP-0LG28RG\\SQLEXPRESS05;Initial Catalog=PiStoreDB;Integrated Security=True";
                
                conn = new SqlConnection(connectionString);
                conn.Open();
            }

            return conn;
        }
    }
}
