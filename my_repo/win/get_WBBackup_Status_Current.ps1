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