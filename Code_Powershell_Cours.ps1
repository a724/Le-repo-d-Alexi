# Définition d'un tableau contenant les noms des processus à arrêter
$ProcessTab = @("Notepad", "Postman", "Spotify")

# Définition de la fonction Kill_Process pour arrêter les processus
function Kill_Process($ProcessList) {
    # Boucle foreach pour parcourir chaque processus dans la liste fournie
    foreach ($Process in $ProcessList) {
        try {
            # Tentative d'arrêt du processus en cours
            Stop-Process -Name $Process -ErrorAction 'Stop'
        }
        catch {
            # Bloc catch pour gérer les erreurs, par exemple si le processus n'existe pas
            Write-Host "Le process" $Process "n'est pas en cours d'execution"
        }
    }
}

# Appel de la fonction Kill_Process en passant le tableau de processus comme argument
Kill_Process $ProcessTab