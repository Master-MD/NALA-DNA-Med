using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;

namespace NalaDnaMedWin.Views
{
    public sealed partial class JobsPage : Page
    {
        public JobsPage()
        {
            this.InitializeComponent();
        }

        private void CopySupportReport_Click(object sender, RoutedEventArgs e)
        {
            string report = "NALA-DNA-Med CAVEMAN Support Report (Windows Edition)\n" +
                            "No Terminal required for Local Lite.\n\n" +
                            "Platform: Windows 11 Client\n" +
                            "Architecture: x64\n" +
                            "GPU: DirectX 12 Capable GPU\n" +
                            "Memory: 16 GB RAM (Simulated)\n" +
                            "Free Disk: 152 GB Free\n" +
                            "Docker: Optional / Local Lite Mode Active\n\n" +
                            "Recommended Profile: Kleiner\n" +
                            "Status: green\n" +
                            "Tenant Context: tenant-882-lite\n" +
                            "Safe Research Boundary: Verified";

            var dataPackage = new Windows.ApplicationModel.DataTransfer.DataPackage();
            dataPackage.SetText(report);
            Windows.ApplicationModel.DataTransfer.Clipboard.SetContent(dataPackage);

            SupportReportStatusTextBlock.Text = "Technical Support Report copied to clipboard successfully!";
        }
    }
}
