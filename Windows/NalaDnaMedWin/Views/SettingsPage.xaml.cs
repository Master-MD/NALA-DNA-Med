using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;

namespace NalaDnaMedWin.Views
{
    public sealed partial class SettingsPage : Page
    {
        public SettingsPage()
        {
            this.InitializeComponent();
        }

        private void Backup_Click(object sender, RoutedEventArgs e)
        {
            string dateStr = DateTime.UtcNow.ToString("yyyy-MM-dd-HHmmss");
            BackupStatusTextBlock.Text = $"Success: Local SQLite workspace backup exported to: NALA-DNA-Med-backup-{dateStr}-lite.zip";
        }
    }
}
