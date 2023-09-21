set-culture -CultureInfo en-us

$after_60m=(get-date).addhours(-1)
$after_5min=(get-date).addminutes(-5)
$after_20min=(get-date).addminutes(-20)



$failed_logins_60m_warn=10
$failed_logins_60m_crit=20

$failed_logins_20min_warn=10
$failed_logins_20min_crit=20

$failed_logins_5min_warn=10
$failed_logins_5min_crit=20


$long=""

$ips=@()

$log_60m=Get-EventLog -LogName Security -after $after_60m -InstanceId 4625 |
select TimeGenerated, Eventid,
#@{Name="AnmeldeTyp"; Expression={$_.Replacementstrings[10]}},
#@{Name="Kontoname"; Expression={$_.Replacementstrings[5]}},
#@{Name="Arbeitsstationsname"; Expression={$_.Replacementstrings[13]}},
@{Name="QuellIP"; Expression={$_.Replacementstrings[19]}}



$log_5min=Get-EventLog -LogName Security -after $after_5min -InstanceId 4625 |
select TimeGenerated, Eventid,
#@{Name="AnmeldeTyp"; Expression={$_.Replacementstrings[10]}},
#@{Name="Kontoname"; Expression={$_.Replacementstrings[5]}},
#@{Name="Arbeitsstationsname"; Expression={$_.Replacementstrings[13]}},
@{Name="QuellIP"; Expression={$_.Replacementstrings[19]}}


$log_20min=Get-EventLog -LogName Security -after $after_20min -InstanceId 4625 |
select TimeGenerated, Eventid,
#@{Name="AnmeldeTyp"; Expression={$_.Replacementstrings[10]}},
#@{Name="Kontoname"; Expression={$_.Replacementstrings[5]}},
#@{Name="Arbeitsstationsname"; Expression={$_.Replacementstrings[13]}},
@{Name="QuellIP"; Expression={$_.Replacementstrings[19]}}


$failed_logins_60m=$log_60m.count
$failed_logins_5min=$log_5min.count
$failed_logins_20min=$log_20min.count



foreach ($entry in $log_60m){
$ips+=$entry.QuellIP 
}



foreach ($id in ($ips | group | sort -Property count -Descending)) {

$long+=  [string]$id.count + " failed logins from IP: " + $id.Name + "\n"

}



#"P Failed_logins failed_h=" + $failed_logins_h + ";" + $failed_logins_h_warn + ";" + $failed_logins_h_crit  + "|failed_min=" + $failed_logins_min + " " + $statetext + " - Failed Logins (last 15 min): " + $failed_logins_min + " After: " + $after + " (Details in long output)\n" + $long
"P Failed_logins failed_05min={0};{1};{2}|failed_20min={3};{4};{5}|failed_60mh={6};{7};{8} Failed Logins (last 5 min): {0} (last 20 min): {3} (last 60 min): {6}: (Details in long output)\n{9} "  -f $failed_logins_5min, $failed_logins_5min_warn, $failed_logins_5min_crit , $failed_logins_20min, $failed_logins_20min_warn, $failed_logins_20min_crit ,  $failed_logins_60m,  $failed_logins_60m_warn, $failed_logins_60m_crit, $long  
