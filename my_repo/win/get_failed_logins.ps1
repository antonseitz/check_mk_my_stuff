set-culture -CultureInfo en-us

$after_h=(get-date).addhours(-1)
$after_min=(get-date).addminutes(-15)



$failed_logins_h_warn=10
$failed_logins_h_crit=20
$failed_logins_min_warn=10
$failed_logins_min_crit=20


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



foreach ($id in ($ips | group | sort -Property count -Descending)) {

$long+=  [string]$id.count + " failed logins from IP: " + $id.Name + "\n"

}



#"P Failed_logins failed_h=" + $failed_logins_h + ";" + $failed_logins_h_warn + ";" + $failed_logins_h_crit  + "|failed_min=" + $failed_logins_min + " " + $statetext + " - Failed Logins (last 15 min): " + $failed_logins_min + " After: " + $after + " (Details in long output)\n" + $long
"P Failed_logins failed_min={0};{1};{2}|failed_h={3};{4};{5} Failed Logins (last 15 min): {0} (last 60 min): {3}: (Details in long output)\n{6} "  -f $failed_logins_min, $failed_logins_min_warn, $failed_logins_min_crit ,  $failed_logins_h,  $failed_logins_h_warn, $failed_logins_h_crit,   $long  
