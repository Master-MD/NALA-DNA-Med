using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;

namespace NalaDnaMedWin.Views
{
    public sealed partial class BioLabPage : Page
    {
        public BioLabPage()
        {
            this.InitializeComponent();
        }

        private async void Simulate_Click(object sender, RoutedEventArgs e)
        {
            var service = new Services.BioLabService();
            try
            {
                var query = QueryTextBox.Text;
                var result = await service.RunDryRunAnalysisAsync(Guid.NewGuid().ToString(), Guid.NewGuid().ToString(), query);
                
                ResultTextBlock.Text = result.ResultText;
                ResultTextBlock.Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.LightGreen);
            }
            catch (Exception ex)
            {
                ResultTextBlock.Text = $"Error: {ex.Message}";
                ResultTextBlock.Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Red);
            }
        }
    }
}
