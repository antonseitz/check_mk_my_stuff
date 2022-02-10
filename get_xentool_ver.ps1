
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
    $outputlong += " DriverDate: "  + $line.DriverDate.split(".")[0].Substring(0,8) + " \n"
   
   
}


$agent_citrix_ver=(Get-Command "c:\Program Files\Citrix\XenTools\xenguestagent.exe").FileVersionInfo.FileVersion

$agent_xenserver_exe=(Get-WmiObject win32_service | ?{$_.Name -like 'xenagent'}).pathname
# fileVersionraw  stat fileVersion, weil fileversion abweichend von der GUI nur 1.0 gebracht hat
$agent_xenserver_ver=(Get-Command $agent_xenserver_exe).FileVersionInfo.ProductVersion



"0 XenTool - OK - Agent: " + $agentver + " Xen Tools: " + $toolver + " (listed under APPS)"
"0 XenToolAgentCitrix - OK - " + "Citrix VM Tools Management Agent (xensrv) :" + $agent_citrix_ver
"0 XenToolAgentXenserver - OK - " + "XenServer Agent (xenagent) :" + $agent_xenserver_ver
"0 XenToolDriver - OK - Version: " + $outputshort + " (Details in long output)\n" + $outputlong
