# password-generator

Generate a random password

### Usage:  
`password [length][-c|-copy][-a|-alnum]|[-h|-help]`

### Arguments:

`length` is any number. If a length is not supplied, a random length between 12 and 64 will be assigned.

`-c | -copy | --copy`   Copy the password to the clipboard

`-a | -alnum | --alnum` Restrict password to alphanumeric characters

`-h | -help | --help`   Display help


### Examples:

`password 36 -c`  will create a random string of 36 characters and copy it to the clipboard

`password 42` will create a random string of 42 characters and display it on the screen

`password` will create a random string of random length and display it on the screen

`password -c` will create a random string of random length and copy it to the clipboard

`password -a -c 27` will create a random string of 27 alphanumeric characters and copy it to the clipboard
	
The order of arguments does not affect the outcome. `password 12 -c -a` is the same as `password -c 12 -a` 
	
