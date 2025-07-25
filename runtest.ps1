# Enable strict mode and clear the screen
Set-StrictMode -Version Latest
Clear-Host

Write-Host "-----------------------------------------" -ForegroundColor Cyan
Write-Host "Cleaning up old directories..." -ForegroundColor Yellow
Write-Host "-----------------------------------------" -ForegroundColor Cyan

# Remove directories if they exist
$dirs = @("allure-results", "logs", "results")
foreach ($dir in $dirs) {
    if (Test-Path $dir) {
        try {
            Remove-Item -Recurse -Force $dir
            Write-Host "Removed $dir"
        } catch {
            Write-Error "Failed to remove $dir"
            exit 1
        }
    }
}

Write-Host "`n-----------------------------------------" -ForegroundColor Cyan
Write-Host "Running Robot Framework tests in parallel..." -ForegroundColor Yellow
Write-Host "-----------------------------------------" -ForegroundColor Cyan

# Run tests
$pabotCmd = "pabot --processes 3 --loglevel TRACE -d results --listener allure_robotframework:allure-results testcases"
Invoke-Expression $pabotCmd
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Robot tests failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "`n-----------------------------------------" -ForegroundColor Cyan
Write-Host "Generating Allure Report..." -ForegroundColor Yellow
Write-Host "-----------------------------------------" -ForegroundColor Cyan

# Generate Allure report
$allureGenerateCmd = "allure generate allure-results -o allure-report --clean"
Invoke-Expression $allureGenerateCmd
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Allure report generation failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "`n-----------------------------------------" -ForegroundColor Cyan
Write-Host "Opening Allure And Robot Framework Default Report in browser..." -ForegroundColor Yellow
Write-Host "-----------------------------------------" -ForegroundColor Cyan

# Open Robot Framework Default Report
Start-Process "results\report.html"
# Open Allure Report
Start-Process "allure" -ArgumentList "open", "allure-report"
