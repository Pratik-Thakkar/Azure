## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	##Set-Alias Az $AzCopy
	
	 $BkpDirName = get-date -f MM-dd-yyyy_HH_mm_ss
	 ## PUT https://myaccount.file.core.windows.net/myshare/myparentdirectorypath/mydirectory? restype=directory HTTP/1.1  

	##PUT https://storage.file.core.windows.net/$BkpDirName? restype=directory HTTP/1.1  
	## New-AzureStorageDirectory -Share "\\storage.file.core.windows.net\dest" -Path $BkpDirName
## create azure files
	New-Item -ItemType Directory -Path \\storage.file.core.windows.net\dest\$BkpDirName
	$AzFilesSrc = "\\storage.file.core.windows.net\src"
	$SgKeySrc = "Access Key from Portal"
	$AzFilesDest = "\\storage.file.core.windows.net\dest"+"/"+$BkpDirName
	$SgKeyDest = "Access Key from Portal"

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\AzureSharetoShare.log"
	
## Start capturing output
	Start-Transcript -Append -path $LogFile
	echo ""
	
##  client archive directory
    
## copy archived zip files to azure files with AzCopy
	echo ""	
	robocopy $AzFilesSrc $AzFilesDest /S /Z /A /XO /E
	#$AZCopy /Source:$AzFilesSrc /Dest:$AzFilesDest /S /Z /A /XO
	#$AZCopy /Source:\\storage.file.core.windows.net\src /Dest:\\storage.file.core.windows.net\dest\test /S /Z /A /XO
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		}

## Stop capturing output
	Stop-Transcript
