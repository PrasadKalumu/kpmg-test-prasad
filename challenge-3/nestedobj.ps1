# Nested object function to retrive values
$prm1 = @{"India" = @{"AP" = @{"KNP" = "Home"}}}

$prm2 = "India/AP/KNP"
$prm3 = "reset"

Write-Host $p3

function MyFunction ($pr1, $pr2)
{
    $tmp = $pr2 -split "/"
    $tmp2 = $pr1

    ForEach( $t in $tmp)
    {
         $tmp2 = $tmp2.$t
    }
    return $tmp2
}
$prm3 = MyFunction $prm1 $prm2 
Write-Output $prm3