$TestProductCode = Get-WmiObject -Class win32_product | Where-Object IdentifyingNumber
Get-ChildItem -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\"

$hive = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\"
$KeyToTouch = "<GUID>"
$regEdit = $hive + $KeyToTouch
Test-Path $regKey

$Arguments = "/i `"$InstallFile`" TRANSFORMS=`"$Transform`" $InstallParameter"
Start-Process -FilePath 'msiexec.exe' -ArgumentList "$Arguments" -Wait -Paththru