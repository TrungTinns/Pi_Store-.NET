using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.OleDb;

namespace PiStore
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Login_Load(object sender, EventArgs e)
        {

        }

        private void btn_login_Click(object sender, EventArgs e)
        {
            SqlConnection conn = DBConnect.GetInstance();
            String username, password;
            username = txt_username.Text;
            password = txt_password.Text;

            if (txt_username.Text == "" || txt_password.Text == "")
            {
                MessageBox.Show("Please fill in the blank");
            }
            else
            {
                try
                {
                    SqlCommand cmd = conn.CreateCommand();

                    cmd.CommandText = "select count(*) from Account where Username = @username and Password = @password";
                    cmd.Parameters.Add("@username", SqlDbType.NVarChar, 255).Value = username;
                    cmd.Parameters.Add("@password", SqlDbType.NVarChar, 255).Value = password;

                    int numberOfRecords = (int)cmd.ExecuteScalar();

                    if (numberOfRecords > 0)
                    {
                        username = txt_username.Text;
                        password = txt_password.Text;

                        Menu form2 = new Menu();
                        form2.Show();
                        this.Hide();
                    }
                    else
                    {
                        MessageBox.Show("Invalid account", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        txt_username.Clear();
                        txt_password.Clear();

                        txt_username.Focus();
                    }

                }
                catch (Exception)
                {
                    MessageBox.Show("Error");
                }
                finally
                {
                    conn.Close();
                }
            }   
        }

        private void btn_clear_Click(object sender, EventArgs e)
        {
            txt_username.Clear();
            txt_password.Clear();

            txt_username.Focus();
        }
    }
}
