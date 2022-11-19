#if prompt for path use:
#$Drivers = Read-Host "Folder location"

#$showModel = (Get-WmiObject Win32_ComputerSystem).Model

$Drivers = "C:\Users\username\Desktop\drivers\"
#$Drivers = "C:\tmp\$showModel"

#Remove-Item -Path $Drivers -Recurse -Force -ErrorAction Ignore

#if(Test-Path $Drivers)
#{
   # Remove-Item -Path $Drivers -Recurse -ErrorAction Ignore
   # copy-Item -Path $copyFrom -Destination $Drivers -Recurse -ErrorAction Ignore
#}
#else
#{
#    copy-Item -Path $copyFrom -Destination $Drivers -Recurse -ErrorAction Ignore
#}

#if wait for subprocess to finish eg. close windows then use:
#Start-Process $_.FullName  -ArgumentList "/S", "/v", "/qn", "/silent", "/accepteula" -NoNewWindow -Wait} 

#faster way but some issues with parallel installations is:
# $proc = Start-Process $_.FullName  -ArgumentList @("/S", "/v", "/qn", "/silent", "/accepteula") -NoNewWindow 
# $proc | Wait-Process}

foreach($Driver in $Drivers)
{
    $setup = Get-ChildItem -Path $Drivers -Filter "*.exe" | ForEach-Object {Write-Host $_.FullName
                                                                            Start-Process $_.FullName  -ArgumentList "/S", "/v", "/qn", "/silent", "/accepteula" -NoNewWindow -Wait} 
                                                                            
                                                                            
}

foreach($Driver in $Drivers)
{
    $setup = Get-ChildItem -Path $Drivers -Recurse -Include *.msi  | ForEach-Object {Write-Host $_.FullName
                                                                                     Start-Process msiexec.exe -Args "/I `"$_`" /qb ADDLOCAL=ALL ALLUSERS=TRUE" -Wait
                                                                                     }
}


