## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy
	
## create azure files
	$AzFiles = "https://xxxx.file.core.windows.net/backup-6695/Backup Job 6695"
	$SgKey = ""

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\BackupCopytoAzureFiles-6695.log"
	
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
