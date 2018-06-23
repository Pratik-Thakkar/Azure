## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy
	
## create azure files
	$AzFiles = "https://xxxx.file.core.windows.net/backup-c5bd/Backup Job C5BD"
	$SgKey = ""

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\BackupCopytoAzureFiles-C5BD.log"
	
## Start capturing output
	Start-Transcript -path $LogFile
	echo ""
	
##  client archive directory
    $Source = ""

## copy archived zip files to azure files with AzCopy
	echo ""	
	&Az /Source:$Source /Dest:$AzFiles /DestKey:$SgKey /A /XO
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		}

## Stop capturing output
	Stop-Transcript
