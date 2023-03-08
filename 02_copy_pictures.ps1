<#
Author: Bruno Trindade Bragança
Github: https://github.com/brunotrbr
Date: 08/03/2023
#>

$icloud_path = Read-Host "Type iCloud path (origin) without last slash (\)"
$icloud_path = $icloud_path + "\"

$year = (Get-Date).Year

$destiny_path = Read-Host "Type destiny path without last slash (\)"
$destiny_path = $destiny_path + "\"

$log_file = $destiny_path + "log_" + (Get-Date -Format yyyy_MM_dd) + ".txt"

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

foreach ($file in $files)
{    
    $creation_date = (Get-ChildItem -File $file.FullName).CreationTime 2>> $log_file

    $file_month = $creation_date.Month
    $file_year = $creation_date.Year
    $file_year = 2022

    if ($file_month -lt 10)
    {
        $file_month = "0" + $file_month
    }
    
    $path_to_save = $destiny_path + $file_year

    if ( -not (Test-Path -Path $path_to_save)) {
        Write-Host "$path_to_save not found." *>> $log_file
        Write-Host "End"
        Exit
    }

    $source = $icloud_path + $file.Name
    $destination = $path_to_save + "\" + $file_month
    $full_path_file = $destination + "\" + $file.Name

    if ( -not (Test-Path -Path $full_path_file -PathType Leaf)) {
        try{
            Copy-Item -Path $source -Destination $destination -Verbose *>> $log_file
            Write-Host "" *>> $log_file
        }
        catch [System.IO.IOException] {
            Write-Host $_ 
            Write-Host ""
            Write-Host "Retry"

            try {
                Copy-Item -Path $source -Destination $destination -Verbose *>> $log_file
                Write-Host "" *>> $log_file
            }
            catch {
                Write-Host
                Write-Host $_ *>> $log_file
                Write-Host "End" *>> $log_file
                Write-Host "End"
                Exit
            }
        }
    }
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