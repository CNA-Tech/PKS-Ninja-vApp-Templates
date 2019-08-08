# "multiple v12 templates need large edge vm to enable multiple cluster creation" Fixes #505 

The initial set of v12 templates with NSXT configured including the NsxtReady, PksInstalled, and ClusterReady templates were all originally provisioned with a medium sized edge, and this needs to be updated to a large sized edge. 

To resize an NSX-T edge, the standard process is to build an additional edge, and use the provided `Replace Edge Cluster Member` feature provided in the NSX-T UI. 

Adding an additional edge device will require a seperate edge tn, hostname and IP address, which will cause discontinuity with the documentation. Accordingly we will build a 2nd edge named nsxedge-2, replace nsxedge-1, which causes the automatic deletion of nsxedge-1. After that point we can rebuild nsxedge-1 vm as a large size VM, and replace nsxedge-2, which will bring the naming back in alignement with template standards. 

As the lab environment does not have redundant edges, this operation could cause temporary network connectivity loss for the L2 VMs within the template. 

Accordingly we recommend shutting down any VM's that depend on NSX-T Networks prior to implementing this patch. If you are implementing this patch as part of a build sequence, it may be good to apply this patch toward the end of the sequence prior to template shutdown for templates with VM's that use NSX-T logical networks. 

## Step 1: Add nsxedge-2 and replace edge-tn-1

1.1 Connect to a clean & properly running instance of the template you want to patch

1.2 From the control center desktop, use a web browser to connect to NSX-T Manager UI and login

1.3 In the NSX Manager UI, Navigate to the `System > Fabric > Nodes > Edge Transport Nodes` page and click `ADD EDGE VM`

1.4 Complete the `Add Edge VM` workflow with the following values:

 - Name: nsxedge-2
 - FQDN: nsxedge-2.corp.local   
 - Form Factor: Large
 - CLI Password: VMware1!VMware1!
 - Allow SSH Login: Yes
 - System Root Password: VMware1!VMware1!
 - Allow Root SSH Login: Yes
 - Audit Username: audit
 - Audit Password: VMware1!VMware1!
 - Compute Manager: vcsa-01a
 - Cluster: RegionA01-MGMT01
 - Datastore: RegionA01-ISCSI02-COMP01
 - IP Assignment: Static
 - Management Interface: VM-RegionA01-vDS-MGMT
 - Management IP: 192.168.110.92/24
 - Default Gateway: 192.168.110.1
 - Search Domain Names: corp.local
 - DNS Servers: 192.168.110.10
 - NTP Servers: 192.168.100.1
 - On the new node switch pane:
   - Edge Switch Name: hostswitch-overlay
   - Uplink Profile: nsx-edge-single-nic-uplink-profile
   - IP Assignment: Use IP Pool
   - IP Pool: tep-ip-pool
   - DPDK Fastpath Interfaces:
     - uplink-1: Transport-RegionA01-vDs-MGMT
 - Click `+ ADD N-VDS` and add a new vds with the following values
   - Edge Switch Name: hostswitch-vlan
   - Uplink Profile: nsx-edge-single-nic-uplink-profile
   - IP Assignment: Leave Blank
   - DPDK Fastpath Interfaces:
     - uplink-1: Uplink-RegionA01-vDs-MGMT
 - Click Finish

1.5 Open a browser tab and login to vcenter. Allow the new nsxedge-2 node to fully load the vm in vcenter, and the system will automatically try to turn the VM on and have an error message indicating there are not sufficient memory resources - right click the `nsxedge-2` vm and click `Edit Settings`

1.6 On the `Edit Settings` window, expand the `Memory` section, uncheck the box for `Reserce all guest memory`, change the `Reservation` value to `16 GB`, and then change the `Memory` value to `16 GB` and click `OK`

1.7 In vcenter right click and power on the nsxedge-2 VM

1.8 Return to the NSX Manager UI and navigate to the `System > Fabric > Nodes > Edge Transport Nodes`. Select nsxedge-2 and observe the Overview/Summary and wait for Controller and Manager connectivity to come up. This may take several minutes after you powered in the nsxedge-2 vm in the previous step, and you may need to log out and log back into NSX-T Manager to see the values update.

1.9 In the NSX Manager UI, navigate to `System > Fabric > Nodes > Edge Clusters` page, select `edge-cluster-1`, click the `Actions` menu and select `Replace Edge Cluster Member`

1.10 In the Replace Edge Cluster workflow, enter the following values:

- Replace: `edge-tn-1` 
- With `nsxedge-2`
- Click `Save`

