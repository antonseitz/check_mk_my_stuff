



$installedtools=Get-WmiObject -class win32_product | ? {$_.Name -like "*citrix*"} | select Name,Version
$agentver="none"
$toolver="none"
foreach ($line in $installedtools){
	if ($line.name -like "*agent*") {
	$agentver= $line.version}
   
   if ($line.name -like "*tool*") {
	$toolver= $line.version}
   
}



$drivers= Get-WmiObject Win32_PnPSignedDriver| ? {$_.Manufacturer -like "*citrix*" } | select DeviceName, Manufacturer, DriverVersion
foreach ($line in $drivers){
	
if($line.DeviceName -like "*Bus*") {
    $outputshort=$line.DriverVersion
	$outputshort+=" (from: " + $line.Manufacturer + ")"
}
 
    $outputlong += $line.DeviceName + " : "
    $outputlong += $line.DriverVersion + " \n"
   
   
}




"0 XenTools - OK - Agent: " + $agentver + " Xen Tools: " + $toolver 
"0 XenToolsDriver - OK - Version: " + $outputshort + " (Details in long output)\n" + $outputlong 