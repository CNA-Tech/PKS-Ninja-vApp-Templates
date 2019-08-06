# "Multiple v12 templates need CPU allocation updated for L1 Hosts" Fixes #503

This update requires updating the vApp template properties through the vCloud Directory GUI or API. At this time I have not yet researched the vCD API and will implement this update in manual steps through the vCloud Directory web GUI as documented below.

1.1 Starting point is new CNABU-PKS-Ninja-v12-Baseline-0.5 template in a stopped/not-yet-started state, accessed via a vCD/OneCloud web gui interface. Start by loading the template so you can access and manipulate template settings. 

1.2 In the vCD/OneCloud web interface, select your provisioned instance of CNABU-PKS-Ninja-v12-Baseline-0.5 template, Navigate to the virtual machines tab, and then navigate to the `Properties > Hardware` tab to adjust hardware settings per the details below

- esx-01a
  - Number of Virtual CPU's: `4`
  - Cores Per Socket: `1`
- esx-02a
  - Number of Virtual CPU's: `4`
  - Cores Per Socket: `1`
- esx-03a
  - Number of Virtual CPU's: `4`
  - Cores Per Socket: `1`
- esx-04a
  - Number of Virtual CPU's: `8`
  - Cores Per Socket: `2`
- esx-05a
  - Number of Virtual CPU's: `8`
  - Cores Per Socket: `2`
- esx-06a
  - Number of Virtual CPU's: `8`
  - Cores Per Socket: `2`

This completes the Patch for Issue #503