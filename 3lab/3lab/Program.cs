using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [SqlProcedure]
    public static int GetCount(SqlDateTime dateStart, SqlDateTime dateEnd)
    {
        int rows;
        SqlConnection conn = new SqlConnection("Context Connection=true");
        conn.Open();
        SqlCommand sqlCmd = conn.CreateCommand();
        sqlCmd.CommandText = @"select count(*) from Contracts where Date_arenda_start between @dateStart and @dateEnd";
        sqlCmd.Parameters.Add("@dateStart", dateStart);
        sqlCmd.Parameters.Add("@dateEnd", dateEnd);
        rows = (int)sqlCmd.ExecuteScalar();
        conn.Close();
        return rows;
    }
}