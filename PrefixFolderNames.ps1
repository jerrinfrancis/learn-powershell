param([string] $prefix = "2018-2019 ");
$folders = Get-ChildItem -Directory ;
for ( $i = 0; $i -lt $folders.Length; $i++ ){                
               $Name = $folders[$i].Name; 
               $NewName = $prefix + $Name; 
               Rename-Item $Name $NewName; }
