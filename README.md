# calculate-gnome  

## Gnome Profile for Calculate Linux Desktop  

It is developed based on the original Calculate Linux profiles and is compatible with calculate utilities  

The official website of the Calculate Linux project: https://www.calculate-linux.org  
Calculate Linux project on GitHub: https://github.com/calculatelinux  

***Warning: This is an unofficial profile for personal use. If you use it, then only at your own risk!!!***  

### How do I switch to a profile in the installed Calculate linux Desktop OS?  
**Using calculate utilities (recommended):**  
* Press CTRL-ALT-F1 to enter console mode  
* Stop the display manager by running a command from root or using sudo  
`/etc/init.d/display-manager stop`
* Update the Calculate Linux Desktop OS by running the command  
`cl-update --scan on`
* Update the Calculate Linux Desktop OS profile by running the command  
`cl-update-profile --url https://github.com/nemofsan/calculate-gnome.git CLDG/amd64/20`
* Update the Calculate Linux Desktop OS to reformat the world by running the command  
`cl-update --scan on`
* Rename the user's home directory (for proper user configuration) by running the command from root or using sudo  
`mv /home/[username] /home/[username].old`
* Start the display manager by running the command from root or using sudo  
`/etc/init.d/display-manager start`
* Restart your PC  

***Warning: It may take a long time. You will lose the installed programs that are not in the profile templates.***  

### How to create an image on the Calculate linux Desktop OS?  
**Using calculate utilities (recommended):**  
* [Download](https://wiki.calculate-linux.org/desktop) Calculate Linux Scratch (CLS) image  
* Prepare a new OS build by running the command  
`cl-builder-prepare --iso /[imagepath]/[isoname].iso `
* Update the OS build by running the command  
`cl-builder-update -f`
* Update the OS build profile by running the command  
`cl-builder-profile --id distros:CLS/amd64/20 --url https://github.com/nemofsan/calculate-gnome.git CLDG/amd64/20`
* Log in to chroot by running the command from root or using sudo  
`chroot /run/calculate/mount/distros_CLS_amd64_20/`
* In chroot, fix the cyclic dependency error (temporarily) by running the command  
`mkdir /etc/portage/package.use`  
`echo "media-libs/libsndfile minimal" > /etc/portage/package.use/circular-dependencies`
* Exit the chroot by running the `exit` command  
* Update the OS build to reformat the world  
* Log in to the chroot again  
* In the chroot, delete the folder with the circular-dependencies file by running the command  
`rm -r /etc/portage/package.use`
* Update the OS build again  
* Create a new image (proprietary video drivers are not included in the image, the '--video on' parameter will enable them) by running the command  
`cl-builder-image --id distros:CLS/amd64/20 --video off `
* Complete the OS build by running the command  
`cl-builder-break --id distros:CLS/amd64/20` 

The new image will be located in `/var/calculate/linux/`  

***Warning: Takes a long time.***  
