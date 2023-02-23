<#
Author: Bruno Trindade Bragança
Github: https://github.com/brunotrbr
Date: 23/02/2023
#>

Write-Host
Write-Host "Creating directory structure"
Write-Host

$year = Read-Host "Type the desired year"
$destinty = Read-Host "Type destiny path without last slash (\)"

Write-Host "Creating directory" $year "in" $destinty

$path = $destinty + "\" + $year

New-Item -Path $path -ItemType Directory


for ($i = 1; $i -le 12 ; $i++)
{
    if ($i -lt 10)
    {
        $current_path = $path + "\0" + $i
        
    } 
    else 
    {
        $current_path = $path + "\" + $i
    }
    New-Item -Path $current_path -ItemType Directory
}

Write-Host
Write-Host "End"