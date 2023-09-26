#$args[0]
#$args
$path=$args.replace(".\","")
$path="..\..\local\"  + $path
#$path
New-Item -target $args[0] -ItemType SymbolicLink -path $path