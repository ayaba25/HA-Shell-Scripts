#!/bin/bash
# improve this scripts to create user and add to sudoers group.
echo "Please enter the user name for the account you want to create!"
read userName
echo "The name you entered is: "  $userName
/usr/sbin/useradd   $userName
/usr/sbin/usermod -G devops $userName
echo ".......User is created..........."
echo ".......Now Set the password for  ....... $userName"
passwd $userName
