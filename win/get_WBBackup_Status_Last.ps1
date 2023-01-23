$a= Get-Wbjob -previous 1

$status="None done jobs yet"
$status_nr="0"
$status_word="OK"

if($a){
	#$status="Last Job Status: " + $a.Jobstate
	
	if(( $a.Jobstate -ne "Completed" ) -or ($a.HResult -ne 0)) {
	$Status_nr="2"
	$status_word= "CRITICAL"
	$status+=" Jobstate:" + $a.Jobstate
	$status+=" HResult: " + $a.HResult + " Errordescription: " +$a.Errordescription
	$status+=" Start: " + $a.StartTime + " End: " + $a.EndTime 
	}
	
	
	
	
	
}
# Umbrüche entfernen
$status=$status.replace("`r`n","")
$status_nr + " WBBackup_Last - " + $status_word + " - Last Windows Backup Job Status: " + $status