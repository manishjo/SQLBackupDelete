## Capturing the status of the AzCopy job which upload the backup to blob storage
$Job_state = Get-ScheduledTask | ? TaskName -eq CopyDBBackupToBLOB 

## If the status is Ready its mean last run was completed then delete the one day old backup
if ($Job_state.State -eq 'Ready'){
Get-ChildItem –Path "M:\Backup" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item
}
else { 
echo "Copy to Blob is not completed"
}