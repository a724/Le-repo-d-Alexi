# Initialisation du tableau contenant les dates en utilisant Get-Date avec des chaînes de date spécifiques
$datetime = @(
    (Get-Date -Date "25-02-1991"), # Convertit la chaîne "25-02-1991" en objet DateTime
    (Get-Date -Date "20-10-1998"), # Convertit la chaîne "20-10-1998" en objet DateTime
    (Get-Date -Date "07-09-2004"), # Convertit la chaîne "07-09-2004" en objet DateTime
    (Get-Date -Date "24-09-1991"), 
    (Get-Date -Date "18-07-2001") # Convertit la chaîne "18-07-2001" en objet DateTime, manque une virgule à la fin de la ligne précédente
)
# Trouve la date la plus récente dans le tableau en triant les dates par ordre décroissant et en sélectionnant la première
$maxDate = $datetime | Sort-Object -Descending | Select-Object -First 1
# Définition de la fonction CalculerEcarts pour calculer l'écart en jours entre les dates et la date la plus récente
function CalculerEcarts ($dates) {
    # Trouve à nouveau la date la plus récente dans le tableau passé en paramètre
    $dateMax = $dates | Sort-Object -Descending | Select-Object -First 1
    # Parcourt chaque date dans le tableau de dates
    foreach ($date in $dates) {
        try {
            # Vérifie si la date courante n'est pas la date la plus récente
            if ($date -ne $dateMax) {
                # Calcule l'écart entre la date courante et la date la plus récente
                $ecart = $dateMax - $date
                
                # Affiche l'écart en jours entre la date courante et la date la plus récente
                Write-Host "L'écart entre $($date.ToString('dd-MM-yyyy')) et la date la plus récente $($dateMax.ToString('dd-MM-yyyy')) est de $($ecart.Days) jours."
            }
        } catch {
            # Affiche un message d'erreur si une exception est levée lors du calcul de l'écart
            Write-Host "Une erreur s'est produite lors du calcul de l'écart pour la date $date : $_"
        }
    }
}
# Appelle la fonction CalculerEcarts avec le tableau de dates
CalculerEcarts $datetime