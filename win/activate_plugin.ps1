get-childitem (${env:ProgramFiles(x86)} + "\checkmk\service\plugins" )

"which one to activate?"

$plugin= read-host
New-Item -target (${env:ProgramFiles(x86)} + "\checkmk\service\plugins\" + $plugin) -ItemType SymbolicLink -path ..\..\plugins\$plugin