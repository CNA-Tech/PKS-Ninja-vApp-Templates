# PKS-Ninja-v12-ClusterReady-0.5 Release Notes

**Milestone Page:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/milestone/1)

**Bugs Patched:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/issues?utf8=%E2%9C%93&q=label%3AAppliesTo%2FvAppTemplate%2Fv12-ClusterReady-0.4++milestone%3AMilestone6425+)

**New Features:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/issues?utf8=%E2%9C%93&q=label:enhancement/newFeature+label:AppliesTo/vAppTemplate/v12-ClusterReady++milestone:Milestone6425)

## How do I get access to a lab environment where I can run this template

Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/GetLabAccess-LA8528)

## ClusterReady Build Sequence Reference

In Milestone 6425, there were no bugs that applied to the ClusterReady template that did not also apply to the PksInstalled template. The only difference between the PksInstalled and ClusterReady template is that on the ClusterReady template has a Kubernetes cluster pre-deployed.

It is both a cleaner and more effecient strategy to deploy a cluster on the PksInstalled-0.2 template to build ClusterReady-0.5 rather than applying patches directly to the older template. 

Accordingly, if you would like to see a details record of which the patches for issues resolved in this release were applied, please see the [Release Notes for PKS-v12-PksInstalled-0.2]()

### Step 1: Load and Fully Boot PKS-Ninja-v12-PksInstalled-0.2 Template and Install K8s Cluster

1.1 Load and Fully Boot PKS-Ninja-v12-PksInstalled-0.2 Template

1.2 From the Control Center Desktop, open a putty session to `ubuntu@cli-vm` and login with the password `VMware1!`

1.3 Enter the command `pks login -a pks.corp.local -u pksadmin -p VMware1! -k` to login to the PKS API Server

1.4 Enter the command `pks create-cluster my-cluster --external-hostname my-cluster.corp.local --plan small` to deploy a kubernetes cluster

1.5 Enter the command `watch pks clusters` and wait for the deployment to succeed before proceeding

1.6 Enter the commands below to validate the cluster deployed successfully

```bash
pks get-credentials my-cluster
kubectl get pods --all-namespaces
```

### Step 2: Complete repetetive build processes

2.1 Ensure a clean and properly running version of the template with all of the patches in the steps above applied. Log into the control center desktop

2.2 Using vscode or your preferred text editor, from the control center desktop open the file `C:\hol\LabStartup.ps1`

2.3 On line 125 you should see the following entry: `WritePodSkuToDesktopInfo 'PKS-Ninja-v12-ClusterReady-0.4'` Update this line to reflect the new version number for the updated build: `WritePodSkuToDesktopInfo 'PKS-Ninja-v12-ClusterReady-0.5'` then save and close the file. 

2.4 Using vscode or your preferred text editor, from the control center desktop open the file `C:\DesktopInfo\desktopinfo.ini`

2.5 On line 25 you should see the entry `COMMENT=active:1,interval:60,color:FFFFFF,style:b,text:PKS-Ninja-v12-ClusterReady-0.4`, update this entry to reflect the new version number: `COMMENT=active:1,interval:60,color:FFFFFF,style:b,text:PKS-Ninja-v12-ClusterReady-0.5`

### Step 3: Shutdown and Save updated template per the [PKS Lab Shutdown Order](https://confluence.eng.vmware.com/display/CNA/OneCloud+PKS+Lab+Startup+Optmization#OneCloudPKSLabStartupOptmization-PksLabShutdownOrder)