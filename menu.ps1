<#

.SYNOPSIS
  This function writes a selection menu to the screen
  
.DESCRIPTION
  This function writes a selection menu to the screen

.PARAMETER Title
  Title is the menu header

.EXAMPLE
  Show-Menu -Title 'My Menu'
  
.NOTES
  Author: Arno Helmink
  Modified: 7/2/2017 09:30:00 AM
  
  Changelog: 
  * Initial commit

.LINK
  http://www.helmink.net

#>

Function Show-Menu
{
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$true)]
    [string]$Title  
  )
  
  Clear-Host
  Write-Host "================ $Title ================"
    
  Write-Host "1: Press '1' for this option."
  Write-Host "2: Press '2' for this option."
  Write-Host "3: Press '3' for this option."
  Write-Host "Q: Press 'Q' to quit."
}

Show-Menu –Title 'My Menu'
$Selection = Read-Host "Please make a selection"

Switch ($Selection)
{
  '1' {
    Write-Host "You chose option #1"
  } 
  '2' {
    Write-Host "You chose option #2"
  } 
  '3' {
    Write-Host "You chose option #3"
  } 
  'q' {
    Return
  }
}
