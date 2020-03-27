using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace _2lab
{
    class DB
    {
        SqlConnection conn;
        public void openConnection(string connStr)
        {
            conn = new SqlConnection(connStr);
            conn.Open();
        }

        public void closeConnection()
        {
            conn.Close();
        }

        public void add_client(string fio, string passport, int experience, string tel, string adr)
        {
            using (SqlCommand cmd = new SqlCommand("add_client", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fio", fio);
                cmd.Parameters.AddWithValue("@passport", passport);
                cmd.Parameters.AddWithValue("@experience", experience);
                cmd.Parameters.AddWithValue("@tel", tel);
                cmd.Parameters.AddWithValue("@adr", adr);
                cmd.ExecuteNonQuery();
            }

        }я сосу хххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххигрикй
        public void drop_client(string passport)
        {
            using (SqlCommand cmd = new SqlCommand("drop_client", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@passport", passport);
                cmd.ExecuteNonQuery();
            }

        }

        public void change_client(string fio, string passport, int experience, string tel, string adr)
        {
            using (SqlCommand cmd = new SqlCommand("change_client", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fio", fio);
                cmd.Parameters.AddWithValue("@passport", passport);
                cmd.Parameters.AddWithValue("@experience", experience);
                cmd.Parameters.AddWithValue("@tel", tel);
                cmd.Parameters.AddWithValue("@adr", adr);
                cmd.ExecuteNonQuery();
            }

        }

        // ----------------------------------------------------------------------------

        public void add_car(string marka, string color, string status)
        {
            using (SqlCommand cmd = new SqlCommand("add_car", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@marka", marka);
                cmd.Parameters.AddWithValue("@color", color);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.ExecuteNonQuery();
            }

        }

        public void drop_car(string marka)
        {
            using (SqlCommand cmd = new SqlCommand("drop_car", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@marka", marka);
                cmd.ExecuteNonQuery();
            }

        }

        public void change_car(string marka, string color, string status)
        {
            using (SqlCommand cmd = new SqlCommand("change_car", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@marka", marka);
                cmd.Parameters.AddWithValue("@color", color);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.ExecuteNonQuery();
            }

        }

        //------------------------------------------------------------------

        public void add_contract(DateTime datestart, DateTime dateend, int client, int car, int cost)
        {
            using (SqlCommand cmd = new SqlCommand("add_contract", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@datestart", datestart);
                cmd.Parameters.AddWithValue("@dateend", dateend);
                cmd.Parameters.AddWithValue("@client", client);
                cmd.Parameters.AddWithValue("@car", car);
                cmd.Parameters.AddWithValue("@cost", cost);
                cmd.ExecuteNonQuery();
            }

        }

        public void drop_contract(DateTime datestart, DateTime dateend)
        {
            using (SqlCommand cmd = new SqlCommand("drop_contract", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@datestart", datestart);
                cmd.Parameters.AddWithValue("@dateend", dateend);
                cmd.ExecuteNonQuery();
            }

        }
        public void change_contract(DateTime datestart, DateTime dateend, int client, int car, int cost)
        {
            using (SqlCommand cmd = new SqlCommand("change_contract", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@datestart", datestart);
                cmd.Parameters.AddWithValue("@dateend", dateend);
                cmd.Parameters.AddWithValue("@client", client);
                cmd.Parameters.AddWithValue("@car", car);
                cmd.Parameters.AddWithValue("@cost", cost);
                cmd.ExecuteNonQuery();
            }

        }
        //---------------------------------------------------------------------------------------------------

        public void add_dtp(DateTime datedtp,  int contract, int proc, string about)
        {
            using (SqlCommand cmd = new SqlCommand("add_dtp", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@datedtp", datedtp);
                cmd.Parameters.AddWithValue("@contract", contract);
                cmd.Parameters.AddWithValue("@procent", proc);
                cmd.Parameters.AddWithValue("@about", about);
                cmd.ExecuteNonQuery();
            }

        }

        public void drop_dtp(int contract)
        {
            using (SqlCommand cmd = new SqlCommand("drop_dtp", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@contract", contract);
                cmd.ExecuteNonQuery();
            }

        }

        public void change_dtp(DateTime datedtp, int contract,int proc, string about)
        {
            using (SqlCommand cmd = new SqlCommand("change_dtp", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@datedtp", datedtp);
                cmd.Parameters.AddWithValue("@contract", contract);
                cmd.Parameters.AddWithValue("@procent", proc);
                cmd.Parameters.AddWithValue("@about", about);
                cmd.ExecuteNonQuery();
            }

        }

    }
}
