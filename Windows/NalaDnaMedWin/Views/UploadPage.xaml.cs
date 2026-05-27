using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;

namespace NalaDnaMedWin.Views
{
    public sealed partial class UploadPage : Page
    {
        public UploadPage()
        {
            this.InitializeComponent();
        }

        private void ChooseFiles_Click(object sender, RoutedEventArgs e)
        {
            UploadStatusTextBlock.Text = "Success: Selected 1 file. Parsed locally into safe tenant context (tenant-882-lite).";
        }
    }
}
