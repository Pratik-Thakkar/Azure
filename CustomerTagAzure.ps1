Add-AzureRmAccount
$RGName = ''
$Resources = Find-AzureRmResource -ResourceGroupNameEquals $RGName
$excluded = @("6b2b*|8d83*|eb54*|sales*")

foreach ($item in $Resources) {

if ($item.Name -notmatch $excluded) {
Set-AzureRmResource -Tag @{Customer="" } -ResourceName $item.Name -ResourceType $item.ResourceType -ResourceGroupName $item.ResourceGroupName -Force
}
}
