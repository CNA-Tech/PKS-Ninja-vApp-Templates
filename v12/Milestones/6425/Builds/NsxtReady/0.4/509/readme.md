# PKS-Ninja-v12-NsxtReady-0.4 Release Notes

**Milestone Page:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/milestone/1)

**Bugs Patched:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/issues?utf8=%E2%9C%93&q=label%3AAppliesTo%2FvAppTemplate%2Fv12-NsxtReady-0.3++milestone%3AMilestone6425+)

**New Features:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/issues?utf8=%E2%9C%93&q=label:enhancement/newFeature+label:AppliesTo/vAppTemplate/v12-NsxtReady++milestone:Milestone6425)

## NsxtReady-0.4 Build Sequence Reference

### Step 1: "Multiple v12 templates need CPU allocation updated for L1 Hosts" Fixes #503

1.1 Complete the steps documented in the [readme for issue #503](../../../../Patches/503/readme.md)

### Step 2: "Multiple v12 templates have internet access problems" Fixes #507

2.1 Complete the steps documented in the [readme for issue #507](../../../../Patches/507/readme.md)

### Step 3: "multiple v12 templates need a saved putty session for holuser@router and root@router for connecting to the vpodrouter #512 " Fixes #512

3.1 Complete the steps documented in the [readme for issue #512](../../../../Patches/512/readme.md)

### Step 4: "multiple v12 templates need large edge vm to enable multiple cluster creation" Fixes #505

4.1 Complete the steps documented in the [readme for issue #490](../../../../Patches/505/readme.md)

### Step 5: "vApp Template v12-NsxtReady needs 2nd NIC on CLI-VM to be configured" Fixes #501

5.1 Complete the steps documented in the [readme for issue #499](../../../../Patches/499/readme.md)

### Step 5: "Multiple v12 Templates do not have Helm Installed on cli-vm" Fixes #499

5.1 Complete the steps documented in the [readme for issue #499](../../../../Patches/499/readme.md)

### Step 6: "Multiple v12 templates have incorrect readme file details on control center desktop" Fixes #490

6.1 Complete the steps documented in the [readme for issue #490](../../../../Patches/490/readme.md)

### Step 7: "Multiple v12 templates have incorrect readme file details on control center desktop" Fixes #490

7.1 Complete the steps documented in the [readme for issue #519](../../../../Patches/519/readme.md)

### Step 8: Complete repetetive build processes

8.1 Ensure a clean and properly running version of the template with all of the patches in the steps above applied. Log into the control center desktop

8.2 Using vscode or your preferred text editor, from the control center desktop open the file `C:\hol\LabStartup.ps1`

8.3 On line 125 you should see the following entry: `WritePodSkuToDesktopInfo 'PKS-Ninja-v12-NsxtReady-0.4'` Update this line to reflect the new version number for the updated build: `WritePodSkuToDesktopInfo 'PKS-Ninja-v12-Baseline-0.6'` then save and close the file. 

8.4 Using vscode or your preferred text editor, from the control center desktop open the file `C:\DesktopInfo\desktopinfo.ini`

8.5 On line 25 you should see the entry `COMMENT=active:1,interval:60,color:FFFFFF,style:b,text:PKS-Ninja-v12-NsxtReady-0.3`, update this entry to reflect the new version number: `COMMENT=active:1,interval:60,color:FFFFFF,style:b,text:PKS-Ninja-v12-NsxtReady-0.4`

### Step 9: Shutdown and Save updated template