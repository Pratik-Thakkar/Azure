## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy
	
## create azure files
	$AzFiles = "https://xxxxx.file.core.windows.net/imanage-sw"
	$SgKey = ""
	
	$AzDest = "https://xxxxx.file.core.windows.net/imanage-sw"
	$DestKey = ""

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\SoftwareCopytoAzureFiles.log"
	
## Start capturing output
	Start-Transcript -path $LogFile
	echo ""
	
##  client archive directory
    #$Source = "C:\SW"

## copy archived zip files to azure files with AzCopy
	echo ""	
	#&Az /Source:$Source /Dest:$AzFiles /DestKey:$SgKey /A /XO /S
	&Az /Source:$AzFiles /Dest:$AzDest /SourceKey:$SgKey /DestKey:$DestKey /S /SyncCopy
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		}

## Stop capturing output
	Stop-Transcript
