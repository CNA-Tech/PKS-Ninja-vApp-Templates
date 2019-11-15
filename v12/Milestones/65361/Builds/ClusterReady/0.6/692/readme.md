# PKS-Ninja-v12-ClusterReady-0.6 Release Notes

**Milestone Page:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/milestone/2)

## How do I get access to a lab environment where I can run this template

Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.6/Courses/GetLabAccess-LA8528)

## ClusterReady-0.6 Build Sequence Reference

### Step 1: "NSXT Password expired on v12-ClusterReady-0.5 template - May effect all ClusterReady, PksInstalled & NsxtReady templates" Fixes #684

1.1 For the ClusterReady-0.6 template, the instructions in [PKS-Ninja Repo Issue Ticket #684](https://github.com/CNA-Tech/PKS-Ninja/issues/684) were not followed directly, instead, this template was built from a starting point of the PKS-Ninja-v12-PksInstalled-0.3 template which is already patched for Issue #684.

1.2 After loading PKS-Ninja-v12-PksInstalled-0.3 Template, created Kubernetes cluster per the instructions in the [Deploy First PKS Cluster](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DeployFirstCluster-DC1610) Lab Guide.

### Step 2: Complete repetetive build processes

2.1 Ensure a clean and properly running version of the template with all of the patches in the steps above applied. Log into the control center desktop

2.2 Using vscode or your preferred text editor, from the control center desktop open the file `C:\hol\LabStartup.ps1`

2.3 On line 125 you should see the following entry: `WritePodSkuToDesktopInfo 'PKS-Ninja-v12-ClusterReady-0.5'` Update this line to reflect the new version number for the updated build: `WritePodSkuToDesktopInfo 'PKS-Ninja-v12-ClusterReady-0.5'` then save and close the file. 

2.4 Using vscode or your preferred text editor, from the control center desktop open the file `C:\DesktopInfo\desktopinfo.ini`

2.5 On line 25 you should see the entry `COMMENT=active:1,interval:60,color:FFFFFF,style:b,text:PKS-Ninja-v12-ClusterReady-0.5`, update this entry to reflect the new version number: `COMMENT=active:1,interval:60,color:FFFFFF,style:b,text:PKS-Ninja-v12-ClusterReady-0.6`

### Step 3: Shutdown and Save updated template per the [PKS Lab Shutdown Order](https://confluence.eng.vmware.com/display/CNA/OneCloud+PKS+Lab+Startup+Optmization#OneCloudPKSLabStartupOptmization-PksLabShutdownOrder)