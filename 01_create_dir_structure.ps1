<#
Author: Bruno Trindade Bragança
Github: https://github.com/brunotrbr
Date: 23/02/2023
#>

Write-Host
Write-Host "Creating directory structure"
Write-Host

if (-not ($args[0]) -and -not ($args[1])){
    Write-Host "Missing args: destiny [0] and year [1]"
    Exit
}

$destinty = $args[0]
$year = $args[1]

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