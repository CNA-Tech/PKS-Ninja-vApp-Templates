##################################################
#
# This Script will replace (delete original and copy new) a file from an unathenticated web source to the specified location on the local hard drive
#
##################################################

#Set Powershell to use TLS 1.2 as required to access github
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Create a variable named "source" to hold the unauthenticated web location for the source file
$source = "https://raw.githubusercontent.com/CNA-Tech/PKS-Ninja-vApp-Templates/master/v12/Milestones/6425/Patches/490/Assets/README.txt"

# Create a variable named "destination" to hold the target location in the local filesystem including the target filename
$destination = "C:\Users\Administrator\Desktop\README.txt"

# Remove existing destination file if present
Remove-Item $destination

# Copy file from the source location to the destination location
wget $source -outfile $destination