$last_n_lines=150

$a=get-content -Path C:\ms_backup\logs\ms_backup.full.log -tail $last_n_lines | Select-String  -Pattern "error|exception" 
$b=get-content -Path C:\ms_backup\logs\ms_backup.diff.log -tail $last_n_lines | Select-String  -Pattern "error|exception" 

$status="MSBACKUP Logfile Status: " 
$status_nr="0"
$status_word="OK"

if(($a.count -gt 0 ) -or ($b.count -gt 0)){
	$Status_nr="2"
	$status_word="CRITICAL"
	
	if($a.count -gt 0){
	$status+=" " + $a.count + " Error(s) found in last " + $last_n_lines+" lines of FULL Log ! Last Error: "
	$status +="Logfileline:" + $a[-1]
	}
	if($b.count -gt 0){
	$status+=" - " + $b.count + " Error(s) found in last " + $last_n_lines+" lines of DIFF Log ! Last Error: "
	$status +="Logfileline:" + $b[-1]
	}
	
	
	
	
	#$status+=" Start: " + $a.StartTime + " End: " + $a.EndTime 
}
# Umbrüche entfernen
$status=$status.replace("`r|`t|`n","")

$status_nr + " WBBackup_TxtLog - " + $status_word + " - " + $status