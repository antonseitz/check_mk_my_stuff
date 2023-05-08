# check_mk_my_stuff

Dieses Repo beinhaltet alle lokalen Checks, die ich momentan verwende. 
Linux und Win


## Nur mit Symlinks arbeiten !

Diese Checks liegen im Verzeichnis /repo oder /check_mk_my_stuff unter 

dem root Verzeichnis

```C:\ProgramData\checkmk\agent\local```

Von dort aktiviert man die benötigten Checks mit symlinks: 



```New-Item -target .\win\get_WBBackup_Status_Last.ps1 -ItemType SymbolicLink -path .\get_WBBackup_Status_Last.ps1```




