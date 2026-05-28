using System;
using System.Collections.Generic;
using System.Globalization;

namespace NalaDnaMedWin.Services
{
    public class LocalizationService
    {
        private static readonly Lazy<LocalizationService> _instance = new Lazy<LocalizationService>(() => new LocalizationService());
        public static LocalizationService Instance => _instance.Value;

        private string _activeLanguage;
        private readonly Dictionary<string, Dictionary<string, string>> _translations;

        private LocalizationService()
        {
            // Set default language based on system UI language
            string sysLang = CultureInfo.CurrentUICulture.TwoLetterISOLanguageName.ToLower();
            if (sysLang == "de" || sysLang == "fr" || sysLang == "it")
            {
                _activeLanguage = sysLang;
            }
            else
            {
                _activeLanguage = "en"; // Fallback to English
            }

            _translations = new Dictionary<string, Dictionary<string, string>>();
            InitializeTranslations();
        }

        public string ActiveLanguage
        {
            get => _activeLanguage;
            set
            {
                if (value == "en" || value == "de" || value == "fr" || value == "it")
                {
                    _activeLanguage = value;
                }
            }
        }

        public string Get(string key)
        {
            if (_translations.TryGetValue(_activeLanguage, out var langDict) && langDict.TryGetValue(key, out var text))
            {
                return text;
            }

            // Fallback to English if translation is missing
            if (_translations["en"].TryGetValue(key, out var fallbackText))
            {
                return fallbackText;
            }

            return key; // Return the key itself as last resort
        }

