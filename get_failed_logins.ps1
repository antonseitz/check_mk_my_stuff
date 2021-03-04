$after_h=(get-date).addhours(-1)
$after_min=(get-date).addminutes(-15)



$failed_logins_h_warn=20
$failed_logins_h_crit=100
$long=""

$ips=@()

$log_h=Get-EventLog -LogName Security -after $after_h -InstanceId 4625 |
select TimeGenerated, Eventid,
#@{Name="AnmeldeTyp"; Expression={$_.Replacementstrings[10]}},
#@{Name="Kontoname"; Expression={$_.Replacementstrings[5]}},
#@{Name="Arbeitsstationsname"; Expression={$_.Replacementstrings[13]}},
@{Name="QuellIP"; Expression={$_.Replacementstrings[19]}}



$log_min=Get-EventLog -LogName Security -after $after_min -InstanceId 4625 |
select TimeGenerated, Eventid,
#@{Name="AnmeldeTyp"; Expression={$_.Replacementstrings[10]}},
#@{Name="Kontoname"; Expression={$_.Replacementstrings[5]}},
#@{Name="Arbeitsstationsname"; Expression={$_.Replacementstrings[13]}},
@{Name="QuellIP"; Expression={$_.Replacementstrings[19]}}


$failed_logins_h=$log_h.count
$failed_logins_min=$log_min.count





foreach ($entry in $log_h){
$ips+=$entry.QuellIP 
}


if($failed_logins_h -lt 3){
$state="0"
$statetext="OK"}
elseif( $failed_logins_h -lt 20){
$state="1"
$statetext="WARN"}
else{
$state="2"
$statetext="CRIT"}


foreach ($id in ($ips | group | sort -Property count -Descending)) {

$long+=  [string]$id.count + " failed logins from IP: " + $id.Name + "\n"

}



"P Failed_logins failed_h=" + $failed_logins_h + ";" + $failed_logins_h_warn + ";" + $failed_logins_h_crit  + "|failed_min=" + $failed_logins_min + " " + $statetext + " - Failed Logins (last 15 min): " + $failed_logins_min + " After: " + $after + " (Details in long output)\n" + $long