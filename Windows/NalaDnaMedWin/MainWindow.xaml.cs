using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Controls.Primitives;
using Microsoft.UI.Xaml.Data;
using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Navigation;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using WinRT.Interop;
using Microsoft.UI.Windowing;
using Microsoft.UI;

namespace NalaDnaMedWin
{
    public sealed partial class MainWindow : Window
    {
        public MainWindow()
        {
            this.InitializeComponent();
            SetWindowIcon("Assets/appicon.png");
        }

        private void SetWindowIcon(string iconPath)
        {
            var hWnd = WindowNative.GetWindowHandle(this);
            var windowId = Win32Interop.GetWindowIdFromWindow(hWnd);
            var appWindow = AppWindow.GetFromWindowId(windowId);
            
            // In a real Windows build, this requires the icon to be an .ico file.
            // appWindow.SetIcon(iconPath);
        }

        private void NavView_ItemInvoked(NavigationView sender, NavigationViewItemInvokedEventArgs args)
        {
            var navItemTag = args.InvokedItemContainer.Tag.ToString();
            
            switch (navItemTag)
            {
                case "Dashboard":
                    ContentFrame.Navigate(typeof(Views.DashboardPage));
                    break;
                case "BioLab":
                    ContentFrame.Navigate(typeof(Views.BioLabPage));
                    break;
                case "LLMFit":
                    ContentFrame.Navigate(typeof(Views.LLMFitPage));
                    break;
                case "Projects":
                    ContentFrame.Navigate(typeof(Views.ProjectsPage));
                    break;
                case "Upload":
                    ContentFrame.Navigate(typeof(Views.UploadPage));
                    break;
                case "Jobs":
                    ContentFrame.Navigate(typeof(Views.JobsPage));
                    break;
                case "Resources":
                    ContentFrame.Navigate(typeof(Views.ResourcesPage));
                    break;
                case "Settings":
                    ContentFrame.Navigate(typeof(Views.SettingsPage));
                    break;
            }
        }
    }
}
