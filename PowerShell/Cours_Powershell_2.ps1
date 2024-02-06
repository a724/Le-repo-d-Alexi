# Définition d'une fonction pour détecter si un produit est déjà installé en utilisant son ID de produit
function DetectExe($ProductID) {
    # Chemin de la base de registre contenant les informations de désinstallation
    $hive = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\"
    # Concaténation pour créer le chemin complet de la clé de registre
    $regKey = $hive + $ProductID
    # Retourne vrai si le chemin de la clé de registre existe, faux sinon
    return (Test-Path $regkey)
}

# Définition d'une fonction pour installer un exécutable si celui-ci n'est pas déjà installé
function InstallExe ($PathExe, $InstallParameter, $ProductID) {
    # Vérifie si le produit est déjà installé en utilisant son ID
    if (DetectExe $ProductId) {
        # Si le produit est trouvé, afficher un message
        Write-Host "EXE Trouvé"
    } else {
        # Prépare les arguments pour l'installation silencieuse
        $Arguments = "/i `"$PathExe`" $InstallParameter"
        # Lance le processus d'installation avec les arguments définis
        Start-Process -FilePath "$PathExe" -ArgumentList "$Arguments" -Wait -PassThru
        # Attend 20 secondes pour que l'installation se termine
        Start-Sleep -s 20
        
        # Vérifie à nouveau si le produit est installé après l'exécution du programme d'installation
        if (DetectExe $ProductId) {
            # Si le produit est détecté après l'installation, affiche un message de succès
            Write-Host "Install is OK"
        } else {
            # Si le produit n'est pas détecté après l'installation, affiche un message d'erreur
            Write-Host "Install NON"
        }
    }
}

# Lance un travail en arrière-plan pour tuer le processus "Postman" toutes les 20 secondes
$killProcessJob = Start-Job -Name "Kill_Process" -ScriptBlock {
    # Boucle infinie pour continuer à tuer le processus périodiquement
    while ($true) {
        # Tente de tuer le processus "Postman", ne renvoie aucune erreur si le processus n'existe pas
        Stop-Process -Name "Postman" -ErrorAction 'SilentlyContinue'
        # Attend 20 secondes avant de répéter l'opération
        Start-Sleep -s 20
    }
}

# Appel de la fonction InstallExe pour installer "Postman" avec les paramètres spécifiés
InstallExe "C:\Users\jujub\Downloads\Postman.exe" "/q" "Postman"
# Arrête et supprime le travail en arrière-plan une fois l'installation terminée
$killProcessJob | Stop-Job | Remove-Job
