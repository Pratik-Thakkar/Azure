## create alias
	
	$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"
	Set-Alias Az $AzCopy

	$7z = "C:\Program Files\7-Zip\7z.exe"
    Set-Alias 7z $7z
	
	#$Source = "E:\"
	
## create azure files
	$AzFiles = "https://imanageukworkbackupsa.file.core.windows.net/backup-share"
	$SgKey = "hYZXBX7t9DqngEONr/cOVRZe7fRsEkqrksogMR+3qlL/RrDychraMS1zQuV/BNaIkNA1V0p/B3Yjr5DJjNvnBg=="

	
	$Source = "E:\"

## create an array of files based on client archive directory, adjusted to the previously date 
    $Target = @(Get-ChildItem $Source |? {$_.psiscontainer -and $_.Name -match "test"})

## perform 7zip operation on all files that meet date criteria, set 7zip file as archive
	foreach ($file in $Target){
		&7z a -t7z ($file.FullName + ".7z") $file.FullName
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
	
	echo ""
	&Az /Source:$Source /Dest:$AzFiles /DestKey:$SgKey /A /XO
	if ($LASTEXITCODE -eq 0) {
		echo "File Uploaded successfully"
		Remove-Item $zipFile
		}