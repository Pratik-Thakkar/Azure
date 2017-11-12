## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	##Set-Alias Az $AzCopy
	
	 $BkpDirName = get-date -f MM-dd-yyyy_HH_mm_ss
	 ## PUT https://myaccount.file.core.windows.net/myshare/myparentdirectorypath/mydirectory? restype=directory HTTP/1.1  

	##PUT https://azuretestukfs01.file.core.windows.net/$BkpDirName? restype=directory HTTP/1.1  
	## New-AzureStorageDirectory -Share "\\azuretesukfs01.file.core.windows.net\dest" -Path $BkpDirName
## create azure files
	New-Item -ItemType Directory -Path \\azuktestfs01.file.core.windows.net\dest\$BkpDirName
	$AzFilesSrc = "\\azuktestfs01.file.core.windows.net\src"
	$SgKeySrc = "JP6QFenlU5BOu8dYaIEPFrnrefWsQ8bP7+XkI2LsETI1rXO1VzM0NazZX6NMGUUVaffRgApUVMZ1vds18LT7sg=="
	$AzFilesDest = "\\azuktestfs01.file.core.windows.net\dest"+"/"+$BkpDirName
	$SgKeyDest = "JP6QFenlU5BOu8dYaIEPFrnrefWsQ8bP7+XkI2LsETI1rXO1VzM0NazZX6NMGUUVaffRgApUVMZ1vds18LT7sg=="

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
	#$AZCopy /Source:\\azuktestfs01.file.core.windows.net\src /Dest:\\azuktestfs01.file.core.windows.net\dest\test /S /Z /A /XO
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		}

## Stop capturing output
	Stop-Transcript