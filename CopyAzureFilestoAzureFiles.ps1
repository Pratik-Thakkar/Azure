## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy
	
## create azure files
    $AzFilesSource = "https://imanageauworkservices.file.core.windows.net/sftp-storage/6b2b/PerthDelta2"
	$SourceKey = "cvc3SmHerOFb8uyAfsrhZcKkNW3hujNOJN9bynwYZUzHo8g6sku454ikWFUDYBYZl5G3XFHyOeDBsTmtPZ+wdg=="
	
	$AzFilesDest = "https://6b2brbrofs01.file.core.windows.net/sftp-uploads/PerthDelta2"
	$DestKey = "mS/qdPp19eu3J2e0UBCYvTHgPlNWrAJ3wphS+qqrlvUWB3nCHUpRtd4XYjKCy7HVQbQRZvAq/6aETAnv+qiaSg=="
	

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\CopyAzureFilestoAzureFiles.log"
	
## Start capturing output
	Start-Transcript -path $LogFile
	echo ""

## copy archived zip files to azure files with AzCopy
	echo ""	
	&Az /Source:$AzFilesSource /SourceKey:$SourceKey /Dest:$AzFilesDest /DestKey:$DestKey /S
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		}

## Stop capturing output
	Stop-Transcript