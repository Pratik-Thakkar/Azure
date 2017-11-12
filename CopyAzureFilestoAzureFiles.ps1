## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy
	
## create azure files
    $AzFilesSource = "https://xxxx.file.core.windows.net/se/6b/"
	$SourceKey = ""
	
	$AzFilesDest = "https://xxxx.file.core.windows.net/sfs/"
	$DestKey = ""
	

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
