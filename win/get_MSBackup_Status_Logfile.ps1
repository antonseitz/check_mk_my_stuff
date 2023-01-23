$a=Select-String -Path C:\ms_backup\logs\ms_backup.diff.log -Pattern "error" #-Context 10 

$status="None done jobs yet"
$status_nr="0"
$status_word="OK"

if($a.count -gt 0 ){
	$Status_nr="2"
	$status_word="CRITICAL"
	$status="Last Logfile Status: " 
	
	#if(( $a.Jobstate -ne "Completed" ) -or ($a.HResult -ne 0)) {
	
	#$status_word="Jobstate:" + $a.Jobstate
	#$status_word+=" HResult: " + $a.HResult + " Errordescription: " +$a.Errordescription
	$status +="Logfile:" + $a[-1]
	
	
	
	
	
	#$status+=" Start: " + $a.StartTime + " End: " + $a.EndTime 
}
# Umbrüche entfernen
$status=$status.replace("`r|`t|`n","")

$status_nr + " WBBackup_TxtLog - " + $status_word + " - Last Windows Backup Job TXT Log: " + $status