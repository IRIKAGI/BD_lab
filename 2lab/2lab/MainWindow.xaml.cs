using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace _2lab
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        string connStr = @"Data Source=SHOGUN;Initial Catalog=Arenda;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        DataTable Clients = new DataTable();
        DataTable Contracts = new DataTable();
        DataTable DTPs = new DataTable();
        DataTable Cars = new DataTable();

        private void addClient_Click(object sender, RoutedEventArgs e)
        {
            string fio = textBoxFio.Text;
            string passport = textBoxPassport.Text;
            int experience = Convert.ToInt32(textBoxExperience.Text);
            string tel = textBoxTel.Text;
            string adr = textBoxAddress.Text;
            if (fio.Length == 0 || passport.Length == 0
                || tel.Length == 0 || adr.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_client(fio, passport, experience, tel, adr);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void dropClient_Click(object sender, RoutedEventArgs e)
        {
            string passport = textBoxPassport.Text;

            if (passport.Length == 0)
            {
                MessageBox.Show("Проверьте данные паспорта");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_client(passport);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void changeClient_Click(object sender, RoutedEventArgs e)
        {
            string fio = textBoxFio.Text;
            string passport = textBoxPassport.Text;
            int experience = Convert.ToInt32(textBoxExperience.Text); ;
            string tel = textBoxTel.Text;
            string adr = textBoxAddress.Text;
            if (fio.Length == 0 || passport.Length == 0
                || tel.Length == 0 || adr.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_client(fio, passport, experience, tel, adr);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void allClients_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getAllClients";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    Clients.Clear();
                    // Заполняем Dataset
                    command.Fill(Clients);
                    // Отображаем данные
                    usersGrid.ItemsSource = Clients.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }
        //--------------------------------------------------------------------------------------------------------------------
        private void addCar_Click(object sender, RoutedEventArgs e)
        {
            string marka = textBoxMarka.Text;
            string color = textBoxColor.Text;

            string status = textBoxStatus.Text;

            if (marka.Length == 0 || color.Length == 0
                || status.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_car(marka, color, status);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void dropCar_Click(object sender, RoutedEventArgs e)
        {
            string marka = textBoxMarka.Text;

            if (marka.Length == 0)
            {
                MessageBox.Show("Проверьте данные марки");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_car(marka);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void changeCar_Click(object sender, RoutedEventArgs e)
        {
            string marka = textBoxMarka.Text;
            string color = textBoxColor.Text;

            string status = textBoxStatus.Text;

            if (marka.Length == 0 || color.Length == 0
                || status.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_car(marka, color, status);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void allCars_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getAllCars";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    Cars.Clear();
                    // Заполняем Dataset
                    command.Fill(Cars);
                    // Отображаем данные
                    CarsGrid.ItemsSource = Cars.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }





        //---------------------------------------------------------------------------------------------------------------

        private void addContract_Click(object sender, RoutedEventArgs e)
        {
            DateTime datestart = DateStart.SelectedDate.Value; ;
            DateTime dateend = DateEnd.SelectedDate.Value; ;

            int client = Convert.ToInt32(textBoxClient.Text);
            int car = Convert.ToInt32(textBoxCar.Text);
            int cost = Convert.ToInt32(textBoxCost.Text);
            if (DateStart.SelectedDate.Value == null || DateEnd.SelectedDate.Value == null)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_contract(datestart, dateend, client, car, cost);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void dropContract_Click(object sender, RoutedEventArgs e)
        {
            DateTime datestart = DateStart.SelectedDate.Value; ;
            DateTime dateend = DateEnd.SelectedDate.Value; ;

            if (DateStart.SelectedDate.Value == null || DateEnd.SelectedDate.Value == null)
            {
                MessageBox.Show("Проверьте данные даты");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_contract(datestart, dateend);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void changeContract_Click(object sender, RoutedEventArgs e)
        {
            DateTime datestart = DateStart.SelectedDate.Value; ;
            DateTime dateend = DateEnd.SelectedDate.Value; ;

            int client = Convert.ToInt32(textBoxClient.Text);
            int car = Convert.ToInt32(textBoxCar.Text);
            int cost = Convert.ToInt32(textBoxCost.Text);
            if (DateStart.SelectedDate.Value == null || DateEnd.SelectedDate.Value == null)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_contract(datestart, dateend, client, car, cost);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void allContracts_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getallContracts";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    Contracts.Clear();
                    // Заполняем Dataset
                    command.Fill(Contracts);
                    // Отображаем данные
                    contractsGrid.ItemsSource = Contracts.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }
        //--------------------------------------------------------------------------------------------------
        private void addDtp_Click(object sender, RoutedEventArgs e)
        {
            DateTime datedtp = DateDtp.SelectedDate.Value;

            int contract = Convert.ToInt32(textBoxIdContract.Text);
            int proc = Convert.ToInt32(textBoxProcent.Text);
            string about = textBoxAbout.Text;
            if (DateDtp.SelectedDate.Value == null || about.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_dtp(datedtp, contract, proc, about);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void dropDtp_Click(object sender, RoutedEventArgs e)
        {


            int contract = Convert.ToInt32(textBoxIdContract.Text);

            if (contract == 0)
            {
                MessageBox.Show("Проверьте данные номера контракта");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_dtp(contract);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void changeDtp_Click(object sender, RoutedEventArgs e)
        {
            DateTime datedtp = DateDtp.SelectedDate.Value;

            int contract = Convert.ToInt32(textBoxIdContract.Text);
            int proc = Convert.ToInt32(textBoxProcent.Text);
            string about = textBoxAbout.Text;
            if (DateDtp.SelectedDate.Value == null || about.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_dtp(datedtp, contract,  proc, about);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }

        private void allDtp_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getAllDtp";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    DTPs.Clear();
                    // Заполняем Dataset
                    command.Fill(DTPs);
                    // Отображаем данные
                    dtpGrid.ItemsSource = DTPs.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void spisok_arend_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("spisok_arend", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@datestart", SqlDbType.Date).Value = DateStart.SelectedDate.Value;
                        cmd.Parameters.AddWithValue("@dateend", SqlDbType.Date).Value = DateEnd.SelectedDate.Value;
                        con.Open();

                        cmd.ExecuteNonQuery();

                        SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        dataAdapter.Fill(dt);
                        contractsGrid.ItemsSource = dt.DefaultView;
                        dataAdapter.Update(dt);

                        con.Close();

                        MessageBox.Show("Выполнено !!!");
                        con.Close();
                    }

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        } 
    }
}
