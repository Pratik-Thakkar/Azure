## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy
	
## create azure files
	$AzFiles = "https://imanageukworkbackupsa.file.core.windows.net/backup-e30c/Backup Job E30CUKDMS01"
	$SgKey = "JP6QFenlU5BOu8dYaIEPFrnrefWsQ8bP7+XkI2LsETI1rXO1VzM0NazZX6NMGUUVaffRgApUVMZ1vds18LT7sg=="

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\BackupCopytoAzureFiles-E30C.log"
	
## Start capturing output
	Start-Transcript -path $LogFile
	echo ""
	
##  client archive directory
    $Source = "E:\Backup\Backup Job E30CUKDMS01"

## copy archived zip files to azure files with AzCopy
	echo ""	
	&Az /Source:$Source /Dest:$AzFiles /DestKey:$SgKey /A /XO
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		}

## Stop capturing output
	Stop-Transcript