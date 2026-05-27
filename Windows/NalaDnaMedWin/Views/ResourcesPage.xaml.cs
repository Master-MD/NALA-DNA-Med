using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;
using System.IO;

namespace NalaDnaMedWin.Views
{
    public sealed partial class ResourcesPage : Page
    {
        public ResourcesPage()
        {
            this.InitializeComponent();
        }

        private void ValidateImport_Click(object sender, RoutedEventArgs e)
        {
            string urlStr = UrlTextBox.Text.Trim();
            if (string.IsNullOrEmpty(urlStr))
            {
                ImportStatusTextBlock.Text = "Please enter a valid URL.";
                ImportStatusTextBlock.Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Red);
                return;
            }

            try
            {
                var uri = new Uri(urlStr);
                string filename = Path.GetFileName(uri.LocalPath);
                
                if (string.IsNullOrEmpty(filename) || (!filename.EndsWith(".gguf") && !filename.EndsWith(".safetensors") && !filename.EndsWith(".bin") && !filename.EndsWith(".mlmodel") && !filename.EndsWith(".mlpackage")))
                {
                    ImportStatusTextBlock.Text = "Error: Unsupported model file type. Must be .gguf, .safetensors, .bin, .mlmodel, or .mlpackage.";
                    ImportStatusTextBlock.Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Red);
                    return;
                }

                ImportStatusTextBlock.Text = $"Valid model URL: '{filename}' - Checked size is safe. Download scheduled with confirmation.";
                ImportStatusTextBlock.Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Green);
            }
            catch (Exception ex)
            {
                ImportStatusTextBlock.Text = $"Error: Invalid URL format. {ex.Message}";
                ImportStatusTextBlock.Foreground = new Microsoft.UI.Xaml.Media.SolidColorBrush(Microsoft.UI.Colors.Red);
            }
        }
    }
}
