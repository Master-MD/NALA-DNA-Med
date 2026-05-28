using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;
using NalaDnaMedWin.Services;

namespace NalaDnaMedWin.Views
{
    public sealed partial class BioLabPage : Page
    {
        public BioLabPage()
        {
            this.InitializeComponent();
            TranslatePage();
        }

        private void TranslatePage()
        {
            var loc = LocalizationService.Instance;
            BioLabTitle.Text = loc.Get("BioLabDemo");
            BioLabWarningTextBlock.Text = loc.Get("SafetyTitle");
            QueryTextBox.PlaceholderText = loc.Get("PlaceholderQuery");
            SimulateButton.Content = loc.Get("ButtonSimulate");

            if (loc.ActiveLanguage == "de")
            {
                ResultTextBlock.Text = "Geben Sie eine Suchanfrage unten ein, um eine Literaturextraktion zu simulieren.";
            }
            else if (loc.ActiveLanguage == "fr")
            {
                ResultTextBlock.Text = "Saisissez une requête de recherche ci-dessous pour simuler une extraction de littérature.";
            }
            else if (loc.ActiveLanguage == "it")
            {
                ResultTextBlock.Text = "Inserisci una query di ricerca qui sotto per simulare un'estrazione di letteratura.";
            }
            else
            {
                ResultTextBlock.Text = "Enter a research query below to simulate a literature extraction.";
            }
        }

        private async void Simulate_Click(object sender, RoutedEventArgs e)
        {
            var service = new Services.BioLabService();
            var loc = LocalizationService.Instance;
            try
            {
                var query = QueryTextBox.Text;
                var result = await service.RunDryRunAnalysisAsync(Guid.NewGuid().ToString(), Guid.NewGuid().ToString(), query);
                
                string syntheticLabel = loc.ActiveLanguage == "de" ? "[SIMULIERTES ERGEBNIS]" : 
                                         loc.ActiveLanguage == "fr" ? "[RÉSULTAT SIMULÉ]" :
                                         loc.ActiveLanguage == "it" ? "[RISULTATO SIMULATO]" : "[DEMO RESULT]";

                string warningLabel = loc.ActiveLanguage == "de" ? "WARNUNG: Dies ist eine synthetische Ausgabe für UI-Demonstrationszwecke. Es wurde keine reale biomedizinische Schlussfolgerung durchgeführt." :
                                      loc.ActiveLanguage == "fr" ? "AVERTISSEMENT: Il s'agit d'une sortie synthétique à des fins de démonstration de l'interface utilisateur." :
                                      loc.ActiveLanguage == "it" ? "ATTENZIONE: Questo è un output sintetico a scopo dimostrativo dell'interfaccia utente." : 
                                      "WARNING: This is a synthetic output for research UI demonstration purposes only. No real biomedical inference was performed.";

                ResultTextBlock.Text = $"{syntheticLabel} for '{query}':\n\n{warningLabel}";
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
