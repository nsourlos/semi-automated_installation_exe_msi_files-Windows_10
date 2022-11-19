# Automatic Installation of executable files (.exe, .msi) from folder - Windows 10

![Alt text](./semi-automated-exe-and-msi-file-installation-windows-10.svg)

[![forthebadge](https://forthebadge.com/images/badges/made-with-python.svg)](https://www.python.org/)
[![forthebadge](https://forthebadge.com/images/badges/uses-badges.svg)](https://forthebadge.com)

[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-no-red.svg)]( https://github.com/nsourlos/semi-automated_installation_exe_msi_files-Windows_10)

> This script installs files in a folder (`.exe`, `.msi`) with their default settings (like clicking `next` all the time when these files are manually installed), and it doesn’t install additional tools (eg. antivirus, toolbars, etc.). It might be possible to get a shortcut in Desktop depending on the specific defaults of each app. Depending on the default information of the last window during the installation process, the app and/or a browser tab may launch, along with some app-specific messages.

To run the script administration privileges are required since some apps need to click a **yes** option in an additional window that appears. To do that we go to **Powershell**, execute it as **Admin** and then execute one of the following commands depending on if we want to have privileges only in this **Powershell** window (first command) or also in the future (second command):

```bash
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process –Force
```

```bash
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine –Force
```

More information on how to change execution policy can be found [here](https://stackoverflow.com/questions/27753917/how-do-you-successfully-change-execution-policy-and-enable-execution-of-powershe) and [here](https://www.easy365manager.com/script-ps1-cannot-be-loaded-because-running-scripts-is-disabled-on-this-system/)

At last, we should open the script and change the line
```bash
$Drivers = "C:\Users\username\Desktop\drivers\"
```
with the path of the folder that contains the files to be installed.

Then, to actually run the script we should execute the following command in the **Powershell** (need to `Run as administrator` to install apps that need admin rights), as explained in [here]( https://stackoverflow.com/questions/2035193/how-to-run-a-powershell-script):

```bash
./auto_install.ps1
```

The basic structure of the above script was taken from [this](https://community.spiceworks.com/topic/2330185-install-multiple-exe-with-powershell)

### Semi-automated (preferred) and fully-automated methods

There are two ways to execute the script:

1. <ins>Semi-automated</ins>: An installation is initialized only when another application is installed and not in parallel with it, which is the safest way and guarantees that most of the apps will be installed correctly. The problem with that method is that every child window needs to be closed manually (also apps that launch with an icon tray on the bottom right menu etc. need to be closed manually, and in some rare cases it is even needed to kill a process with `Ctrl+Alt+Delete`) to continue with the installation of the next app. If an app is found that contains a virus from Windows Defender, it won’t be installed at all.

<!-- Semi-Automated took ~35mins for 55 programs, most of the time to install ‘Anaconda’ (~12mins). We have to close every child window (app that launches, icon tray on the bottom right menu (‘Vuze’, ‘Skype’) etc. - even to kill a process ‘Citrix’) to continue installation of the next app. If an app is found that it contains a virus from Windows Defender, it won’t be installed (‘Free video flip and rotate’, ‘RegDoctor’). ‘Vmaware’ is installed in a path in the Hard Drive Disk. -->


2. <ins>Fully Automated</ins>: Here, all apps will be installed at once, in parallel. Every time an `.exe` or `.msi` file is executed, the script initializes directly the next installation file in the folder, without waiting for the previous installation to finish first. This method is much faster and it even installs apps that were found to contain viruses in the above method (even though this was not true), but it creates a lot of issues since some apps require that there aren’t any other apps running/installing in parallel. For these apps, the installation will not be performed and they will be failure cases. Moreover, it might be the case that even though it seems that the installation of all apps in the folder has completed, some apps may still need to be installed. These problems do not exist in the above mentioned method. More information on how to use this method to fully automate installs (but with the previous mentioned errors) can be found [here](https://github.com/PowerShell/PowerShell/issues/15555)

<!-- Fully automated takes much less time (~20mins). This creates issues since some apps require that there aren’t any other apps that are currently installing. These will be failure cases (examples: ‘Winzip’, ‘Teams’, ‘Chrome Remote Desktop’ (maybe), ‘Vmaware’). There may also be cases in which apps will be installed once everything has run from the command prompt, seeming like installation is over. Such an example is ‘Anaconda’. This method, apart from being faster than method 1, it could also be better because if we ‘allow on devices’ apps with viruses of method 1, they will be installed properly. -->

The **Semi-automated** method was chosen for our **[script](/auto_install.ps1)**. Some lines need to be uncommented if the **Fully Automated** version will be used.

- In both of the above cases, if the script does not know how to install an app (there might be many options/non-standardized menu), it will pop out the installation for the user to click the settings and install it manually. 
- Even after the above, there are apps that cannot be installed automatically and will give error messages. Such apps may require a download first, may not support silent installation, may require other dependencies to be installed first, etc. 

<!-- Examples are: ‘Direct X’, ‘Flash Player’, ‘Google Chrome’ (in which download is required first), ‘Nero’, ‘Java’ (not support silent mode), ‘PDF Sam’ (requires ‘Java’), ‘Skype for Business’ (error with the path in this way), ‘Office’ (special menu with many options), ‘Discord’ (seems to be installed but cannot launch due to path error). -->

- There are also some rare cases in which a specific option needs to be clicked, and the script is not aware of that. Therefore, it will try to install the file automatically. This will give an error and the installation has to be reinitialized manually by the user. 
<!-- example: ‘Convert X to DVD’ -->

- At last, there are some cases in which the files are not processed at all since the menu is complicated, and no prompt appears. These should also be checked manually. 
<!-- Examples: ‘Kaspersky’, ‘SportZone’, ‘Free video cutter joiner’ -->

#### General Remarks
- There are also some options to download some well-known programs in an easier way with tools like [Ninite](https://ninite.com/). A detailed guide for such methods can be found [here](https://www.thewindowsclub.com/how-to-install-multiple-programs-at-once-in-windows)
- Detailed information on the `Start-Process` that is used in the script to automate the installations can be found [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.2)
- Information on why a different way in needed in the script to install `.msi` files can be found [here](https://stackoverflow.com/questions/51448642/installing-all-msi-files-within-a-folder)
- Another useful link on how to use `Write-Host` (which prints messages can be found [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_continue?view=powershell-7.2)
- Note: **Powershell** is built on the [`.NET` Common Language Runtime (CLR)](https://learn.microsoft.com/en-us/dotnet/standard/clr). All inputs and outputs are `.NET` objects.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
 
## License
[MIT License](LICENSE)
