##################################################
#
# This Script will replace (delete original and copy new) a file from an unathenticated web source to the specified location on the local hard drive
#
##################################################

# Create a variable named "source" to hold the unauthenticated web location for the source file
$source = "https://github.com/CNA-Tech/PKS-Ninja-vApp-Templates/blob/master/v12/Baseline/0.6/490/ccdesktop/readme.txt"

# Create a variable named "destination" to hold the target location in the local filesystem including the target filename
$destination = "C:\Users\Administrator\Desktop\README.txt"

# Remove existing destination file if present
Remove-Item -path $destination

# Copy file from the source location to the destination location
wget $source -outfile $destination