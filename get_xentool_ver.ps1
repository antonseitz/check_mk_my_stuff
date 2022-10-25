
$installedtools=Get-WmiObject -class win32_product | ? {$_.Name -like "*citrix*"} | select Name,Version
$agentver="NONE"
$toolver="NONE"
$agent_citrix_ver="NONE"
$agent_xenserver_ver="NONE"
foreach ($line in $installedtools){
	if ($line.name -like "*agent*") {
	$agentver=  $line.name +" "+ $line.version}
	   
   if ($line.name -like "*tool*") {
	$toolver= $line.name +" "+ $line.version}
	
   
}



# Agent (service) versions
# Citrix Agent
$agent_citrix=(Get-WmiObject win32_service | ?{$_.Name -like 'xensvc'})



if ($agent_citrix) {


$exe=$agent_citrix.pathname.replace('"','')
#$exe=(Get-Command "c:\Program Files\Citrix\XenTools\xenguestagent.exe").FileVersionInfo.FileVersion 

$agent_citrix_ver=$agent_citrix.DisplayName + " | Version:" + (Get-Command $exe).FileVersionInfo.FileVersion + " | Status: " + $agent_citrix.state
}
else { $agent_citrix_ver = "NONE" }




if (! $agent_citrix_ver ){$agent_citrix_ver="NONE"}


# XenServer Agent

$agent_xenserver=(Get-WmiObject win32_service | ?{$_.Name -like 'xenagent'})
$agent_xenserver_exe=$agent_xenserver.pathname
# fileVersionraw  stat fileVersion, weil fileversion abweichend von der GUI nur 1.0 gebracht hat
$agent_xenserver_ver=$agent_xenserver.DisplayName + " | Version: " + (Get-Command $agent_xenserver_exe).FileVersionInfo.ProductVersion + " | Status: " + $agent_xenserver.State



if ($agent_xenserver_ver -eq ""){$agent_xenserver_ver="NONE"}


# Driver versions


$drivers= Get-WmiObject Win32_PnPSignedDriver| ? {$_.Manufacturer -like "*citrix*" } | select DeviceName, Manufacturer, DriverVersion,DriverDate
if ($drivers) {
foreach ($line in $drivers){
	
if($line.DeviceName -like "*Bus*") {
    $outputshort=$line.DriverVersion
	$outputshort+=" (from: " + $line.Manufacturer + ")"
}
 
    $outputlong += $line.DeviceName + " : "
	$outputlong += $line.DriverVersion #PadLeft(15,[char]4)
    $outputlong += " DriverDate: "  + $line.DriverDate.split(".")[0].Substring(0,8) + " \n"
   
   
}}
else {$outputshort ="NONE"; $outputlong =" NONE" }

																												

																						 
																								
																					  



"0 XenTool - OK - CitrixApps (Info from APPS) : TOOL " + $toolver + " | AGENT " + $agentver 
"0 XenToolSrvAgentCitrix - OK - " + "(xensrv) : " + $agent_citrix_ver
"0 XenToolSrvAgentXenserver - OK - " + "(xenagent) : " + $agent_xenserver_ver
"0 XenToolDriver - OK - Version: " + $outputshort + " (Details in long output)\n" + $outputlong
