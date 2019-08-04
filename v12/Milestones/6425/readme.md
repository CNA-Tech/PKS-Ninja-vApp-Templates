# PKS-Ninja-v12-Baseline-0.6 Release Notes

**Milestone Page:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/milestone/1)

**Bugs Patched:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/issues?utf8=%E2%9C%93&q=label:AppliesTo/vAppTemplate/v12-Baseline-0.5++milestone:%22vApp+Templates+Baseline-0.6,+NsxtReady-0.4,+PksInstalled-0.2+and+ClusterReady-0.5%22+
)

**New Features:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/issues?utf8=%E2%9C%93&q=label:enhancement/newFeature+label:AppliesTo/vAppTemplate/v12-Baseline++milestone:%22vApp+Templates+Baseline-0.6,+NsxtReady-0.4,+PksInstalled-0.2+and+ClusterReady-0.5%22+)

## PKS vApp Template Build Process

### Script-based patches

PKS vApp Template builds generally require a combination of manual and automated methods, each bug or feature request patch instructions are located in a subdirectory named with the main version number, subtemplate name, subtemplate version number, and the github issue number, for example /v12/Baseline/{version number}/{issue number}

Within each issue specific subdirectory there is a readme file that should provide any instructions needed to implement a resolution to the bug or feature request. When possible, it is preferred to implement all resolutions with scripts or functions, as we eventually hope to implement builds and other site automations using FaaS.

Scripts should be placed or use an initial launch point of a {Issue Number}.sh if using shell script or {Issue Number}.ps1 if using powershell, and saved in the ./{version number}/{issue number} directory. 

The launch point script can reference any other script or language, but must include an instruction set capable of executing successfully from one of the jumpboxes in the lab environment. Unless otherwise 

To be clear, this "launch point script" is intended to be run one time during the template build process with the sole purpose of applying a bug patch or feature improvement. 

### Manual patches

In many cases is may not be possible or we have not yet been able to create a script based resolution for many issues. In these cases, specific documentation for the resolution steps should be provided in a ./{version number}/{issue number}/readme.md file.

## Build Notes

After patches are available for all issues planned for a given release per the project board, a PKS-Ninja Repository admin will initiate a manual build and validation process. The admin will decide and document a plan to best implement the required updates to the vApp template, save the updated template, validate the saved template, once validated initiate template transfers, and finally VLP lab setup for hosted-eval and qd. 

In the ideal scenario, an admin may consolidate the various patches into a single script file, however this approach is not always possible. The more common scenario is that the admin will use some combination of documented manual steps and scripts, executed in a sequence documented by the administrator. 

Related assets and dependencies must be stored in the ./{version number}/{issue number}/assets/ directory, or in one of the PKS Ninja online file shares or as a container image in one of the approved PKS Ninja Lab repositories to ensure that the assets are available on all of the various onecloud orgs that Ninja templates may run on.

### Baseline-0.6 Build Sequence Reference

#### Step 1: "Multiple v12 templates need CPU allocation updated for L1 Hosts" Fixes #503

1.1 Complete the steps documented in the [readme for issue #503](./503/readme.md)code readme.md

#### Step 2: "Multiple v12 templates have incorrect readme file details on control center desktop" Fixes #490

2.1 Complete the steps documented in the [readme for issue #490](./490/readme.md)



