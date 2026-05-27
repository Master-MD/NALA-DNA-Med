using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using NalaDnaMedWin.Services;

namespace NalaDnaMedWin.Views
{
    public sealed partial class LLMFitPage : Page
    {
        private LLMFitService _fitService;
        private LlmDownloadManager _downloadManager;
        private LlmProfile _recommendedProfile;

        public LLMFitPage()
        {
            this.InitializeComponent();
            _fitService = new LLMFitService();
            _downloadManager = new LlmDownloadManager();
            _downloadManager.DownloadProgressChanged += OnDownloadProgressChanged;
            
            Loaded += LLMFitPage_Loaded;
        }

        private async void LLMFitPage_Loaded(object sender, RoutedEventArgs e)
        {
            // Simulate hardware scan
            _recommendedProfile = await _fitService.GetRecommendedProfileAsync();
            ProfileTextBlock.Text = _recommendedProfile.ToString();
            ModelNameTextBlock.Text = _downloadManager.GetRecommendedModelName(_recommendedProfile);
        }

        private async void DownloadButton_Click(object sender, RoutedEventArgs e)
        {
            DownloadButton.IsEnabled = false;
            ProgressPanel.Visibility = Visibility.Visible;
            SuccessText.Visibility = Visibility.Collapsed;
            DownloadProgressBar.Value = 0;
            ProgressText.Text = "Verbinde mit NALA Servern...";

            await _downloadManager.DownloadModelAsync(_recommendedProfile);

            ProgressText.Text = "Download abgeschlossen.";
            SuccessText.Visibility = Visibility.Visible;
            DownloadButton.Content = "Modell installiert";
        }

        private void OnDownloadProgressChanged(object sender, int progressPercentage)
        {
            DispatcherQueue.TryEnqueue(() =>
            {
                DownloadProgressBar.Value = progressPercentage;
                ProgressText.Text = $"{progressPercentage}% heruntergeladen...";
            });
        }
    }
}
