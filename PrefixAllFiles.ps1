param([Parameter(Mandatory=$true)]
      [string] $Prefix,
    [string] $FilePath = 'FILE_PATH')
if (($FilePath -eq "FILE_PATH") -or (!(test-path $FilePath)) ) {
    Write-Error "Provide a valid path!!!"
    Return
}
if ($Prefix -eq "DUMMY") {
    Write-Error "Prefix is mandatory"
    Return
    
}
$FilesToRename = Get-ChildItem -Path $FilePath -File -Recurse 
foreach ($File in $FilesToRename) {
    [string] $CurrentName = $File.Name
    $PrefixedName = $Prefix + ' ' + $CurrentName
    Rename-Item -Path $File.FullName -NewName $PrefixedName -Force
    
}