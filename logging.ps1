<#

.SYNOPSIS
	This function writes a message to a specified log file with the current time stamp

.DESCRIPTION
	This function writes a message to a specified log file with the current time stamp

.PARAMETER Message
	Message is the content that you wish to add to the log file
.PARAMETER Path
	The path to the log file to which you would like to write
	By default the function will create the path and file if it does not exist	
.PARAMETER Level
	Specify the criticality of the log information being written to the log (i.e. Error, Warning, Informational)	
.PARAMETER NoClobber
	Use NoClobber if you do not wish to overwrite an existing file

.EXAMPLE
	Write-Log -Message "Log message"
	Write-Log -Message "Log message" -Path "C:\Logs\Script.log" -Level "Error"

.NOTES
	Author: Arno Helmink
	Modified: 6/2/2017 09:30:00 AM
	
	Changelog: 
    * Code simplification and clarification 
    * Added documentation

.LINK
	http://www.helmink.net

#>

Function Write-Log
{
  [CmdletBinding()]
	Param 
	(
	  [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)] 
    [ValidateNotNullOrEmpty()]
    [string]$Message,

    [Parameter(Mandatory=$false)]
    [string]$Path="C:\Logs\PowerShell.log",	

    [Parameter(Mandatory=$false)]
		[ValidateSet("Error","Warn","Info")]
    [string]$Level="Info",	 
 
    [Parameter(Mandatory=$false)] 
    [switch]$NoClobber 
	)
 
  Begin 
  { 
    # Set VerbosePreference to Continue so that verbose messages are displayed 
    $VerbosePreference = 'Continue' 
  }
	
  Process 
  {     
    # If the file already exists and NoClobber was specified, do not write to the log 
    If ((Test-Path $Path) -AND $NoClobber) 
		{
      Write-Error "Log file $Path already exists, and you specified NoClobber. Either delete the file or specify a different name." 
      Return
    } 

    # If attempting to write to a log file in a folder/path that doesn't exist create the file including the path 
    ElseIf (!(Test-Path $Path)) 
		{ 
      Write-Verbose "Creating $Path." 
      New-Item $Path -ItemType File -Force | Out-Null
    } 
 
    Else 
		{ 
      # No action required 
    } 
 
    # Format date for log output 
    $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss" 
 
    # Write message to error, warning, or verbose pipeline and specify $LevelText 
    Switch ($Level) { 
      'Error' { 
        Write-Error $Message 
        $LevelText = 'ERROR:' 
      } 
      'Warn' { 
        Write-Warning $Message 
        $LevelText = 'WARNING:' 
      } 
      'Info' { 
        Write-Verbose $Message 
        $LevelText = 'INFO:' 
      } 
    } 
         
    # Write log entry to $Path 
    "$FormattedDate $LevelText $Message" | Out-File -FilePath $Path -Append 
  }
	
  End 
  { 
  }
	
}
