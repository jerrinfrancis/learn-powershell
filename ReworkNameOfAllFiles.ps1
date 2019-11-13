param([string] $SearchString = 'DUMMY' ,
    [string] $ReplacementString = '',
    [string] $FilePath = 'FILE_PATH')
if (($FilePath -eq "FILE_PATH") -or (!(test-path $FilePath)) ) {
    Write-Error "Provide a valid path!!!"
    Return
}
if ($SearchString -eq "DUMMY") {
    Write-Error "SearchString Parameter is Mandatory"
    Return
    
}
$ReplacePattern = '*' + $SearchString + '*'
$FilesToRename = Get-ChildItem -Path $path -File -Recurse -Filter $ReplacePattern
foreach ($File in $FilesToRename) {
    [string] $CurrentName = $File.Name
    $ReplaceName = $CurrentName.Replace($SearchString, $Replacement)
    Rename-Item -Path $File.FullName -NewName $ReplaceName -Force
    
}