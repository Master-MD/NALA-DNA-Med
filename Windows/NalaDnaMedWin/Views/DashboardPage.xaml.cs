using Microsoft.UI.Xaml.Controls;
using NalaDnaMedWin.Services;

namespace NalaDnaMedWin.Views
{
    public sealed partial class DashboardPage : Page
    {
        public DashboardPage()
        {
            this.InitializeComponent();
            TranslatePage();
        }

        private void TranslatePage()
        {
            var loc = LocalizationService.Instance;
            DashboardTitle.Text = loc.Get("Dashboard");
            ProjectsCardTitle.Text = loc.Get("ProjectsVaults");

            if (loc.ActiveLanguage == "de")
            {
                DashboardSubtitle.Text = "Nativer WinUI 3 Client - Local-Lite-Modus aktiv";
                ProjectsCardValue.Text = "3 Aktiv";
                ResourcesCardTitle.Text = "Lokale Ressourcen";
                LlmFitCardTitle.Text = "LLM-Fit Profil";
            }
            else if (loc.ActiveLanguage == "fr")
            {
                DashboardSubtitle.Text = "Mode Local Lite actif";
                ProjectsCardValue.Text = "3 actifs";
                ResourcesCardTitle.Text = "Ressources locales";
                LlmFitCardTitle.Text = "Profil LLM-Fit";
            }
            else if (loc.ActiveLanguage == "it")
            {
                DashboardSubtitle.Text = "Modalità Local Lite attiva";
                ProjectsCardValue.Text = "3 attivi";
                ResourcesCardTitle.Text = "Risorse locali";
                LlmFitCardTitle.Text = "Profilo LLM-Fit";
            }
            else
            {
                DashboardSubtitle.Text = "Local Lite Mode Active";
                ProjectsCardValue.Text = "3 Active";
                ResourcesCardTitle.Text = "Local Resources";
                LlmFitCardTitle.Text = "LLM-Fit Profile";
            }
        }
    }
}
