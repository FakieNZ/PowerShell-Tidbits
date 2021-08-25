$String = '%3Chtml%3E'

$Array = $String -split '(?=\%)'

[String]$Output = ''

for ($i = 1; $i -lt $Array.Count; $i++) {

    [String]$Char = [char]([convert]::toint16($Array[$i].Substring(1,2),16))
    
    $Output += $Array[$i].Replace($Array[$i].Substring(0,3), $Char)
}
$Output
