param([string] $filepath = ".")
function checkEmptyFolder{
    param (
        $path
    )
    $children = Get-ChildItem -Path $path -Force -Recurse -Exclude "desktop.ini"
    foreach ($child in $children) {
        if ($child.GetType().Name -ne "DirectoryInfo" ) {
            return $false
        }
        
    }
    return $true
}
function deleteFolderIfEmpty {
    param (
        $path
    )
    if(![System.IO.Directory]::Exists($path)){
        Write-Host "Path Does does not Exist"
        return
    }
    if (checkEmptyFolder($path)) {
        Write-Host "True"
        Remove-Item -Recurse -Path $path -Force
        Write-Host "Deleted"
    }else {
        Write-Host "False"
    }    
}
if(![System.IO.Directory]::Exists($filepath)){
    Write-Host "Path Does does not Exist"
    return
}
$folders = Get-ChildItem -Path $filepath -Recurse -Directory -Force
foreach ($folder in $folders) {
    $folder.FullName
    deleteFolderIfEmpty($folder.FullName)
}
