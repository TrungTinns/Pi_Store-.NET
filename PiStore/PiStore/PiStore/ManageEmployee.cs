﻿using DnsClient.Protocol;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection.Emit;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace PiStore
{
    public partial class ManageEmployee : Form
    {
        public ManageEmployee()
        {
            InitializeComponent();
            SqlConnection conn = DBConnect.GetInstance();
            display();
        }
        
        public void display()
        {
            SqlConnection conn = DBConnect.GetInstance();
            try
            {
                DataTable dt = new DataTable();
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM Employee", conn);
                sda.Fill(dt);   
                dataGridView1.DataSource = dt;  
                conn.Close();   
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btn_show_Click(object sender, EventArgs e)
        {
            SqlConnection conn = DBConnect.GetInstance();
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM View_Employee", conn);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                dataGridView1.DataSource = dt;
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        public void clear()
        {
            txt_Name.Text = "";
            txt_Email.Text = "";
            txt_Phone.Text = "";
            txt_Address.Text = "";
            txt_Salary.Text = "";
            txt_search.Text = "";
        }
        private void btn_add_Click(object sender, EventArgs e)
        {
            SqlConnection conn = DBConnect.GetInstance();
            if (!Regex.IsMatch(txt_Email.Text, @"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"))
            {
                MessageBox.Show("Invalid email");
            }
            else if (!Regex.IsMatch(txt_Phone.Text, @"^[0-9]{10}$"))
            {
                MessageBox.Show("Invalid phone number");
            }
            else if (txt_Name.Text == "" || txt_Email.Text == "" || txt_Phone.Text == "" || txt_Address.Text == "" || txt_Salary.Text == "")
            {
                MessageBox.Show("Please fill in the blank");
            }
            else
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO Employee values ('" + txt_Name.Text + "','" + txt_Email.Text + "','" + txt_Phone.Text + "','" + txt_Address.Text + "','" + txt_Salary.Text + "','" + dtp_HireDate.Value + "')", conn);
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Data Inserted Successfully.");
                    conn.Close();
                    clear();
                    display();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        private void btn_delete_Click(object sender, EventArgs e)
        {
            SqlConnection conn = DBConnect.GetInstance();
            
            SqlCommand cmd = new SqlCommand("sp_DeleteEmployee", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmployeeID", dataGridView1.SelectedRows[0].Cells["EmployeeID"].Value);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            display();
            clear();
        }

        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            txt_Name.Text = dataGridView1.Rows[e.RowIndex].Cells[1].Value.ToString();
            txt_Email.Text = dataGridView1.Rows[e.RowIndex].Cells[2].Value.ToString();
            txt_Phone.Text = dataGridView1.Rows[e.RowIndex].Cells[3].Value.ToString();
            txt_Address.Text = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
            txt_Salary.Text = dataGridView1.Rows[e.RowIndex].Cells[5].Value.ToString();
        }

        private void btn_update_Click(object sender, EventArgs e)
        {
            SqlConnection conn = DBConnect.GetInstance();
            SqlCommand com = new SqlCommand("sp_UpdateEmployee", conn);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@EmployeeID", dataGridView1.SelectedRows[0].Cells["EmployeeID"].Value);
            com.Parameters.AddWithValue("@EmployeeName", txt_Name.Text); 
            com.Parameters.AddWithValue("@EmployeeEmail", txt_Email.Text);
            com.Parameters.AddWithValue("@EmployeePhone", txt_Phone.Text);
            com.Parameters.AddWithValue("@EmployeeAddress", txt_Address.Text);
            com.Parameters.AddWithValue("@EmployeeSalary", txt_Salary.Text);
            com.Parameters.AddWithValue("@HireDate", dtp_HireDate.Value);
            conn.Open();
            com.ExecuteNonQuery();
            conn.Close();
            display();
        }

        private void btn_search_Click(object sender, EventArgs e)
        {
            SqlConnection conn = DBConnect.GetInstance();
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Employee WHERE EmployeeID = @EmployeeID", conn);
            cmd.Parameters.AddWithValue("EmployeeID", int.Parse(txt_search.Text));
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dataGridView1.DataSource = dt;
            conn.Close();
            clear();
        }

        private void btn_searchname_Click(object sender, EventArgs e)
        {
            SqlConnection conn = DBConnect.GetInstance();
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Employee WHERE EmployeeName = @EmployeeName", conn);
            cmd.Parameters.AddWithValue("EmployeeName", txt_Name.Text);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dataGridView1.DataSource = dt;
            conn.Close();
            clear();
        }

        private void btn_export_Click(object sender, EventArgs e)
        {
            if (dataGridView1.Rows.Count > 0)
            {
                SaveFileDialog sfd = new SaveFileDialog();
                sfd.Filter = "CSV (*.csv)|*.csv";
                sfd.FileName = "OutputEmployee.csv";
                bool fileError = false;
                if (sfd.ShowDialog() == DialogResult.OK)
                {
                    if (File.Exists(sfd.FileName))
                    {
                        try
                        {
                            File.Delete(sfd.FileName);
                        }
                        catch (IOException ex)
                        {
                            fileError = true;
                            MessageBox.Show("It wasn't possible to write the data to the disk." + ex.Message);
                        }
                    }
                    if (!fileError)
                    {
                        try
                        {
                            int columnCount = dataGridView1.Columns.Count;
                            string columnNames = "";
                            string[] outputCsv = new string[dataGridView1.Rows.Count + 1];
                            for (int i = 0; i < columnCount; i++)
                            {
                                columnNames += dataGridView1.Columns[i].HeaderText.ToString() + ",";
                            }
                            outputCsv[0] += columnNames;

                            for(int i = 1; i < dataGridView1.Rows.Count; i++)
                                {
                                for (int j = 0; j < columnCount; j++)
                                {
                                    outputCsv[i] += dataGridView1.Rows[i - 1].Cells[j].Value.ToString() + ",";
                                }
                            }

                            File.WriteAllLines(sfd.FileName, outputCsv, Encoding.UTF8);
                            MessageBox.Show("Data Exported Successfully", "Info");
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Error :" + ex.Message);
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("No Record To Export ", "Info");
            }
        }
    }
        
}
