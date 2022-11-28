$a= Get-Wbjob -previous 1
$status="None running"
$status_nr="0"
$status_word="OK"

if($a){
	$status="Last Job Status: " + $a.Jobstate
	
	if( $a.Jobstate -ne "Completed" ) {
	$Status_nr="2"
	$status_word="CRITICAL"
	}
	$status+=" Start: " + $a.StartTime + " End: " + $a.EndTime 
}

$status_nr + " WBBackup_Last - " + $status_word + " - Last Windows Backup Job Status: " + $status