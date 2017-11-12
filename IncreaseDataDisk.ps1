Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionName 'iManage Work UK'
$rgName = 'iManage-Work-Prod-UK'
$vmName = 'd97cUKidx01'
$vm = Get-AzureRmVM -ResourceGroupName $rgName -Name $vmName
Stop-AzureRmVM -ResourceGroupName $rgName -Name $vmName
$vm.StorageProfile.DataDisks[1].DiskSizeGB = 300
#$vm.StorageProfile.OSDisk.DiskSizeGB = 1023
Update-AzureRmVM -ResourceGroupName $rgName -VM $vm
Start-AzureRmVM -ResourceGroupName $rgName -Name $vmName