#######
#
#
#
# Monitors Tableau status
# 
# to activate caching you have to modify 
## C:\Program Files (x86)\checkmk\service\check_mk.yml

    - pattern     : '$CUSTOM_LOCAL_PATH$\get_Tableau_status.ps1'           # in the local folder.
          async       : yes             # activates caching
        #  timeout     : 60              # in seconds, after expiring timeout all processes matching the pattern will be killed.
          run         : yes             # 
          cache_age   : 300
#
#




$tsm_status= tsm status -verbose


if ($tsm_status -like "*RUNNING*"){
$status_nr="0"
$status_word="OK"
} else
{
$status_nr="2"	
$status_word="CRITICAL"	}



# Umbrüche entfernen
#$tsm_statussstatus=$tsm_status.replace("`r`n","")
#$tsm_status



$tsm_match=$tsm_status -match 'Status:'

$tsm_status=$tsm_status -replace '[^a-zA-Z ]','_'

foreach($line in $tsm_status) {
$long_output += $line + "\n"
}


$status_nr + " Tableau_Status - " + $status_word + " - Tableau tsm status returns: " + $tsm_match + " (Details in long output)\n" +  $long_output 