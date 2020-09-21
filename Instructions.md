# Instructions

Run the `install.sh` script as root.

* You may have to configure zsh for the first time.

* For proper working of [libinput-gestures](https://github.com/bulletmark/libinput-gestures), you must be a member of the input group to have permission to read the touchpad device:

    `sudo gpasswd -a $USER input`

* To enable tapping for touch on touchpad, use `xinput list <device_id>`
> change the property_number (in my case it is 282) in config file

* To enable natural scrolling
> change the property_number (in my case it is 282) in config file

* For backup script to work properly, add `backup.sh` script in `$HOME/scripts` folder else change the backup_dir in the script.