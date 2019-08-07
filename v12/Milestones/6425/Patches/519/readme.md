#"multiple v12 templates need their labstartup script timer extended" Fixes #519

There have been several recent reports of slow template booting on various onecloud orgs including cases where the LabStartup script times out and puts a failed watermark on the desktop for a period of time even after the template finishes booting and starts working. 

The steps below extend the lab startup timer to 55 minutes to help address this issue. Site Admins should start to issue guidance for users to wait up to an hour for a template to fully boot before initiating additional troubleshooting steps when error conditions are seen. 

Issue Ticket URL: https://github.com/CNA-Tech/PKS-Ninja/issues/519

## Step 1: Update maxMinutesBeforeFail value to 55 Minutes in LabStartupFunctions.psm1

1.1 Connect to a clean & properly running instance of the template you want to patch, only the vpodrouter and control center need to be loaded, it shoudl not be significant whether other vApp hosts are booted or not to apply this patch. 

1.2 From the control center desktop, open the file `C:\hol\LabStartupFunctions.psm1` in vs code or your preferred text editor

1.3 On Line 25 you should see an entry for `$maxMinutesBeforeFail`  update the value to `55`, save and close the file. 

This completes the resolution steps for issue #519. Please be sure to reference the build instructions for the template you are updating for additional steps to complete the build process.


