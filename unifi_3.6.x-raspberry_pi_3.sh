# Mirror of the instructions available here:
# http://www.lowefamily.com.au/2016/06/02/installing-ubiquiti-unifi-controller-5-on-raspberry-pi/
#
# These commands CANNOT be run in a script.
# They're just for reference.


# Install on Raspbian Jessie, or upgrade from Wheezy.
# Make sure all packages are upgraded (update && upgrade).


# Update firmware.
sudo rpi-update

# Install DIR Manager

sudo apt install dirmngr

# Add the UniFi repository to the sources list, using the following commands
echo 'deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti' | sudo tee -a /etc/apt/sources.list.d/ubnt.list > /dev/null
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50
sudo apt-get update


# Install unifi.
sudo aptitude install unifi -y


# Disable the default MongoDB database instance, using the following commands.
#
# Without making this small configuration change, you will have two separate
# instances of MongoDB running; an unused default database instance, and the
# UniFi database instance. This is obviously not desirable on a device with
# limited resources, such as the Raspberry Pi.
sudo systemctl stop mongodb && sudo systemctl disable mongodb

# Start Unifi Service and enable it permanently after each boot
sudo systemctl enable unifi && sudo systemctl start unifi

# sudo apt-get update && sudo apt-get install logrotate (Optional)
sudo apt-get update && sudo apt-get install logrotate

# Config LOGROTATE to start on the Unifi LOG Files
sudo bash -c 'cat >> /etc/logrotate.d/unifi << EOF
/var/log/unifi/*.log {
    rotate 5
    weekly
    missingok
    notifempty
    compress
    delaycompress
    copytruncate
}
EOF'

# Oracle Java 8 (Optional)
#
# The UniFi package automatically installs and configures
# OpenJDK Java 7. However, if you would prefer to use
# Oracle Java 8, perform the following steps.

# If needed (Raspbian Lite):
sudo aptitude install oracle-java8-jdk -y

# Copy the UniFi service controller template, using the following command:
sudo cp /lib/systemd/system/unifi.service /etc/systemd/system/

#  Add the `JAVA_HOME` environment variable for Java 8 to the UniFi
# service controller, using the following command:
sudo sed -i '/^\[Service\]$/a Environment=JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt' /etc/systemd/system/unifi.service

# Update system environment to use latest JAVA 8.0
sudo update-alternatives --config java

# If you wish to switch back to Java 7 at any point, execute the following commands:
#sudo rm /etc/systemd/system/unifi.service
#sudo reboot

#Before rebooting check Unfi Controller Logs
sudo tail -f /usr/lib/unifi/logs/server.log

#Chack also Unifi Mongo DB instance
sudo tail -f /usr/lib/unifi/logs/mongod.log

# Once completed, reboot your Raspberry Pi.
# sudo reboot

# When the reboot is complete, use a web browser to view HTTPS port 8443 on your Raspberry Pi:
# https://<raspberrypi>:8443


# Be sure there is enough disk space!
# If the server never starts up, try checking the log files:
#
# -   /usr/lib/unifi/logs/mongod.log
# -   /usr/lib/unifi/logs/server.log
#
# I had an issue where the disk was filled up before the DB could first be created.
# The symptom was mongodb logs indicated it wanted to upgrade the DB and exited.
# Removing the DB files and freeing up disk space fixed it after restarting unifi:
# sudo service unifi stop
# sudo rm /var/lib/unifi/db/*
# sudo service unifi start
