param([string] $filepath = "C:\Users\I301970\Google Drive\Dreams\Cloud Engineering and ML Wizard\Powershell Tutorials")
$folders = Get-ChildItem -Path $filepath -Recurse -Directory 
$ItemTOMove = @()
foreach ($folder in $folders) {
    $items = get-Childitem -Path $folder.FullName -Recurse 
    foreach ($item in $items) {
        if (( Get-Item $item.FullName ) -ne [System.IO.DirectoryInfo]) {
            $path = $filepath + "\" + $item.CreationTime.Month
            $ItemTOMove += @(($item.CreationTime.Month,$path))
        }        
    }
}
$ItemTOMove
for ($i = 0; $i -lt $ItemToMove.Count; $i++) {
$ItemTOMove[$i][1]    
}


