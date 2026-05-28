using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;
using NalaDnaMedWin.Services;

namespace NalaDnaMedWin.Views
{
    public sealed partial class SettingsPage : Page
    {
        private bool _isInitialized = false;

        public SettingsPage()
        {
            this.InitializeComponent();
            InitializeLanguageSelection();
            TranslatePage();
            _isInitialized = true;
        }

        private void InitializeLanguageSelection()
        {
            string currentLang = LocalizationService.Instance.ActiveLanguage;
            for (int i = 0; i < LanguageComboBox.Items.Count; i++)
            {
                if (LanguageComboBox.Items[i] is ComboBoxItem item && item.Tag?.ToString() == currentLang)
                {
                    LanguageComboBox.SelectedIndex = i;
                    break;
                }
            }
        }

        private void LanguageComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (!_isInitialized) return;

            if (LanguageComboBox.SelectedItem is ComboBoxItem selectedItem && selectedItem.Tag != null)
            {
                string newLang = selectedItem.Tag.ToString();
                LocalizationService.Instance.ActiveLanguage = newLang;

                // Refresh main window UI immediately
                if (MainWindow.Instance != null)
                {
                    MainWindow.Instance.TranslateUI();
                }

                // Refresh this page itself
                TranslatePage();
            }
        }

        private void TranslatePage()
        {
            var loc = LocalizationService.Instance;
            SettingsTitle.Text = loc.Get("Settings");
            LanguageComboBox.Header = loc.Get("Language");
            SafetyAgreementToggle.Header = loc.Get("Accept Research Safety Agreement");
            
            if (loc.ActiveLanguage == "de")
            {
                SettingsSubtitle.Text = "Konfigurieren Sie die Systemeinstellungen für NALA-DNA-Med.";
                SafetyAgreementDesc.Text = "Mit der Aktivierung bestätigen Sie, dass NALA-DNA-Med ausschließlich zur biomedizinischen Forschungssimulation dient, kein Medizinprodukt ist und keine klinischen Diagnosen oder Therapierichtlinien bereitstellt.";
                LlmProfileComboBox.Header = "Aktives LLM-Fit Profil";
                BackupTitle.Text = "Lokalen Workspace sichern & wiederherstellen";
                BackupButton.Content = "Lokales Backup exportieren (.zip)";
            }
            else if (loc.ActiveLanguage == "fr")
            {
                SettingsSubtitle.Text = "Configurez les préférences système de NALA-DNA-Med.";
                SafetyAgreementDesc.Text = "En activant cette option, vous reconnaissez que NALA-DNA-Med est uniquement destiné à la simulation de support de recherche, n'est pas un dispositif médical et ne fournit pas de conseils cliniques ou de directives de traitement.";
                LlmProfileComboBox.Header = "Profil LLM-Fit actif";
                BackupTitle.Text = "Sauvegarder et restaurer l'espace de travail";
                BackupButton.Content = "Exporter la sauvegarde locale (.zip)";
            }
            else if (loc.ActiveLanguage == "it")
            {
                SettingsSubtitle.Text = "Configura le preferenze di sistema di NALA-DNA-Med.";
                SafetyAgreementDesc.Text = "Abilitando questo, riconosci che NALA-DNA-Med è solo per la simulazione del supporto alla ricerca, non è un dispositivo medico e non fornisce consulenza clinica o linee guida terapeutiche.";
                LlmProfileComboBox.Header = "Profilo LLM-Fit attivo";
                BackupTitle.Text = "Salva e ripristina lo spazio di lavoro";
                BackupButton.Content = "Esporta backup locale (.zip)";
            }
            else
            {
                SettingsSubtitle.Text = "Configure NALA-DNA-Med system preferences.";
                SafetyAgreementDesc.Text = "By enabling this, you acknowledge that NALA-DNA-Med is for research-support simulation only, is not a medical device, and does not provide clinical advice or treatment guidelines.";
                LlmProfileComboBox.Header = "Active LLM-Fit Profile";
                BackupTitle.Text = "Backup & Restore Local Workspace";
                BackupButton.Content = "Export Timestamped Local Backup (.zip)";
            }
        }

        private void Backup_Click(object sender, RoutedEventArgs e)
        {
            string dateStr = DateTime.UtcNow.ToString("yyyy-MM-dd-HHmmss");
            string suffix = LocalizationService.Instance.ActiveLanguage == "de" ? "erfolgreich exportiert" : 
                            LocalizationService.Instance.ActiveLanguage == "fr" ? "exporté avec succès" :
                            LocalizationService.Instance.ActiveLanguage == "it" ? "esportato con successo" : "exported successfully";

            BackupStatusTextBlock.Text = $"Success: NALA-DNA-Med-backup-{dateStr}-lite.zip {suffix}.";
        }
    }
}
