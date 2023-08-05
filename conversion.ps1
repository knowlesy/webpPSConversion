#dweb exe location 
$dwebp = "C:\temp\dwebp.exe"

#Provide the folder where the files are 
$folder = "C:\temp\files"

#Gets all the files 
$files = Get-ChildItem $folder -Recurse -Include *.webp -Exclude converted
#PErforms a count
$count = $files | measure-object
$counted = $count.count + 1
$i = 1
#prints folder where files are stored
write-host "Folder conversion $folder" -ForegroundColor Green
write-host "Conversion may take some time...." -ForegroundColor magenta

foreach ($file in $files)
{
write-host "$i of $counted"
#creats a converted folder
$convertedfolder = "$folder\converted"
New-Item -Path $convertedfolder -ItemType Directory -ErrorAction SilentlyContinue

#gets the full filename including file type
$filename = $file.name
#strips the webp filetye
$nfilename = $filename.replace('.webp','')
#sets the destination of the file
[string]$dest = ($convertedfolder + '\' + $nfilename + '.png')
#gets the source file path
$filepath = ($folder + '\' + $filename)
#performs the conversion
Start-Process $dwebp -ArgumentList "$filepath -o $dest" -wait
#increments the i number
$i++
}
Write-Host "files are in $convertedfolder" -ForegroundColor Green
