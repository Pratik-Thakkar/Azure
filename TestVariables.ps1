## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy

    $7z = "C:\Program Files\7-Zip\7z.exe"
    Set-Alias 7z $7z
	
## create azure files
	$AzFiles = "https://imanageukworkbackupsa.file.core.windows.net/backup-share"
	$SgKey = "hYZXBX7t9DqngEONr/cOVRZe7fRsEkqrksogMR+3qlL/RrDychraMS1zQuV/BNaIkNA1V0p/B3Yjr5DJjNvnBg=="

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\TestVariables.log"
	
	echo "LogFile path is --> $LogFIle"
	
	
## Start capturing output
	Start-Transcript -path $LogFile
	echo ""
	
## Find directory location	
	$RootPath = "E:\Backup"
	$ClientPath = @(Get-ChildItem -Path $RootPath\*)
	
	foreach ($CB in $ClientPath)
	{
	echo "Client Name --> $CB"

	##  client archive directory
    $Source = "$CB\Archive"
	echo "Source Directory, also used by AzCopy -->  $Source"
	

## create an array of files based on client archive directory, adjusted to the previously date 
    $Target = @(get-childitem $Source |? {$_.psiscontainer -and $_.lastwritetime -le (get-date).adddays(-2)})

## perform 7zip operation on all files that meet date criteria, set 7zip file as archive
	foreach ($file in $Target){
	echo "Target Folder -->  $file"
		<# &7z a -t7z ($file.FullName + ".7z") $file.FullName
		if ($LASTEXITCODE -eq 0)  { #>
			$zipFile = $file.FullName + ".7z"
			#echo ""
			echo "Zip file created successfully, configuring zip file as Archive files --> " $zipFile
			echo ""
			
## set the created zip file as archive 
		<#	Set-ItemProperty -Path $zipFile -Name attributes -Value "Archive" #>
		#}
	}

## copy archived zip files to azure files with AzCopy
	
	$ClientAzFolder = $AzFiles + "/" + $CB.Name
	echo "Client Folder in Azure -->  $ClientAzFolder"	
	
	<# &Az /Source:$Source /Dest:$ClientAzFolder /DestKey:$SgKey /A /XO #>
	echo ""
}

## Stop capturing output
	Stop-Transcript