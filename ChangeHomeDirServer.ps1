#Script to change the Server of the homedirectory for each user in an organization.
#Needs adjusted if the home folder is deeper in the folder structure than this example.
#Need to return and add a line that determines the size of the array $HD and then use a loop to recreate the array that got split
$Users = Get-ADUser -Filter 'enabled -eq $true' -Properties SAMAccountName, ProfilePath, HomeDirectory, HomeDrive | Select SAMAccountName, Name, HomeDirectory, HomeDrive | where-object -Property HomeDrive -eq "H:"
$Users | ForEach { 
    $HD = $_.HomeDirectory.split("\")
    $HD[2]="Insert Your New Server Location"
    $HomeDir= "\\" + $HD[2] + "\" + $HD[3] + "\" + $HD[4]
    Set-Aduser -Identity $_.SamAccountName -HomeDirectory $HomeDir -HomeDrive $_.HomeDrive
    }