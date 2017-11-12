## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy
	
## create azure files
	$AzFiles = "https://imanageukworkbackupsa.file.core.windows.net/imanage-sw"
	$SgKey = "JP6QFenlU5BOu8dYaIEPFrnrefWsQ8bP7+XkI2LsETI1rXO1VzM0NazZX6NMGUUVaffRgApUVMZ1vds18LT7sg=="
	
	$AzDest = "https://imanagesgworkappdisksa.file.core.windows.net/imanage-sw"
	$DestKey = "mVhvBrZ+mZ0Fbvm4a9Qppy7DVxJN1F1DeRzBSh/hZZayK8XwOchDUfT2Q2ndE7wqf/IEyioeWumAkUFM9Er8FQ=="

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