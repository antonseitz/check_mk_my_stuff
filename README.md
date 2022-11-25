# check_mk_my_stuff

Dieses Repo beinhaltet alle lokalen Checks, die ich momentan verwende. 
Linux und Win


## Nur mit Symlinks arbeiten !

Diese Checks müssen so geclont werden, das sie im Verzeichnis /my_repo unter 

dem root Verzeichnis

```C:\ProgramData\checkmk\agent\local```

liegen. 


Von dort aktiviert man die benötigten Checks mit symlinks: 

mit dem script activate.ps1 
ODER


```New-Item -target .\win\get_WBBackup_Status_Last.ps1 -ItemType SymbolicLink -path ..\..\get_WBBackup_Status_Last.ps1```




