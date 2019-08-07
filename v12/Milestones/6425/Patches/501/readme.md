# "vApp Template v12-NsxtReady needs 2nd NIC on CLI-VM to be configured" Fixes #501

CLI-VM has a second NIC that should be connected to the logical switch ls-pks-mgmt to provide direct access for cli-vm to the PKS Control Plane network; however this is not installed in the Baseline template as NSXT has not been installed and there is no logical switch configured yet. The PksInstalled-0.1 and ClusterReady-0.4 and newer templates already have this 2nd nic configured, but it was missed for the NsxtReady template in the last build.

## Step 1: Configure CLI-VM 2nd Nic for PKS Management Network Connectivity

1.1 Ensure you have a clean and properly running NsxtReady-0.3 template fully booted up

1.2 From the control center desktop, connect to the vsphere web client and login

1.3 From the `Hosts and Clusters` page, right click on `cli-vm` and click `Edit Settings`

1.4 Click `Add New Device > Network Adapter` and set the `New Network` to the value `ls-pks-mgmt` and click `OK`

1.2 From the control center desktop, ssh to ubuntu@cli-vm and login

1.3 Enter command `sudo nano /etc/netplan/01-netcfg.yaml`

1.4 Add an entry for ens192 to the file so it matches the text below:

```bash
network:
  version: 2
  renderer: networkd
  ethernets:
    ens160:
      dhcp4: no
      addresses: [192.168.110.100/24]
      gateway4: 192.168.110.1
      nameservers:
        addresses: [192.168.110.10]
    ens192:
      dhcp4: no
      addresses: [172.31.0.100/24]
      nameservers:
        addresses: [192.168.110.10]
```

1.5 Save and Close the file

1.6 Enter the command `sudo netplan apply` to apply the updated settings

1.7 from cli-vm prompt, enter `ping 172.31.0.1` to validate the new configuration settings


This concludes the steps needed to resolve issue #501. Please be sure to reference the steps documented for the build process for the template you are updating prior to completing the update. 