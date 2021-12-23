$ErrorActionPreference = "silentlyContinue"

write-Host "Getting all the Local Drives for Scan purpose .."  -ForegroundColor White -BackgroundColor Black

#Getting all the Local Drives to scan 
$Local_Drives = Get-PSDrive | Select-Object Root | Where-Object { $_.Root -like "*:*" }

write-Host "Searching Local Drives.." $Local_Drives.Root -ForegroundColor Magenta -BackgroundColor Black

write-Host "Kindly Wait for Scan to complete....." -ForegroundColor Yellow -BackgroundColor Black 

#adding a  loop to scan all drives::
Foreach ($DriveLetter in $Local_Drives) 
{

Write-Progress -Activity 'Scanning ...' -CurrentOperation $DriveLetter

Start-Sleep -Milliseconds 200

gci $DriveLetter.Root -rec -force -include *.jar -ea 0 | foreach {select-string "JndiLookup.class" $_} | select -exp Path |  Out-File -Append C:\${env:COMPUTERNAME}__$(get-date -f ddMMyyyy)_Detected_Log4j2.csv -Encoding UTF8 

}

write-host "Audit Scan completed and Report can be found in > " C:\${env:COMPUTERNAME}__$(get-date -f ddMMyyyy)_Detected_Log4j2.csv -ForegroundColor Green -BackgroundColor Black

