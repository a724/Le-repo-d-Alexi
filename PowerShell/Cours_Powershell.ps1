Write-Host "Ca marche"

function DetectMSI($ProductCode) 
{
    $hive = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\"
    $regKey = $hive + $ProductCode
    return (Test-Path $regkey)
}
function InstallMSI ($InstallFile, $InstallParameter, $ProductCode) {
    if (DetectMSI $ProductCode) {
        Write-Host "Je n'ai rien a faire"
    }else {
            $Arguments = "/i `"$InstallFile`" $InstallParameter"
            Start-Process -FilePath 'msiexec.exe' -ArgumentList "$Arguments" -Wait -PassThru
            Start-Sleep -s 20
            
        if (DetectMSI $ProductCode) {
                Write-Host "Install is OK"
            } 
        else {
                Write-Host "Installation NON"
            }
        }
    
}

InstallMSI "C:\Users\jujub\Downloads\7z2401-x64.msi" "/n /l `"C:\temp\Install_7zip.log`"" "{23170F69-40C1-2702-2401-000001000000}"