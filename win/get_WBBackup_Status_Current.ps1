$a= Get-Wbjob 
$status="None running"
$status_nr="0"
$status_word="OK"
if($a.Jobstate -eq "Running"){
	$Status="Jobstate: " +$a.JobState + " Starttime: " + $a.StartTime +" "+$a.CurrentOperation
	$Status_nr="1"
	$status_word="WARNING"
    
}



$status_nr + " WBBackup_Job - " + $status_word + " - Windows Backup Job: " + $status


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