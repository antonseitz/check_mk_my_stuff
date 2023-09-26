#######
#
#
#
# Monitors Tableau status
# 
# to activate caching you have to modify 
## C:\Program Files (x86)\checkmk\service\check_mk.yml

#    - pattern     : '$CUSTOM_LOCAL_PATH$\get_Tableau_status.ps1'           # in the local folder.
#          async       : yes             # activates caching
        #  timeout     : 60              # in seconds, after expiring timeout all processes matching the pattern will be killed.
#          run         : yes             # 
#          cache_age   : 300
#
#


$ok=$halted=$degraded=0

$tsm_status= tsm status -verbose


if ($tsm_status -like "*RUNNING*"){
$status_nr="0"
$status_word="OK"
} else
{
$status_nr="2"	
$status_word="CRITICAL"	}







$tsm_match=$tsm_status -match 'Status:'

$tsm_status=$tsm_status -replace '[^a-zA-Z ]','_'

foreach($line in $tsm_status) {

#$line

$long_output += $line + "\n"

$line_ok=$line -match 'wird ausgef_hrt'
if($line_ok){ 
$ok+=1
}


$line_halted=$line -match 'wurde angehalten'
if($line_halted){
$halted += 1
}
$line_degraded=$line -match 'fehlerhaften Zustand'
if($line_degraded){
$degraded += 1
}

#$ok #
#$halted 
#$degraded
#
}
$hint="Manche Dienste sind angehalten, aber Status ist trotzdem RUNNING:\nDatenbankwartung,Sicherung_Wiederherstellung,Site_Import_Export\n\n"
$all=$ok + $degraded + $halted
$prozent=$ok/($halted + $ok + $degraded)
$all=$ok + $halted + $degraded
$status_nr + " Tableau_Status services=" + $prozent + ";.8;.9;0;1" + " Tableau TSM returns : " + $tsm_match + " Services: " + $ok + " of " + $all + " running, halted: "+ $halted + ", degraded:" + $degraded + " (Details in long output)\n" + $hint +   $long_output 