$a= Get-SmbSession | Select-Object #-Property ClientUserName

#foreach-object   {
#{# echo $a[$i]

#$word= -split $a[$i]
#$output=$output + $word[0]+ " "+  $word[-3] + " " }



foreach ($i in $a){
   $output=$output + ($i.ClientUserName).split("\")[1] + " "
   $output=$output + ($i.NumOpens) + " "
}




#}
#Write-Host ($a | Format-Table | Out-String)
"0 SMB_USERS - OK - Username and NumOpens: " + $output 