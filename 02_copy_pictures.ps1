<#
Author: Bruno Trindade Bragança
Github: https://github.com/brunotrbr
Date: 23/02/2023
#>

$icloud_path = Read-Host "Type iCloud path (origin) without last slash (\)"
$icloud_path = $icloud_path + "\"

$year = (Get-Date).Year

$destiny_path = Read-Host "Type destiny path without last slash (\)"
$log_file = $destiny_path + "\log_" + (Get-Date -Format yyyy_MM_dd) + ".txt"

$destiny_path = $destiny_path + "\" + $year + "\"

Write-host
Write-host "Starting copy files from" $icloud_path "to" $destiny_path


Write-host
Write-Host "Creating log file"
New-Item -Path $log_file -ItemType "File" 2>> $log_file
Write-host
Write-Host "Log file created"

Write-host
Write-Host "Copying..."

Write-host "Copying files from" $icloud_path "to" $destiny_path  *>> $log_file
Write-Host "" *>> $log_file


$files = Get-ChildItem -Path $icloud_path 2>> $log_file

$exclude = Get-ChildItem -recurse $destiny_path 2>> $log_file


foreach ($file in $files)
{
    $current_file = $icloud_path + $file
    
    $creation_date = (Get-ChildItem -File $current_file).CreationTime 2>> $log_file
    
    $month = $creation_date.Month
    
    if ($month -lt 10)
    {
        $month = "0" + $month
    }

    $path_to_save = $destiny_path + $month
    Copy-Item -Path $current_file -Destination $path_to_save -Exclude $exclude -Verbose *>> $log_file
    Write-Host "" *>> $log_file
}

Write-Host
Write-Host "End" *>> $log_file
Write-Host "End"


<# Redirect meanings
* All output
1 Success output
2 Errors
3 Warning messages
4 Verbose output
5 Debug messages
#>