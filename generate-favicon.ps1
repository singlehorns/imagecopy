Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'
$source = [System.Drawing.Bitmap]::new((Join-Path $PSScriptRoot 'public/images/branding/since1983.jpg'))
$left = $source.Width; $top = $source.Height; $right = 0; $bottom = 0
for ($y = 0; $y -lt $source.Height; $y++) {
  for ($x = 0; $x -lt $source.Width; $x++) {
    $pixel = $source.GetPixel($x, $y)
    if ([Math]::Min($pixel.R, [Math]::Min($pixel.G, $pixel.B)) -lt 210) {
      $left = [Math]::Min($left, $x); $right = [Math]::Max($right, $x)
      $top = [Math]::Min($top, $y); $bottom = [Math]::Max($bottom, $y)
    }
  }
}
$crop = [System.Drawing.RectangleF]::new($left,$top,($right-$left+1),($bottom-$top+1))
$frames = @()
foreach ($size in @(16,32,48,64,128,256)) {
  $bitmap = [System.Drawing.Bitmap]::new($size,$size)
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.Clear([System.Drawing.Color]::White)
  $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $scale = ($size-2) / [Math]::Max($crop.Width,$crop.Height)
  $width = $crop.Width*$scale; $height = $crop.Height*$scale
  $destination = [System.Drawing.RectangleF]::new(($size-$width)/2,($size-$height)/2,$width,$height)
  $graphics.DrawImage($source,$destination,$crop,[System.Drawing.GraphicsUnit]::Pixel)
  if ($size -eq 64) { $bitmap.Save((Join-Path $PSScriptRoot 'public/favicon.png'),[System.Drawing.Imaging.ImageFormat]::Png) }
  $memory = [System.IO.MemoryStream]::new()
  $bitmap.Save($memory,[System.Drawing.Imaging.ImageFormat]::Png)
  $frames += [pscustomobject]@{Size=$size; Bytes=$memory.ToArray()}
  $memory.Dispose(); $graphics.Dispose(); $bitmap.Dispose()
}
$source.Dispose()
$writer = [System.IO.BinaryWriter]::new([System.IO.File]::Create((Join-Path $PSScriptRoot 'public/favicon.ico')))
try {
  $writer.Write([uint16]0); $writer.Write([uint16]1); $writer.Write([uint16]$frames.Count)
  $offset = 6 + 16*$frames.Count
  foreach ($frame in $frames) {
    $dimension = if ($frame.Size -eq 256) { 0 } else { $frame.Size }
    $writer.Write([byte]$dimension); $writer.Write([byte]$dimension)
    $writer.Write([byte]0); $writer.Write([byte]0)
    $writer.Write([uint16]1); $writer.Write([uint16]32)
    $writer.Write([uint32]$frame.Bytes.Length); $writer.Write([uint32]$offset)
    $offset += $frame.Bytes.Length
  }
  foreach ($frame in $frames) { $writer.Write([byte[]]$frame.Bytes) }
} finally { $writer.Dispose() }
