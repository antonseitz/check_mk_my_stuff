



$installedtools=Get-WmiObject -class win32_product | ? {$_.Name -like "*citrix*"} | select Name,Version
$agentver="none"
$toolver="none"
foreach ($line in $installedtools){
	if ($line.name -like "*agent*") {
	$agentver= $line.version}
   
   if ($line.name -like "*tool*") {
	$toolver= $line.version}
   
}



$drivers= Get-WmiObject Win32_PnPSignedDriver| ? {$_.Manufacturer -like "*citrix*" } | select DeviceName, Manufacturer, DriverVersion,DriverDate
foreach ($line in $drivers){
	
if($line.DeviceName -like "*Bus*") {
    $outputshort=$line.DriverVersion
	$outputshort+=" (from: " + $line.Manufacturer + ")"
}
 
    $outputlong += $line.DeviceName + " : "
	$outputlong += $line.DriverVersion #PadLeft(15,[char]4)
    $outputlong += " DriverDate:"  + $line.DriverDate.split(".")[0].Substring(0,8) + " \n"
   
   
}




"0 XenTools - OK - Agent: " + $agentver + " Xen Tools: " + $toolver 
"0 XenToolsDriver - OK - Version: " + $outputshort + " (Details in long output)\n" + $outputlong 