        private void InitializeTranslations()
        {
            // ------------------ ENGLISH ------------------
            _translations["en"] = new Dictionary<string, string>
            {
                { "AppTitle", "NALA-DNA-Med" },
                { "NotMedicalAdviceTitle", "! NOT MEDICAL ADVICE !" },
                { "NotMedicalAdviceSubtitle", "This software is for research support only. It is not a medical device." },
                { "Dashboard", "Dashboard" },
                { "LllFitAdvisor", "LLM-Fit Advisor" },
                { "ProjectsVaults", "Projects / Vaults" },
                { "UploadCenter", "Upload Center" },
                { "BioLabDemo", "BioLab Demo" },
                { "JobsAudit", "Jobs / Audit" },
                { "Resources", "Resources" },
                { "Settings", "Settings" },
                { "Welcome", "Welcome to NALA-DNA-Med" },
                { "LocalLiteMode", "Native WinUI 3 Client - Local Lite Mode" },
                { "Warning", "WARNING: Simulated dry-run only. Not for clinical use." },
                { "SafetyTitle", "CAUTION: Simulated dry-run only. Not for clinical use." },
                { "EnterQuery", "Enter a research query below to simulate a literature extraction." },
                { "PlaceholderQuery", "Search literature or compounds..." },
                { "ButtonSimulate", "Simulate" },
                { "ButtonCreateVault", "Create New Vault" },
                { "Language", "Language / Sprache" },
                { "ModelManager", "Model Manager" },
                { "ImportLocalModels", "Import Local Models" },
                { "ImportDesc", "Choose files from your local disk or Hugging Face links. Supported extensions: .gguf, .safetensors, .bin, .mlmodel, .mlpackage." },
                { "ButtonValidate", "Validate & Import" },
                { "BiomedicalFoundations", "Biomedical Foundations" },
                { "CoreMotivationTitle", "Core Scientific Motivation" },
                { "CoreMotivationDesc", "NALA-DNA-Med is founded on a bold vision: to shift biomedical focus from symptom management (which often causes severe side-effects like fatigue, bone loss, and dependency) to true cures and bio-regeneration." },
                { "RegenTitle", "• Bio-Regeneration:" },
                { "RegenDesc", "Exploring how organisms naturally regrow limbs and severed tissues. Utilizing cellular signaling models to understand how these processes could be induced in human cells." },
                { "RepairTitle", "• Organ Self-Repair:" },
                { "RepairDesc", "Studying the self-regenerative properties of the liver and translating these pathways to chronic tissue diseases (such as Rheumatism and Colitis Ulcerosa repair)." },
                { "CuresTitle", "• Direct Cures vs. Side-Effects:" },
                { "CuresDesc", "Providing open platforms to map cancer targets, genetic eye diseases, and autoimmune disorders directly to molecular datasets without relying on symptom-masking drugs." },
                { "AutoimmuneVaultTitle", "Autoimmune Bio-Regeneration Research" },
                { "AutoimmuneVaultDesc", "Focused on Rheumatism and Colitis Ulcerosa cell repair pathway modeling." },
                { "AxolotlVaultTitle", "Regenerative Biology (Axolotl Blastema)" },
                { "AxolotlVaultDesc", "Literature review and target analysis for bone/limb cell regrowth signaling." }
            };

            // ------------------ GERMAN ------------------
            _translations["de"] = new Dictionary<string, string>
            {
                { "AppTitle", "NALA-DNA-Med" },
                { "NotMedicalAdviceTitle", "! KEINE MEDIZINISCHE BERATUNG !" },
                { "NotMedicalAdviceSubtitle", "Diese Software dient nur der Forschungsunterstützung. Es ist kein Medizinprodukt." },
                { "Dashboard", "Dashboard" },
                { "LllFitAdvisor", "LLM-Fit Ratgeber" },
                { "ProjectsVaults", "Projekte / Tresore" },
                { "UploadCenter", "Upload-Zentrum" },
                { "BioLabDemo", "BioLab Demo" },
                { "JobsAudit", "Aufträge / Protokoll" },
                { "Resources", "Ressourcen" },
                { "Settings", "Einstellungen" },
                { "Welcome", "Willkommen bei NALA-DNA-Med" },
                { "LocalLiteMode", "Nativer WinUI 3 Client - Local-Lite-Modus" },
                { "Warning", "WARNUNG: Nur simulierte Testläufe. Nicht für die klinische Anwendung." },
                { "SafetyTitle", "ACHTUNG: Nur simulierte Testläufe. Nicht für klinische Zwecke." },
                { "EnterQuery", "Geben Sie unten eine Forschungsanfrage ein, um eine Literaturextraktion zu simulieren." },
                { "PlaceholderQuery", "Suche nach Fachliteratur oder Verbindungen..." },
                { "ButtonSimulate", "Simulieren" },
                { "ButtonCreateVault", "Neuen Tresor erstellen" },
                { "Language", "Sprache / Language" },
                { "ModelManager", "Modell-Manager" },
                { "ImportLocalModels", "Lokale Modelle importieren" },
                { "ImportDesc", "Wählen Sie Dateien von Ihrer Festplatte oder Hugging-Face-Links aus. Unterstützt: .gguf, .safetensors, .bin, .mlmodel, .mlpackage." },
                { "ButtonValidate", "Validieren & Importieren" },
                { "BiomedicalFoundations", "Biomedizinische Grundlagen" },
                { "CoreMotivationTitle", "Wissenschaftliche Kernmotivation" },
                { "CoreMotivationDesc", "NALA-DNA-Med basiert auf einer klaren Vision: Den biomedizinischen Fokus weg von der bloßen Symptombekämpfung (die oft schwere Nebenwirkungen wie Müdigkeit, Knochenabbau und Abhängigkeit verursacht) hin zu echten Heilungen und Bioregeneration zu lenken." },
                { "RegenTitle", "• Bioregeneration:" },
                { "RegenDesc", "Erforschung, wie Organismen auf natürliche Weise Gliedmaßen und Gewebe regenerieren. Nutzung zellulärer Signalmodelle, um diese Prozesse in menschlichen Zellen anzuregen." },
                { "RepairTitle", "• Organ-Selbstreparatur:" },
                { "RepairDesc", "Untersuchung der Selbstheilung der Leber und Übertragung dieser Signalwege auf chronische Gewebeerkrankungen (z. B. Rheuma- und Colitis-Ulcerosa-Reparatur)." },
                { "CuresTitle", "• Echte Heilungen vs. Nebenwirkungen:" },
                { "CuresDesc", "Bereitstellung offener Plattformen, um Krebs-Targets, genetische Augenkrankheiten und Autoimmunerkrankungen direkt mit molekularen Datensätzen zu verknüpfen, statt symptomlindernde Medikamente einzusetzen." },
                { "AutoimmuneVaultTitle", "Autoimmun-Bioregenerationsforschung" },
                { "AutoimmuneVaultDesc", "Fokussiert auf die Modellierung von Zellreparaturwegen bei Rheuma und Colitis Ulcerosa." },
                { "AxolotlVaultTitle", "Regenerationsbiologie (Axolotl-Blastem)" },
                { "AxolotlVaultDesc", "Literaturrecherche und Targetanalyse für das Signalwachstum von Knochen- und Gliedmaßen." }
            };

            // ------------------ FRENCH ------------------
            _translations["fr"] = new Dictionary<string, string>
            {
                { "AppTitle", "NALA-DNA-Med" },
                { "NotMedicalAdviceTitle", "! PAS DE CONSEIL MÉDICAL !" },
                { "NotMedicalAdviceSubtitle", "Ce logiciel est uniquement destiné au support de la recherche. Ce n'est pas un dispositif médical." },
                { "Dashboard", "Tableau de bord" },
                { "LllFitAdvisor", "Conseiller LLM-Fit" },
                { "ProjectsVaults", "Projets / Coffres" },
                { "UploadCenter", "Centre de téléchargement" },
                { "BioLabDemo", "Démo BioLab" },
                { "JobsAudit", "Tâches / Audit" },
                { "Resources", "Ressources" },
                { "Settings", "Paramètres" },
                { "Welcome", "Bienvenue sur NALA-DNA-Med" },
                { "LocalLiteMode", "Client natif WinUI 3 - Mode Local Lite" },
                { "Warning", "AVERTISSEMENT: Simulation uniquement. Pas d'utilisation clinique." },
                { "SafetyTitle", "ATTENTION: Simulation uniquement. Pas à des fins cliniques." },
                { "EnterQuery", "Saisissez une requête de recherche ci-dessous pour simuler une extraction de littérature." },
                { "PlaceholderQuery", "Rechercher de la littérature ou des composés..." },
                { "ButtonSimulate", "Simuler" },
                { "ButtonCreateVault", "Créer un nouveau coffre" },
                { "Language", "Langue / Language" },
                { "ModelManager", "Gestionnaire de modèles" },
                { "ImportLocalModels", "Importer des modèles locaux" },
                { "ImportDesc", "Choisissez des fichiers locaux ou des liens Hugging Face. Extensions supportées: .gguf, .safetensors, .bin, .mlmodel, .mlpackage." },
                { "ButtonValidate", "Valider et importer" },
                { "BiomedicalFoundations", "Fondations biomédicales" },
                { "CoreMotivationTitle", "Motivation scientifique fondamentale" },
                { "CoreMotivationDesc", "NALA-DNA-Med est fondé sur une vision audacieuse : déplacer l'attention biomédicale de la gestion des symptômes (qui provoquent souvent des effets secondaires graves comme la fatigue, la perte osseuse et la dépendance) vers de véritables guérisons et la bio-régénération." },
                { "RegenTitle", "• Bio-Régénération:" },
                { "RegenDesc", "Explorer comment les organismes régénèrent naturellement leurs membres et leurs tissus. Utilisation de modèles de signalisation cellulaire pour induire ces processus dans les cellules humaines." },
                { "RepairTitle", "• Auto-réparation des organes:" },
                { "RepairDesc", "Étudier les propriétés auto-régénératrices du foie et traduire ces voies vers les maladies tissulaires chroniques (comme le traitement des rhumatismes et de la colite ulcéreuse)." },
                { "CuresTitle", "• Guérisons directes vs effets secondaires:" },
                { "CuresDesc", "Fournir des plateformes ouvertes pour cartographier les cibles du cancer, les maladies oculaires génétiques et les troubles auto-immuns directement avec des ensembles de données moléculaires." },
                { "AutoimmuneVaultTitle", "Recherche en bio-régénération auto-immune" },
                { "AutoimmuneVaultDesc", "Axé sur la modélisation des voies de réparation cellulaire pour le rhumatisme et la colite ulcéreuse." },
                { "AxolotlVaultTitle", "Biologie régénérative (Blastème d'Axolotl)" },
                { "AxolotlVaultDesc", "Revue de la littérature et analyse des cibles pour la régénération osseuse/des membres." }
            };

            // ------------------ ITALIAN ------------------
            _translations["it"] = new Dictionary<string, string>
            {
                { "AppTitle", "NALA-DNA-Med" },
                { "NotMedicalAdviceTitle", "! NESSUN CONSIGLIO MEDICO !" },
                { "NotMedicalAdviceSubtitle", "Questo software è solo per il supporto alla ricerca. Non è un dispositivo medico." },
                { "Dashboard", "Cruscotto" },
                { "LllFitAdvisor", "Consulente LLM-Fit" },
                { "ProjectsVaults", "Progetti / Caveau" },
                { "UploadCenter", "Centro di caricamento" },
                { "BioLabDemo", "Demo BioLab" },
                { "JobsAudit", "Lavori / Audit" },
                { "Resources", "Risorse" },
                { "Settings", "Impostazioni" },
                { "Welcome", "Benvenuto su NALA-DNA-Med" },
                { "LocalLiteMode", "Client nativo WinUI 3 - Modalità Local Lite" },
                { "Warning", "ATTENZIONE: Solo simulazione. Non per uso clinico." },
                { "SafetyTitle", "ATTENZIONE: Solo simulazione. Non per scopi clinici." },
                { "EnterQuery", "Inserisci una query di ricerca qui sotto per simulare un'estrazione di letteratura." },
                { "PlaceholderQuery", "Cerca letteratura o composti..." },
                { "ButtonSimulate", "Simula" },
                { "ButtonCreateVault", "Crea nuovo caveau" },
                { "Language", "Lingua / Language" },
                { "ModelManager", "Gestore modelli" },
                { "ImportLocalModels", "Importa modelli locali" },
                { "ImportDesc", "Scegli file locali o link Hugging Face. Estensioni supportate: .gguf, .safetensors, .bin, .mlmodel, .mlpackage." },
                { "ButtonValidate", "Valida e importa" },
                { "BiomedicalFoundations", "Fondazioni biomediche" },
                { "CoreMotivationTitle", "Motivazione scientifica fondamentale" },
                { "CoreMotivationDesc", "NALA-DNA-Med si basa su una visione audace: spostare l'attenzione biomedica dalla gestione dei sintomi (che spesso causa gravi effetti collaterali come affaticamento, perdita ossea e dipendenza) a cure reali e bio-rigenerazione." },
                { "RegenTitle", "• Bio-Rigenerazione:" },
                { "RegenDesc", "Esplorare come gli organismi rigenerano naturalmente arti e tessuti recisi. Utilizzare modelli di segnalazione cellulare per indurre questi processi nelle cellule umane." },
                { "RepairTitle", "• Auto-riparazione degli organi:" },
                { "RepairDesc", "Studiare le proprietà auto-rigenerative del fegato e tradurre queste vie nelle malattie tissutali croniche (come la riparazione di reumatismi e colite ulcerosa)." },
                { "CuresTitle", "• Cure dirette vs effetti collaterali:" },
                { "CuresDesc", "Fornire piattaforme aperte per mappare i bersagli del cancro, le malattie oculari genetiche e i disturbi autoimmuni direttamente con set di dati molecolari." },
                { "AutoimmuneVaultTitle", "Ricerca sulla bio-rigenerazione autoimmune" },
                { "AutoimmuneVaultDesc", "Focalizzato sulla modellizzazione delle vie di riparazione cellulare per reumatismi e colite ulcerosa." },
                { "AxolotlVaultTitle", "Biologia rigenerativa (Blastema di Axolotl)" },
                { "AxolotlVaultDesc", "Revisione della letteratura e analisi dei bersagli per la rigenerazione ossea/degli arti." }
            };
        }
    }
}
