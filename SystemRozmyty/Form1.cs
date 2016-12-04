using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Collections;

namespace SystemRozmyty
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            numericUpDown2.Maximum = 250;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            File.Delete("bin/fakty.clp");

            StreamWriter sw = new StreamWriter("bin/fakty.clp");

            sw.WriteLine("(defglobal ?*zmOpad* = " + numericUpDown1.Value + " )");
            sw.WriteLine("(defglobal ?*zmPredkosc* = " + numericUpDown2.Value + " )");


            sw.Close();

            

            System.Diagnostics.Process.Start("C:/Users/Damian1/Documents/Visual Studio 2015/Projects/SystemRozmyty/SystemRozmyty/bin/Debug/bin/jess.bat ", "(batch fuz.clp)");

            System.Threading.Thread.Sleep(5000);

            richTextBox1.Clear();
            string wyn = "bin/results.txt";
            string[] lines = System.IO.File.ReadAllLines(wyn);
            foreach (string line in lines)
            {
                richTextBox1.Text += line + Environment.NewLine;
            }

        }
    }
}
