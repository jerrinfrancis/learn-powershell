param([string] $ReplaceString = 'Useful',
            [string] $path = '.')
$ReplacePattern = '*' + $ReplaceString + '*'
$FilesToRename = Get-ChildItem -Path $path -File -Recurse -Force -Filter $ReplacePattern
foreach ($File in $FilesToRename) {
    [string] $CurrentName = $File.Name
    $ReplaceName = $CurrentName.Replace($ReplaceString, '')
    $ReplaceName
    # Rename-Item -Path $File.FullName -NewName $ReplaceName
    
}