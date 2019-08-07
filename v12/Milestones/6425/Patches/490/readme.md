# "Multiple v12 templates have incorrect readme file details on control center desktop" Fixes #490

To resolve issue #490, the readme file on the control center desktop of the impacted templates must be updated to match the [README.txt](./Assets/README.txt) file in the Assets subdirectory for issue #490.

While this can be done manually, the file [490.ps1](./490.ps1) provides a simple powershell script which deletes the existing powershell script and replaces it with the updated README.txt file. 

## Step 1: Run 490.ps1 script to update the README.txt file on the control center desktop

1.1 Ensure a clean and properly running version of the template you are updated is running and log into the control center desktop

1.2 Open a powershell prompt and enter the following commands:

```bash
wget "https://raw.githubusercontent.com/CNA-Tech/PKS-Ninja-vApp-Templates/master/v12/Milestones/6425/Patches/490/490.ps1" -outfile "C:\Temp\490.ps1"
. C:\Temp\490.ps1
del C:\Temp\490.ps1
```

1.3 To verify, open the README.txt file on the control center desktop and ensure it matches the [README.txt](./Assets/README.txt) in the Assets subdirectory for issue #490

This completes the resolution steps for issue #490. Please be sure to reference the build instructions for the template you are updating for additional steps to complete the build process.