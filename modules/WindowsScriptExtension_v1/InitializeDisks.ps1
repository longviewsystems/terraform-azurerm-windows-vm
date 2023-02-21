Param (
    [string]$winrmenablement
)

Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "DataDisk" 

if ( $winrmenablement -match 'true' )
{ 
  .\ConfigureRemotingForAnsible.ps1
}