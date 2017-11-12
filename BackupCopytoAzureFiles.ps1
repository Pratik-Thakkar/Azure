## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy
	
## create azure files
	$AzFiles = "https://xxxxx.file.core.windows.net/backup-d97c-veeam/Backup Job D97CUKDMS01"
	$SgKey = ""

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\BackupCopytoAzureFiles.log"
	
## Start capturing output
	Start-Transcript -path $LogFile
	echo ""
	
##  client archive directory
    $Source = "E:\Backup\Backup Job D97CUKDMS01"

## copy archived zip files to azure files with AzCopy
	echo ""	
	&Az /Source:$Source /Dest:$AzFiles /DestKey:$SgKey /A /XO
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		}

## Stop capturing output
	Stop-Transcript
