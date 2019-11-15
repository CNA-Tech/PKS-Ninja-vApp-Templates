# PKS-Ninja-T1-Baseline-0.1 Release Notes

**Milestone Page:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/milestone/3)

## How do I get access to a lab environment where I can run this template

Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.6/Courses/GetLabAccess-LA8528)

## T1-Baseline-0.1 Build Sequence Reference

### Step 1: Documentation currently in progress, please check back soon


7.1 Complete the steps documented in the [readme for issue #519](../../../../Patches/519/readme.md)

### Step 8: Complete repetetive build processes

8.1 Ensure a clean and properly running version of the template with all of the patches in the steps above applied. Log into the control center desktop

8.2 Using vscode or your preferred text editor, from the control center desktop open the file `C:\hol\LabStartup.ps1`

8.3 On line 125 you should see the following entry: `WritePodSkuToDesktopInfo 'PKS-Ninja-T1-Baseline-0.1'` Update this line to reflect the new version number for the updated build: `WritePodSkuToDesktopInfo 'PKS-Ninja-v12-Baseline-0.6'` then save and close the file. 

8.4 Using vscode or your preferred text editor, from the control center desktop open the file `C:\DesktopInfo\desktopinfo.ini`

8.5 On line 25 you should see the entry `COMMENT=active:1,interval:60,color:FFFFFF,style:b,text:PKS-Ninja-v12-NsxtReady-0.3`, update this entry to reflect the new version number: `COMMENT=active:1,interval:60,color:FFFFFF,style:b,text:PKS-Ninja-T1-Baseline-0.1`

### Step 9: Shutdown and Save updated template per the [PKS Lab Shutdown Order](https://confluence.eng.vmware.com/display/CNA/OneCloud+PKS+Lab+Startup+Optmization#OneCloudPKSLabStartupOptmization-PksLabShutdownOrder)