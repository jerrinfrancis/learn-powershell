param([string] $FilePath = "FILE_PATH" ,
    [string] $SkipPathPattern = ".git")
    # check if a proper valid path is provided for further processing
    if (($FilePath -eq "FILE_PATH") -or (!(test-path $FilePath)) ) {
    Write-Error "Provide a valid path!!!"
    Return
    }
<#  Traverse and find all directories 
    in the given path excluding folders containing SkipPathPattern in their
    Full path 
 #>
 $Folders = Get-ChildItem -Path $FilePath -Recurse -Directory | ? { $_.Parent.FullName -inotmatch $SkipPathPattern -and $_.FullName -inotmatch $SkipPathPattern }
foreach ($Folder in $Folders) {
    $Items = get-Childitem -Path $Folder.FullName -Recurse | Where-Object { $_.FullName -inotmatch $SkipPathPattern } 
    foreach ($Item in $Items) {
        if (( Get-Item $Item.FullName ) -ne [System.IO.DirectoryInfo]) {
            $DestinationPath = $FilePath + "\" + $Item.CreationTime.Year + "-" + $Item.CreationTime.Month
            $FilesToMove += @(, @($DestinationPath, $Item.FullName))
        }        
    }
}
# Get all files from the origin path
$FilesInFilePath = get-Childitem -Path $FilePath -File | Where-Object { $_.FullName -inotmatch $SkipPathPattern } 
foreach ($Item in $FilesInFilePath) {
    if (( Get-Item $Item.FullName ) -ne [System.IO.DirectoryInfo]) {
        $DestinationPath = $FilePath + "\" + $Item.CreationTime.Year + "-" + $Item.CreationTime.Month
        $FilesToMove += @(, @($DestinationPath, $Item.FullName))
    }        
}
[float]$Scale = $FilesToMove.Count / 100
for ($i = 0; $i -lt $FilesToMove.Count; $i++) {
    # check if destination folder exist and move the item
    if ($i -gt 0) {
        [float] $Progress = $i / $Scale
    }
    else {
        [float] $Progress = 0.0
    }   
    Write-Progress -Activity "Copying in Progress" -Status "$Progress% Complete" -PercentComplete $Progress
    If (!(test-path $FilesToMove[$i][0])) {
        New-Item -ItemType Directory -Force -Path $FilesToMove[$i][0]
    }
    Move-Item -Path $FilesToMove[$i][1] -Destination $FilesToMove[$i][0] -Force   
}


