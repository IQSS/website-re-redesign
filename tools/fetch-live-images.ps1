<#
.SYNOPSIS
    Downloads the images this site references from iq.harvard.edu into
    static/images/, so the site serves its own media instead of Harvard's.

.DESCRIPTION
    The scrape that built this site captured the markup but not the media.
    1,223 <img> tags point at /sites/g/files/... with no host, so they 404 here,
    and another 1,048 point at https://www.iq.harvard.edu/sites/... which load
    only while Harvard serves them. Between them they name about 1,446 distinct
    files. Only 41 tags point at images we hold.

    This script finds every one of those references, downloads each distinct
    file once, and writes a manifest mapping the original URL to the local
    filename. It does not touch any content file: rewriting the references is a
    second, separate step, run once you can see what actually arrived.

    Re-running is safe. Files already in static/images/ are skipped, so an
    interrupted run resumes where it stopped.

.PARAMETER DryRun
    List what would be downloaded and stop. Try this first.

.PARAMETER DelayMs
    Pause between requests, default 400ms. Please do not set this to 0; it is
    a courtesy to a server you share with everyone else at Harvard.

.PARAMETER UserAgent
    How the script identifies itself. Read the note below before changing it.

.PARAMETER Limit
    Stop after this many downloads. Useful for a first look.

.NOTES
    IF EVERY REQUEST COMES BACK 403

    Expect this. The site's firewall refuses anything that does not look like
    a browser: curl is refused, and an honestly-named client is refused too.
    robots.txt permits these paths, so this is not a policy against fetching
    them -- it is a filter on the client.

    If that happens, the answer is not a different user-agent string. These are
    IQSS's own images in IQSS's own Drupal media library, and a media-library
    export gets you every original in one go. That is a better result anyway:
    the URLs below are Drupal's resized derivatives, such as
    styles/hwp_4_5__690x865/, not the masters. Ask HUIT or whoever administers
    the Drupal site.

    Run this from the repository root:
        .\tools\fetch-live-images.ps1 -DryRun
#>

[CmdletBinding()]
param(
    [switch]$DryRun,
    [int]$DelayMs = 400,
    [string]$UserAgent = 'IQSS-site-migration/1.0 (internal content migration)',
    [int]$Limit = 0
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path 'content')) {
    Write-Error 'Run this from the repository root (the folder containing content\ and static\).'
}

$imageDir = Join-Path 'static' 'images'
if (-not (Test-Path $imageDir)) { New-Item -ItemType Directory -Path $imageDir | Out-Null }

$host_ = 'https://www.iq.harvard.edu'

Write-Host 'Scanning content for image references...'

# Both reference styles end up as the same absolute URL. The query string is
# dropped: it is Drupal's cache-busting token, not part of the file.
$pattern = '<img[^>]*src="(?<src>(?:https?://www\.iq\.harvard\.edu)?/sites/g/files/[^"?]+)'
$refCount = @{}   # url -> how many <img> tags use it
$refPages = @{}   # url -> how many files use it

Get-ChildItem -Path 'content', 'layouts' -Recurse -Include '*.md', '*.html' -File | ForEach-Object {
    $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8
    $seenHere = @{}
    foreach ($m in [regex]::Matches($text, $pattern)) {
        $src = $m.Groups['src'].Value
        if ($src -notlike 'http*') { $src = $host_ + $src }
        if ($refCount.ContainsKey($src)) { $refCount[$src]++ } else { $refCount[$src] = 1 }
        if (-not $seenHere.ContainsKey($src)) {
            $seenHere[$src] = $true
            if ($refPages.ContainsKey($src)) { $refPages[$src]++ } else { $refPages[$src] = 1 }
        }
    }
}

$urls = [System.Collections.Generic.HashSet[string]]::new()
foreach ($k in $refCount.Keys) { [void]$urls.Add($k) }

Write-Host ("Found {0} distinct image files referenced." -f $urls.Count)

# A Drupal path carries its own directory noise. The leaf filename is what we
# want, lowercased, with anything awkward flattened. Collisions are made unique
# rather than silently overwriting a different picture.
$taken = @{}
Get-ChildItem -Path $imageDir -File | ForEach-Object { $taken[$_.Name.ToLower()] = $true }

