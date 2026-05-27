using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;

namespace NalaDnaMedWin.Views
{
    public sealed partial class ProjectsPage : Page
    {
        public ProjectsPage()
        {
            this.InitializeComponent();
        }

        private void CreateVault_Click(object sender, RoutedEventArgs e)
        {
            // Simulate adding a vault
            var newBorder = new Border
            {
                Background = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Transparent),
                BorderBrush = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.DarkGreen),
                BorderThickness = new Thickness(1),
                CornerRadius = new CornerRadius(8),
                Padding = new Thickness(16),
                Margin = new Thickness(0, 0, 0, 0)
            };

            var sp = new StackPanel();
            sp.Children.Add(new TextBlock { Text = "New Biomedical Research Vault", FontSize = 18, FontWeight = Microsoft.UI.Text.FontWeights.SemiBold, Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.White) });
            sp.Children.Add(new TextBlock { Text = "Custom local research workspace workspace for custom target curation.", FontSize = 14, Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.LightGray), Margin = new Thickness(0, 4, 0, 0) });
            sp.Children.Add(new TextBlock { Text = $"Tenant ID: tenant-882-lite  |  Vault ID: vault-{new Random().Next(100, 999)}", FontSize = 11, Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Gray), Margin = new Thickness(0, 8, 0, 0) });
            newBorder.Child = sp;

            VaultsListPanel.Children.Insert(0, newBorder);
        }
    }
}
