# "Multiple v12 templates have internet access problems" Fixes #507

This update requires updating the vApp template properties through the vCloud Directory GUI or API. At this time I have not yet researched the vCD API and will implement this update in manual steps through the vCloud Directory web GUI as documented below.

This update must be completed from a OneCloud org that has access to all the required resources and assets to complete the steps below. In most cases, template updates are developed in the `wcd-vcd01-cnabu-t` org and then transferred to other onecloud orgs for end user access.

## Important Pre-Requisite

On any template with PKS Pre-installed including PksInstalled and ClusterReady templates, this patch should be applied from a freshly loaded template with only the control center and vpodrouter hosts booted up until the patch is applied. 

After the patch has been applied, the control center VM should be shut down, and then can be booted up with the rest of the template to ensure the lab startup script has no issues. 

The reason for this sequence is because the new vpodrouter that is added in Step1 does not have a route for the PKS control plane network until after you complete Step2 below. The missing route causes problems during the startup of the PKS environment. 

## Step 1: Replace vPodRouter VM

The impacted templates use a vPodRouter intended for HOL templates, which implement URL filtering policies. While the URL filtering could be disabled, a better practice will be to replace the vPodRouterHOL with the `vPodRouter v6.1` VM which is intended for non HOL use. The `vPodRouter v6.1` VM does not by default have URL filtering turned on, so it will inherently resolve the issue of users not being able to access the internet

1.1 Log into a Onecloud web interface and load the CNABU-PKS-Ninja-v12-Baseline-0.5 template in a stopped/not-yet-started state.

1.2 In the vCD/OneCloud web interface, select your provisioned instance of CNABU-PKS-Ninja-v12-Baseline-0.5 template, Navigate to the virtual machines tab, and delete the vPodRouterHOL VM

1.3 In the vCD web interface, click the `+` button to add a VM to the template. 

1.4 In the `New Virtual Machine` dialogue, search for `vPodRouter v6.1` and select the `vPodRouter v6.1` sourced from the vApp `CNABU-2019-01-PKS Ninja-v11` template. Do not click Finish yet. 

1.5 In the `New Virtual Machine` dialogue, on the `Configure Virtual Machines` tab, assign `NIC 0` to the `vAppNet-single` network, set the `IP Assignment` field to the value `Static - Manual` and enter the IP address `192.168.0.2`

1.6 In the `New Virtual Machine` dialogue, on the `Configure Virtual Machines` tab, assign `NIC 1` to the `vAppNet-single` network, set the `IP Assignment` field to the value `DHCP` and click `Next`

1.7 In the `New Virtual Machine` dialogue, on the `Configure Networking` tab, ensure that `vAppNet-single` is connected to an external network with `NAT` enabled and `Firewall` Disabled. Click Finish to complete the `New Virtual Machine` worflow. 

## Step 2: Update `vPodRouter v6.1` with route to PKS Control Plane external NAT IP Range

The PKS Control Plane in the Lab Environment is typically implemented on a local/private subnet and implements a NATTED IP Range on the T0 Router so that external hosts can connect to the PKS Control Plane VM's. The vPodRouter needs to have a route to this natted IP address range so that hosts in the lab environment can have ip connectivity to the pks control plane VM's. 

In the v12 templates, we updated the IP address used for the T0 interface from the old value of `192.168.200.3` to a new value of `192.168.210.3` and so accordingly, the `vPodRouter v6.1` VM will need to have its routing table entries updated to route traffic destined for the `10.40.14.0/24` network to the updated T0 Router IP address `192.168.210.3`, per the following steps.

2.1 Start the template and wait for it to fully boot

2.2 Login to the control center desktop in the running vApp, and use putty to ssh to `root@router` to update the vpodrouter with the correct route to the `10.40.14.0/24`network, which is the NATTED Network used to access the PKS Control Plane VM's, as described in the following steps:

2.3 From your ssh session to the vpodrouter, enter the command `sudo nano /etc/network/interfaces`, you will see 3 lines under the `iface eth1` configuration which include the address `10.40.14.0`, replace those lines with the corrected entries below. Or if you prefer, you can replace the entire file with the updated file in the assets folder for this issue: [interfaces](./Assets/interfaces). For your reference, a copy of the old file prior to the patch can be found here: [interfaces.old](./Assets/interfaces.old).

```bash
        up route add -net 10.40.14.0 netmask 255.255.255.0 gw 192.168.210.3
        post-up add -net 10.40.14.0 netmask 255.255.255.0 gw 192.168.210.3
        pre-down route del -net 10.40.14.0 netmask 255.255.255.0 gw 192.168.210.3
```
2.4 From your ssh connection to vpodrouter, enter the `reboot` command to rebood vpodrouter. This will cause your ssh session to disconnect, and if you are using an RDP session to connect to the pod, that will also be disconnected. 

2.5 After the vpodrouter completes rebooting, ssh back to root@router and enter the `ip route` command. Verify that the output has the entry `10.40.14.0/24 via 192.168.210.3 dev eth1`. 

This completes Step 2

## Step 3: Remove route add entry from control center C:\hol\labstartup.ps1

While v12 templates have until this release used the LabStartup script to inject the route for the PKS control plane network NAT range (10.40.14.0/24), for this milestone the templates will be updated to use the method described in Step 2 above. Accordingly, we will need to comment out the line used to add the route in previous versions to prevent potential conflicts, per the following steps:

3.1 From the Control Center desktop, open the C:\hol\LabStartup.ps1 file in visual studio code or your preferred text editor. Or alternatively you can replace the complete file with the LabStartup.ps1

3.2 At Line #228, you should see the entry `Add-Route "10.40.14.0" "255.255.255.0" "192.168.210.3"`, enter a hashtag at the beginning of the line to comment the line out such that the resulting/updated entry is `# Add-Route "10.40.14.0" "255.255.255.0" "192.168.210.3"` then save and close the file

This completes Step 3 and concludes the steps needed to resolve issue #507. Please be sure to reference the steps documented for the build process for the template you are updating prior to completing the update. 