1.11 Return to the NSX Manager UI and navigate to the `System > Fabric > Nodes > Edge Transport Nodes`. Observe the configuration state of edge-tn-1, after the replacement operation completes edge-tn-1 should be deleted. This may take several minutes and you may need to log out and log back into NSX-T Manager to see the values update. Do not proceed until edge-tn-1 is removed (automatically) from the `Edge Transport Nodes` page.

## Step 2: Add edge-tn-1 and replace nsxedge-2

2.1 From the control center desktop, use a web browser to connect to NSX-T Manager UI and login

2.2 In the NSX Manager UI, Navigate to the `System > Fabric > Nodes > Edge Transport Nodes` page

2.3 Click `ADD EDGE VM`

2.4 Complete the `Add Edge VM` workflow with the following values:

 - Name: edge-tn-1
 - FQDN: nsxedge-1.corp.local   
 - Form Factor: Large
 - CLI Password: VMware1!VMware1!
 - Allow SSH Login: Yes
 - System Root Password: VMware1!VMware1!
 - Allow Root SSH Login: Yes
 - Audit Username: audit
 - Audit Password: VMware1!VMware1!
 - Compute Manager: vcsa-01a
 - Cluster: RegionA01-MGMT01
 - Datastore: RegionA01-ISCSI02-COMP01
 - IP Assignment: Static
 - Management Interface: VM-RegionA01-vDS-MGMT
 - Management IP: 192.168.110.91/24
 - Default Gateway: 192.168.110.1
 - Search Domain Names: corp.local
 - DNS Servers: 192.168.110.10
 - NTP Servers: 192.168.100.1
 - Transport Zone: Select both `overlay-tz` and `vlan-tz`
 - On the new node switch pane:
   - Edge Switch Name: hostswitch-overlay
   - Uplink Profile: nsx-edge-single-nic-uplink-profile
   - IP Assignment: Use IP Pool
   - IP Pool: tep-ip-pool
   - DPDK Fastpath Interfaces:
     - uplink-1: Transport-RegionA01-vDs-MGMT
 - Click `+ ADD N-VDS` and add a new vds with the following values
   - Edge Switch Name: hostswitch-vlan
   - Uplink Profile: nsx-edge-single-nic-uplink-profile
   - IP Assignment: Leave Blank
   - DPDK Fastpath Interfaces:
     - uplink-1: Uplink-RegionA01-vDs-MGMT
 - Click Finish

2.5 Open a browser tab and login to vcenter. Allow the new edge-tn-1 node to fully load the vm in vcenter, and the system will automatically try to turn the VM on and have an error message indicating there are not sufficient memory resources - right click the `edge-tn-1` vm and click `Edit Settings`

2.6 On the `Edit Settings` window, expand the `Memory` section, uncheck the box for `Reserce all guest memory`, change the `Reservation` value to `16 GB`, and then change the `Memory` value to `16 GB` and click `OK`

2.7 In vcenter right click the `edge-tn-1` VM and select `Rename` and rename the VM to nsxedge-1 to match existing documentation. Right Click `edge-tn-1` and power on the VM.

2.8 Return to the NSX Manager UI and navigate to the `System > Fabric > Nodes > Edge Transport Nodes`. Select edge-tn-1 and observe the Overview/Summary and wait for Controller and Manager connectivity to come up. This may take several minutes after you powered in the nsxedge-1 vm in the previous step, and you may need to log out and log back into NSX-T Manager to see the values update.

2.9 In the NSX Manager UI, navigate to `System > Fabric > Nodes > Edge Clusters` page, select `edge-cluster-1`, click the `Actions` menu and select `Replace Edge Cluster Member`

2.10 In the Replace Edge Cluster workflow, enter the following values:

- Replace: `nsxedge-2` 
- With `edge-tn-1`
- Click `Save`

2.11 Return to the NSX Manager UI and navigate to the `System > Fabric > Nodes > Edge Transport Nodes`. Observe the configuration state of nsxedge-2, after the replacement operation completes nsxedge-2 should be deleted. This may take several minutes and you may need to log out and log back into NSX-T Manager to see the values update. Do not proceed until nsxedge-2 is removed (automatically) from the `Edge Transport Nodes` page. Note that I have done the replace operation several times, and most times the system deleted the replaced node automatically, but in some cases it did not delete it until I tried to manually delete the node from the NSX Manager UI, and then it gave an error message saying it was already deleted, which works fine so long as it gets deleted.

This completes the resolution steps for issue #505. Please be sure to reference the build instructions for the template you are updating for additional steps to complete the build process.


