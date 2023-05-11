# check_mk_my_stuff

Dieses Repo beinhaltet alle lokalen Checks, die ich momentan verwende. 
Linux und Win


## Nur mit Symlinks arbeiten !

Dieses REpo ins Verzeichnis /repo oder /check_mk_my_stuff unter 

dem root Verzeichnis

```C:\ProgramData\checkmk\agent\```

Clonen.

Von dort aktiviert man die benötigten Checks mit symlinks: 

per Script 


```PS C:\ProgramData\checkmk\agent\check_mk_my_stuff\win> .\activate_local_check.ps1 .\get_failed_logins.ps1```


```New-Item -target .\win\get_WBBackup_Status_Last.ps1 -ItemType SymbolicLink -path .\get_WBBackup_Status_Last.ps1```