$plan = @()
foreach ($u in $urls) {
    # Decode first: a URL-encoded space is %20, and sanitising before decoding
    # turns "icon%201.png" into "icon-201.png", which reads as a number.
    $leaf = [System.Uri]::UnescapeDataString([System.IO.Path]::GetFileName($u)).ToLower()
    $leaf = $leaf -replace '[^a-z0-9._-]', '-'
    $leaf = $leaf -replace '-{2,}', '-'
    if ([string]::IsNullOrWhiteSpace($leaf)) { continue }

    # A name already in static/images/ usually means Harvard holds another size
    # of a picture we already have -- the hero banners especially. Those are
    # flagged rather than quietly saved beside the original, so you can decide
    # which size the site should use instead of ending up with both.
    $clash = $taken.ContainsKey($leaf)
    $name = $leaf
    if ($clash) {
        $base = [System.IO.Path]::GetFileNameWithoutExtension($leaf)
        $ext  = [System.IO.Path]::GetExtension($leaf)
        $n = 2
        while ($taken.ContainsKey($name)) { $name = "$base-$n$ext"; $n++ }
    }
    $taken[$name] = $true

    # Drupal serves a resized derivative when the path contains styles/<name>/.
    # Anyone pulling these from the media library wants the master instead, so
    # the style is named and the original path given alongside it.
    $style = ''
    $original = $u
    if ($u -match '/files/styles/(?<s>[^/]+)/public/(?<rest>.+)$') {
        $style = $Matches['s']
        $original = "$host_/sites/g/files/omnuum8171/files/" + $Matches['rest']
    }

    $plan += [pscustomobject]@{
        File                = $name
        Url                 = $u
        OriginalUrl         = $original
        DrupalStyle         = $style
        ImgTags             = $refCount[$u]
        PagesUsingIt        = $refPages[$u]
        ClashesWithExisting = $clash
    }
}

$clashes = @($plan | Where-Object { $_.ClashesWithExisting })
if ($clashes.Count -gt 0) {
    Write-Warning ("{0} of these share a filename with an image already in static\images\ -- probably a different size of the same picture. They are listed in the manifest with ClashesWithExisting = True." -f $clashes.Count)
}

$existing = @(Get-ChildItem -Path $imageDir -File | Select-Object -ExpandProperty Name)
$todo = @($plan | Where-Object { $existing -notcontains $_.File })

Write-Host ("{0} already present, {1} to fetch." -f ($plan.Count - $todo.Count), $todo.Count)

if ($DryRun) {
    $todo | Select-Object -First 10 | ForEach-Object { Write-Host ("  {0}  <-  {1}" -f $_.File, $_.Url) }
    if ($todo.Count -gt 10) { Write-Host ("  ... and {0} more" -f ($todo.Count - 10)) }

    # The full list is the useful artefact even when nothing is downloaded:
    # it is what you hand to whoever administers the Drupal site, because it
    # says which file is wanted and what this site expects it to be called.
    $wanted = 'tools\images-wanted.csv'
    $plan | Sort-Object -Property @{Expression='PagesUsingIt';Descending=$true}, File |
        Export-Csv -LiteralPath $wanted -NoTypeInformation -Encoding UTF8
    Write-Host ''
    Write-Host ("Dry run: nothing downloaded. Full list of {0} files written to {1}." -f $plan.Count, $wanted)
    Write-Host 'That file is the request list: each row gives the Drupal URL, the'
    Write-Host 'unresized original, and the filename this site expects.'
    return
}

$ok = 0; $failed = 0
$log = @()
$i = 0

foreach ($item in $todo) {
    if ($Limit -gt 0 -and $i -ge $Limit) { Write-Host "Reached -Limit $Limit; stopping."; break }
    $i++
    $dest = Join-Path $imageDir $item.File
    try {
        Invoke-WebRequest -Uri $item.Url -OutFile $dest -UserAgent $UserAgent -TimeoutSec 30 -ErrorAction Stop
        $size = (Get-Item -LiteralPath $dest).Length
        if ($size -lt 1024) {
            # Too small to be a real photograph: almost certainly an error page
            # saved under an image filename.
            Remove-Item -LiteralPath $dest -Force
            $failed++
            $log += [pscustomobject]@{ Url = $item.Url; File = $item.File; ClashesWithExisting = $item.ClashesWithExisting; Status = "suspect ($size bytes, discarded)" }
        } else {
            $ok++
            $log += [pscustomobject]@{ Url = $item.Url; File = $item.File; ClashesWithExisting = $item.ClashesWithExisting; Status = "ok ($size bytes)" }
        }
    } catch {
        $failed++
        $code = ''
        if ($_.Exception.Response) { $code = [int]$_.Exception.Response.StatusCode }
        $log += [pscustomobject]@{ Url = $item.Url; File = $item.File; ClashesWithExisting = $item.ClashesWithExisting; Status = "failed $code" }
        if (Test-Path -LiteralPath $dest) { Remove-Item -LiteralPath $dest -Force }
    }

    if ($i % 25 -eq 0) { Write-Host ("  {0}/{1}  ok={2} failed={3}" -f $i, $todo.Count, $ok, $failed) }
    Start-Sleep -Milliseconds $DelayMs

    # If nothing at all is getting through, stop rather than hammer the server
    # through another fourteen hundred refusals. See the 403 note at the top.
    if ($i -eq 10 -and $ok -eq 0) {
        Write-Warning 'First 10 requests all failed. Stopping. See the 403 note in this script.'
        break
    }
}

$manifest = 'tools\fetched-images.csv'
$log | Export-Csv -LiteralPath $manifest -NoTypeInformation -Encoding UTF8
Write-Host ''
Write-Host ("Done. {0} downloaded, {1} failed." -f $ok, $failed)
Write-Host ("Manifest written to {0} -- it maps each original URL to its local filename." -f $manifest)
Write-Host 'Nothing in content\ has been changed. Rewriting the references is the next step.'
