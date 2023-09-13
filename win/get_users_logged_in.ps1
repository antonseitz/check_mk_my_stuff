$users= quser

# der output von quser hat leider bei angemeldeten Usern 7 spalten, bei getrennten 6.
# deswegen zählen wird z.T. von hinten im Array

$outputshort = $outputlong =""

$outputlong=$users[0] + "\n" # Erste Zeile


for ( $i=1 ; $i -le ($users.length -1) ; $i++ ){
#($line in $users){
	$line=$users[$i]
	$line = $line -replace "^\s",""
	$line_worte =($line	-replace "\s+"," ").Split()
	$outputshort += $line_worte[0] +" " # username
	$outputshort += $line_worte[1] +" " # sessionname BEI GETRENNTEN USERN ist das leer !
	$outputshort += $line_worte[-5] +" " # ID
	$outputshort += $line_worte[-4] +" " # STATUS
	
	$outputshort += "Leerlauf seit: " + $line_worte[-3]   # LEERLAUF
	if($line_worte[-3].contains(":")){
		$outputshort += " h"
	}else {
		$outputshort += " min"
	}
    $outputshort += " "
   # ANMELDEDATUM UND -ZEIT
    #$outputshort += $line_worte[-2] +" " # Anmeldedatum
	#$outputshort += $line_worte[-1] +" " # Anmeldezeit
	$outputshort +=  " | "
	$outputlong += $line #-Replace '\s+',' ' 
	$outputlong += "\n"
#$outputshort = " (Details in long output)" 
}

#-Replace '\s+',' '
"0 Users_logged_in - OK - Version: " + $outputshort + " (Details in long output)\n" + $outputlong
