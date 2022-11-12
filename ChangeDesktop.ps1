$desktopList = Get-DesktopList
$currentDesktop = Get-DesktopName

Write-Host $env:USERPROFILE


Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select Desktop'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Abbrechen'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Select Desktop:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 80

foreach ($desktop in $desktopList) {
    $desktopName = $desktop."Name"
    if ($desktopName -ne $currentDesktop) {
        [void] $listBox.Items.Add($desktopName)
    }
}

$form.Controls.Add($listBox)
$form.Topmost = $true
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    foreach ($desktop in $desktopList) {
        $desktopName = $desktop."Name"
        if ($desktopName -eq $listBox.SelectedItem) {
            $userDesktop = $desktop;
            $userDesktopName = $userDesktop."Name";
        }
    }
    Write-Host "Your selected Desktop:" $userDesktopName;

    #remove all icons from currentDesktop
    $shortcuts = Get-ChildItem -Recurse -Include *.lnk -Path $env:USERPROFILE'\Desktop'
    foreach ($shortcut in $shortcuts) {
        Remove-Item -Path $shortcut -Recurse
    } 

    $toCopyItems = Get-ChildItem -Recurse -Include *.lnk -Path "$env:USERPROFILE\OneDrive\Dokumente\Desktops\$userDesktopName"

    #add icons from choosen Desktop
    foreach ($toCopyItem in $toCopyItems) {
        Copy-Item -Path $toCopyItem -Destination "$env:USERPROFILE\Desktop"
    }

    Switch-Desktop -Desktop "$userDesktopName"
}