param(
    [string]$Directory,
    [string]$StartsWith
)

if ([string]::IsNullOrWhiteSpace($Directory) -or
    [string]::IsNullOrWhiteSpace($StartsWith)) {

    Write-Output ""
    Write-Output "RemoveFile.ps1 - Missing required parameters"
    Write-Output ""
    Write-Output "Parameters:"
    Write-Output "  -Directory  - Directory from which the file will be removed."
    Write-Output "  -StartsWith - File name or beginning of the file name."
    Write-Output "                Use this as a workaround when the file name contains an & sign."
    Write-Output ""
    Write-Output "Usage example:"
    Write-Output "run RemoveFile.ps1 -parameters `"-Directory 'C:\FolderPath' -StartsWith 'FileName or its beginning'`""
    Write-Output "run RemoveFile.ps1 -parameters `"-Directory 'C:\Users\' -StartsWith 'New'`""
    Write-Output ""
    exit 1
}

param(
    [Parameter(Mandatory = $true)]
    [string]$Directory,

    [Parameter(Mandatory = $true)]
    [string]$StartsWith
)

$Matches = @(
    Get-ChildItem -LiteralPath $Directory -File -Force |
    Where-Object { $_.Name.StartsWith($StartsWith) }
)

if ($Matches.Count -eq 0) {
    Write-Output "NOT FOUND: No matching file."
    exit 1
}

if ($Matches.Count -gt 1) {
    Write-Output "ABORTED: Multiple matching files found:"

    $Matches | ForEach-Object {
        Write-Output $_.FullName
    }

    exit 2
}

$File = $Matches[0]

Write-Output "FOUND: $($File.FullName)"

try {
    Remove-Item -LiteralPath $File.FullName -Force -ErrorAction Stop

    if (Test-Path -LiteralPath $File.FullName) {
        Write-Output "FAILED: File still exists."
        exit 3
    }

    Write-Output "SUCCESS: File removed."
    exit 0
}
catch {
    Write-Output "ERROR: $($_.Exception.Message)"
    exit 4
}
