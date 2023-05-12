# Virtio Tool installed

$tool_name="NONE"

$tool=Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'  -ErrorAction Ignore |
Where-Object DisplayName -like "*virtio-win-guest-tools*"

if ($tool){
# show these registry values per item:
$tool_name =$sw.DisplayName
$tool_version =$sw.DisplayVersion

# | Select-Object -Property DisplayName, DisplayVersion #, UninstallString, InstallDate
}


# Virtio Driver installed

$drv_name="NONE"

$drv=Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'  -ErrorAction Ignore |
Where-Object DisplayName -like "*virtio-win-driver-installer*"

if ($drv){
# show these registry values per item:
$drv_name =$drv.DisplayName
$drv_version =$drv.DisplayVersion

# | Select-Object -Property DisplayName, DisplayVersion #, UninstallString, InstallDate
}


 # Qemu Agent da ?


 
# Qemu  Agent
$agent_qemu=(Get-WmiObject win32_service | ?{$_.Name -like 'qemu-ga'})

$agent_qemu_out="NOT INSTALLED"

if ($agent_qemu) {

# Agent (service) versions

$t=$agent_qemu.pathname -match '([^"]+)'

$agent_qemu_exe=$matches[0]

$agent_qemu_displayname=$agent_qemu.DisplayName
$agent_qemu_version=(Get-Command $agent_qemu_exe).FileVersionInfo.FileVersion 

$agent_qemu_out=$agent_qemu_displayname + " | Version:" + $agent_qemu_version+ " | Status: " + $agent_qemu.state
}
else { $agent_qemu_ver = "NONE" }


if (! $agent_qemu_ver ){$agent_qemu_ver="NONE"}





# Driver versions


$drivers= Get-WmiObject Win32_PnPSignedDriver| ? {$_.Manufacturer -like "*Red Hat*" } | select DeviceName, Manufacturer, DriverVersion,DriverDate
if ($drivers) {
foreach ($line in $drivers){
	
#if($line.DeviceName -like "*Bus*") {
#    $outputshort=$line.DriverVersion
	#$outputshort+=" (from: " + $line.Manufacturer + ")"
#}
 
    $outputlong += $line.DeviceName + " : "
	$outputlong += $line.DriverVersion #PadLeft(15,[char]4)
    $outputlong += " DriverDate: "  + $line.DriverDate.split(".")[0].Substring(0,8) + " \n"
   
   
}}
else {$outputshort ="NONE"; $outputlong =" NONE" }



"0 VirtioAppsInstalled - OK - CitrixApps (Info from APPS) |TOOL: " + $tool_name + " Version: " + $tool_version + " | DRV: " + $drv_name + " Version: " + $drv_version
"0 VirtioQemuAgentInstalled - OK - " + "(qemu-ga) : " + $agent_qemu_out
"0 VirtioDriverVersion - OK - Version: " + $outputshort + " (Details in long output)\n" + $outputlong
