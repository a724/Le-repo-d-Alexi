$next7Days = 1..7
function GiveMeTheNext7Days($days) {
    foreach ($day in $days) {
        try {
            $date = (Get-Date).AddDays($day)
            Write-Host "Dans $day jour(s) : $date"
        }
        catch {
            Write-Host "Erreur lors de l'ajout de $day jours à la date actuelle: $_"
        }
    }
}
GiveMeTheNext7Days $next7Days
