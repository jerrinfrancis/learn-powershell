param([string] $filepath = "C:\Users\jerri\Documents\Test" ,
    [string] $skippathpattern = ".git")
$folders = Get-ChildItem -Path $filepath -Recurse -Directory | ? { $_.Parent.FullName -inotmatch $skippathpattern -and $_.FullName -inotmatch $skippathpattern }
foreach ($folder in $folders) {
    $items = get-Childitem -Path $folder.FullName -Recurse | Where-Object { $_.FullName -inotmatch $skippathpattern } 
    foreach ($item in $items) {
        if (( Get-Item $item.FullName ) -ne [System.IO.DirectoryInfo]) {
            $pathtomove = $filepath + "\" + $item.CreationTime.Year + "-" + $item.CreationTime.Month
            $ItemTOMove += @(, @($item.CreationTime.Month, $pathtomove, $item.FullName))
        }        
    }
}
$targetfolderitems = get-Childitem -Path $filepath -File | Where-Object { $_.FullName -inotmatch $skippathpattern } 
foreach ($item in $targetfolderitems) {
    if (( Get-Item $item.FullName ) -ne [System.IO.DirectoryInfo]) {
        $pathtomove = $filepath + "\" + $item.CreationTime.Year + "-" + $item.CreationTime.Month
        $ItemTOMove += @(, @($item.CreationTime.Month, $pathtomove, $item.FullName))
    }        
}
$ItemTOMove.Count
for ($i = 0; $i -lt $ItemToMove.Count; $i++) {
    If (!(test-path $ItemTOMove[$i][1])) {
        New-Item -ItemType Directory -Force -Path $ItemTOMove[$i][1]
    }
    Move-Item -Path $ItemTOMove[$i][2] -Destination $ItemTOMove[$i][1] -Force   
}


