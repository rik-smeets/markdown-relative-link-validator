param(
    [Parameter(Mandatory = $True)]
    [string]$folderPath
)

while (!(Test-Path -Path $folderPath)) {
    $folderPath = Read-Host "Enter a valid, existing and accessible folder path:"
}

$invalidLinks = @()
Get-ChildItem -Path $folderPath -Filter *.md -Recurse | ForEach-Object {
    $fileDirectory = $_.Directory
    $fileFullName = $_.FullName
    $fileText = Get-Content $fileFullName

    $regexResult = $fileText | Select-String -Pattern '((!?\[[^\]]*?\])\((?:(?!http|www\.|\#|\.com|\.net|\.info|\.org).)*?\))'
    
    $regexResult.Matches | Where-Object { $_.Groups } | ForEach-Object {
        $fullRelativeLink = $_.Groups[0].Value;
        $lastPartOfPath = $fullRelativeLink.Split('(')[-1].Trim('(', ')').Replace("%20", " ")
        
        $lastPartOfPath | ForEach-Object {
            $fullPath = Join-Path -Path $fileDirectory -ChildPath $_
            if (!(Test-Path -Path $fullPath)) {
                $invalidLinks += @{'File' = $fileFullName; 'Invalid relative link' = $fullRelativeLink}
            }
        }
    }
}

if ($invalidLinks.Length -gt 0) {
    $invalidLinks.ForEach( {[PSCustomObject]$_}) | Format-Table -Property "Invalid relative link" -AutoSize -GroupBy File
}
else {
    Write-Output "No invalid relative links found."
}