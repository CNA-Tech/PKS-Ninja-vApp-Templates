# PKS-Ninja-v12-Baseline-0.6 Release Notes

**Milestone Page:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/milestone/1)

**Bugs Patched:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/issues?utf8=%E2%9C%93&q=label:AppliesTo/vAppTemplate/v12-Baseline-0.5++milestone:%22vApp+Templates+Baseline-0.6,+NsxtReady-0.4,+PksInstalled-0.2+and+ClusterReady-0.5%22+
)

**New Features:** [Click Here](https://github.com/CNA-Tech/PKS-Ninja/issues?utf8=%E2%9C%93&q=label:enhancement/newFeature+label:AppliesTo/vAppTemplate/v12-Baseline++milestone:%22vApp+Templates+Baseline-0.6,+NsxtReady-0.4,+PksInstalled-0.2+and+ClusterReady-0.5%22+)

## PKS vApp Template Build Process

PKS vApp Template builds generally require a combination of manual and automated methods, each bug or feature request patch instructions are located in the /{Series version number}/Milestones/{Milestone Number}/Patches/{Issue Number} subdirectory where specific instructions for each issue resolution (patch) are provided in a readme.md file. 

While resolution instructions for each specific issue are stored in an issue-specific subdirectory, the "Build" respresents the specific order and method used to apply the cumulitive set of patches planed for the build, which when applied result in the template incrementing its template-specific version number. 

After patch resolutions are documented for all issues planned for a given release per the [template project board](https://github.com/CNA-Tech/PKS-Ninja/projects), a PKS-Ninja Repository admin will initiate a manual build and validation process. The admin will decide and document a plan to best implement the required updates to the vApp template, save the updated template, validate the saved template, once validated initiate template transfers, and finally complete VLP lab setup for hosted-eval and qd. 

In the ideal scenario, an admin may consolidate the various patches into a single script file, however this approach is not always possible. The more common scenario is that the admin will use some combination of documented manual steps and scripts, executed in a sequence decided upon and documented by the administrator leading the build. 

Build instructions are template specific, the administrator who initiates the build process should open an issue ticket named the following naming convention: `"Build tracker for {SeriesVersionNumber}-{TemplateNamePostfix}-{TemplateVersionNumber} for Milestone-{MilestoneNumber}"`.  

Build instructions should be provided in the Release notes for the Milestone provided in the `{SeriesVersionNumber}/Milestones/{MilestoneNumber}/Builds/{TemplateNamePostfix}/{TemplateVersionNumber}/{BuildTrackerIssueNumber}/readme.md` file. Each build has issue-specific patches, and repetetive updates that need to be completed with each build such as updating the control center desktop watermark with the updated name and version number for the new build. 

### Build Assets and Artifacts

Related assets and dependencies must be stored in the {issue number}/assets/ directory or a child subdirectory either in the child subdirectory for the Build for build-wide assets, or for the Issue for issue specific assets. The administrator initiating the build must determine if assets are issue specific or build specific and make any consolidations or adjustments needed accordingly. 

For example if two seperate issues in a given build require modification of a common file or other asset, the resolutions for these patches should be placed into a common file saved in the build-specific `{SeriesVersionNumber}/Milestones/{MilestoneNumber}/Builds/{TemplateNamePostfix}/{TemplateVersionNumber}/{BuildTrackerIssueNumber}/Assets`. 

For another example, each build has issue-specific patches, and repetetive updates that need to be completed with each build such as updating the control center desktop watermark with the updated name and version number for the new build. Accordingly, on control center the C:\Hol\labstartup.ps1 file must be updated with each release, and accordingly should be saved in the Assets subdirectory for the Build: `{SeriesVersionNumber}/Milestones/{MilestoneNumber}/Builds/{TemplateNamePostfix}/{TemplateVersionNumber}/{BuildTrackerIssueNumber}/Assets`.

Assets and Artifacts can also be saved in one of the PKS Ninja online file shares, or as a container image in one of the approved PKS Ninja Lab repositories to ensure that the assets are available on all of the various onecloud orgs that Ninja templates may run on. While most students will access templates that already load with their desired template version, in some cases an updated template version may not yet be available and a user may desire to do an in-place upgrade of their template - this may not always be possible, but it is desireable to allow the possiblity for users to perform in-place upgrades to their templates. 

### Script-based patches

Within each issue specific subdirectory {Series version number}/Milestones/{Milestone Number}/Patches/{Issue Number} there is a readme file that should provide any instructions needed to implement a resolution to the bug or feature request. When possible, it is preferred to implement all resolutions with scripts or functions, as we eventually hope to implement builds with fully automated methods. 

Scripts should be placed or use an initial launch point of a {Issue Number}.sh if using shell script or {Issue Number}.ps1 if using powershell, and saved in the `{SeriesVersionNumber}/Milestones/{MilestoneNumber}/Patches/{IssueNumber}/` directory. For example, `/v12/Milestones/6452/Patches/503/503.sh`. 

The launch point script can reference any other script or language, but must include an instruction set capable of executing successfully from one of the jumpboxes in the lab environment. Unless otherwise specified, it will be assumed that shell scripts can be launched and complete successfuly from CLI-VM and powershell scripts can be run successfully from control center. 

To be clear, this "launch point script" is intended to be run one time during the template build process with the sole purpose of applying a bug patch or feature. 

### Manual patches

In many cases is may not be possible or we have not yet been able to create a script based resolution. In these cases, specific documentation for the resolution steps should be provided in a `{SeriesVersionNumber}/Milestones/{MilestoneNumber}/Patches/{IssueNumber}/readme.md` file, however you should review this file in the context of the overall build instruction set documented in the `{SeriesVersionNumber}/Milestones/{MilestoneNumber}/Builds/{TemplateNamePostfix}/{TemplateVersionNumber}/{BuildTrackerIssueNumber}/readme.md` file, as the order in which patches are applied may be significant.

## Baseline-0.6 Build Sequence Reference

### Step 1: "Multiple v12 templates have internet access problems" Fixes #507

1.1 Complete the steps documented in the [readme for issue #507](../../../../Patches/507/readme.md)code readme.md

### Step 1: "Multiple v12 templates need CPU allocation updated for L1 Hosts" Fixes #503

1.1 Complete the steps documented in the [readme for issue #503](../../../../Patches/503/readme.md)code readme.md

### Step 2: "Multiple v12 templates have incorrect readme file details on control center desktop" Fixes #490

2.1 Complete the steps documented in the [readme for issue #490](../../../../Patches/490/readme.md)