## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy

	$7z = "C:\Program Files\7-Zip\7z.exe"
	Set-Alias 7z $7z
	
## create azure files
	$AzFiles = "https://xxxxx.file.core.windows.net/backup-share"
	$SgKey = ""

	$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
	$LogFile = $scriptPath+"\CopytoAzureFiles.log"
	
## Start capturing output
	Start-Transcript -path $LogFile
	echo ""
	
## Find directory location	
	$RootPath = "E:\Backup"
	$ClientPath = @(Get-ChildItem -Path $RootPath\*)
	
	foreach ($CB in $ClientPath)
	{
##  client archive directory
    $Source = "$CB\Archive"

## create an array of files based on client archive directory, adjusted to the previously date 
    $Target = @(get-childitem $Source -Exclude "D97CUKDMS01" |? {$_.psiscontainer -and $_.lastwritetime -le (get-date).adddays(-2)})

## perform 7zip operation on all files that meet date criteria, set 7zip file as archive
	foreach ($file in $Target){
		&7z a -t7z ($file.FullName + ".7z") -m0=lzma2 -mx1 $file.FullName
		if ($LASTEXITCODE -eq 0) {
			$zipFile = $file.FullName + ".7z"
			echo ""
			echo "Zip file created successfully, configuring zip file as Archive files"
			echo ""
			
## set the created zip file as archive 
			Set-ItemProperty -Path $zipFile -Name attributes -Value "Archive"

##Remove the file After creating the zip
			if (Test-Path $zipFile)
			{
				echo "Removing $file"
				Remove-Item $file.FullName -Force -Recurse -Confirm:$false
			}
		}
	}

## copy archived zip files to azure files with AzCopy
	echo ""	
	$ClientAzFolder = $AzFiles + "/" + $CB.Name
	&Az /Source:$Source /Dest:$ClientAzFolder /DestKey:$SgKey /A /XO
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		$GetZip = Get-ChildItem -path $Source -Filter *.7z

			foreach ($zip in $GetZip)
			{
			echo ""
			echo "Removing the Archive $zip"
			echo "" 
			Remove-Item $zip.FullName -Force -Recurse -Confirm:$false
			}
		}
}

## Stop capturing output
	Stop-Transcript
