function Write-Error($msg) {
    Write-Host "[" -NoNewline
    Write-Host "!" -NoNewline -ForegroundColor Red
    Write-Host "] " -NoNewline
    Write-Host $msg
}

function Write-Success($msg) {
    Write-Host "[" -NoNewline
    Write-Host "+" -NoNewline -ForegroundColor Green
    Write-Host "] " -NoNewline
    Write-Host $msg
}

$us = New-Object System.Globalization.CultureInfo("en-US")

# Define a list of words
$wordList = @(
    "will",
    "care",
    "freeze",
    "realize",
    "roof",
    "me",
    "variable",
    "glory",
    "courage",
    "boat",
    "unrest",
    "slip",
    "switch",
    "scrape",
    "censorship",
    "flower"
)

# Get a random word from the list
$randomWord = $wordList | Get-Random

# Output the random word
# Write-Output $randomWord
$origin_path = Get-Location
$path = $origin_path
# Write-Output "Current path: $path"

# if path is */bin
if ($path -like "*\bin") {
    $path = Split-Path $path -Parent
}

if (-not (Test-Path "$path\01_daily")) {
    New-Item -ItemType Directory -Path "$path\01_daily" | Out-Null
}

$year = Get-Date -Format 'yyyy'
$en_month = (Get-Date).ToString("MMMM", $us).ToLower()
$month = "$(Get-Date -Format 'MM')_$en_month"

if (-not (Test-Path "$path\01_daily\$year")) {
    New-Item -ItemType Directory -Path "$path\01_daily\$year" | Out-Null
}

if (-not (Test-Path "$path\01_daily\$year\$month")) {
    New-Item -ItemType Directory -Path "$path\01_daily\$year\$month" | Out-Null
}

$path = "$path\01_daily\$year\$month"
$date_st = Get-Date -Format 'dd'

$matchingFiles = Get-ChildItem -Path $path -Filter "$date_st*.adoc"
if ($matchingFiles.Count -eq 0) {
    $fileName = "$($date_st)_$randomWord.adoc"
    New-Item -ItemType File -Path "$path\$fileName" | Out-Null
    Write-Success "Created file: $fileName"
} else {
    $fileName = $matchingFiles[0].Name
    Write-Error "File already exists: $fileName"
}
