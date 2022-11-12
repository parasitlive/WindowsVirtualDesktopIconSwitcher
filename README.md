# WindowsVirtualDesktopIconSwitcher

Prequesites
* install VirtualDesktop via Powershell
* open Powershell
* copy & paste ``Install-Module -Name VirtualDesktop``
* follow the instructions

How to use?
 1. Create custom virtual desktop with name ``Work``
 2. Create folder ``Work`` within path C:\Users\{your user name}\OneDrive\Dokumente\Desktops
 3. final path C:\Users\{your user name}\OneDrive\Dokumente\Desktops\Work
 4. create shortcuts within the new folder for the Virtual Desktop
 5. execute script ``ChangeDesktop.ps1``

 What happens?
 * you choose Desktop ``Work``
 * every .lnk (Shortcut) at the desktop will be deleted
 * every .lnk Shortcut within C:\Users\{your user name}\OneDrive\Dokumente\Desktops\Work will be copied to the Desktop
 * Switch Desktop