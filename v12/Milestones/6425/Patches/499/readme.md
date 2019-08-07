# "Multiple v12 Templates do not have Helm Installed on cli-vm" Fixes #499

1.1 Connect to a clean & properly running instance of the template you want to patch

1.2 From the control center desktop, use putty to open a ssh session with CLI-VM

1.3 From the CLI-VM prompt, enter the following commands to install helm:

```bash
mkdir /home/ubuntu/helm
cd /home/ubuntu/helm
curl -o helm.tgz https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz
tar -zxvf helm.tgz
mv /linux-amd64/helm /usr/local/bin/helm
rm helm.tgz
```

This completes the resolution steps for issue #499. Please be sure to reference the build instructions for the template you are updating for additional steps to complete the build process.