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

namespace PiStore
{
    public partial class Menu : Form
    {
        public Menu()
        {
            InitializeComponent();
        }

        private void employeeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ManageEmployee form2 = new ManageEmployee();
            form2.Show();
        }

        private void clientToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ManageClient form2 = new ManageClient();
            form2.Show();
        }

        private void productToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ManageProduct form2 = new ManageProduct();
            form2.Show();
        }

        private void placeOrderToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ManagePlaceOrder form2 = new ManagePlaceOrder();
            form2.Show();
        }

        private void manageOrderToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ManageOrders form2 = new ManageOrders();
            form2.Show();
        }

        private void printBillToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ManageBill form2 = new ManageBill();
            form2.Show();
        }
    }
}
