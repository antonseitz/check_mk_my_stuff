get-childitem (${env:ProgramFiles(x86)} + "\checkmk\service\plugins" )

"
Which plugin from " + ${env:ProgramFiles(x86)} + "\checkmk\service\plugins do you want to activate?
Symlink in PROGRAMDATA\checkm\agent\plugins\ will be created
Type filename from list above here: 
"

$plugin= read-host
New-Item -target (${env:ProgramFiles(x86)} + "\checkmk\service\plugins\" + $plugin) -ItemType SymbolicLink -path ..\..\plugins\$plugin