#!/bin/bash
clear
echo "Linux Build Environment Setup Automater Script."
echo "Written by nolinuxnoparty."
echo "Released under supervision of Team Radium."
read -p "Press [Enter] key to continue..."

clear

echo "Entering Downloads Directory"
cd ~/Downloads
read -p "Press [Enter] key to continue..."
clear

echo "Installing Python!"
sudo apt-get install build-essential gcc
wget http://www.python.org/ftp/python/2.5.6/Python-2.5.6.tgz
tar -xvzf Python-2.5.6.tgz
cd Python-2.5.6
./configure --prefix=/usr/local/python2.5
make
sudo make install
sudo ln -s /usr/local/python2.5/bin/python /usr/bin/python2.5
cd ..

read -p "Press [Enter] key to continue..."

clear

echo "Installing JDK 6!"
wget  --no-check-certificate --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin"
chmod +x jdk-6u45-linux-x64.bin
sudo ./jdk-6u45-linux-x64.bin
sudo mv jdk1.6.0_45 /usr/lib/jvm/
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_45/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_45/bin/javac 1
sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.6.0_45/bin/javaws 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.6.0_45/bin/jar 1
sudo update-alternatives --install /usr/bin/javadoc javadoc /usr/lib/jvm/jdk1.6.0_45/bin/javadoc 1
java -version

read -p "Press [Enter] key to continue..."

clear

echo "Installing GNU Make!"

wget -o make.tar.gz http://ftp.gnu.org/gnu/make/make-3.81.tar.gz
tar -xvzf make-3.81.tar.gz
cd make-3.81
./configure
sudo make install
cd ..

read -p "Press [Enter] key to continue..."

clear

echo "Installing Required Packages!"

apt-get install git-core gnupg flex bison gperf build-essential \
zip curl zlib1g-dev libc6-dev libncurses5-dev x11proto-core-dev \
libx11-dev libreadline6-dev libgl1-mesa-dev tofrodos python-markdown \
libxml2-utils xsltproc pngcrush gcc-multilib lib32z1 schedtool

read -p "Press [Enter] key to continue..."

clear

echo "Installing GIT!"

sudo apt-get install git

echo "Installing ADB Drivers!"
sudo apt-get install android-tools-adb

read -p "Press [Enter] key to continue..."

clear

echo "Downloading and Configuring Android SDK!!"
echo "Which version of linux are you using?"
echo "[ 1 ] 32 bits"
echo "[ 2 ] 64 bits"

echo "Making sure unzip is installed"
sudo apt-get install unzip
read bits
	if [[ "$bits" == "1" ]]; then
		echo "Downloading SDK for 32bit Linux System"
		wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20130522.zip
		echo "Download Complete!!"
		echo "Extracting"
		unzip adt-bundle-linux-x86-20130522.zip
		echo "Configuring"
		cd ~/adt-bundle-linux-x64-20130522/tools
		./configure
		echo "Done!!"
		
	elif [[ "$bits" == "2" ]]; then
		echo "Downloading SDK for 64bit Linux System"
		wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20130522.zip
		echo "Download Complete!!"
		echo "Extracting"
		unzip adt-bundle-linux-x86_64-20130522.zip
		echo "Configuring"
		cd ~/adt-bundle-linux-x86_64-20130522/tools
		./configure
		echo "Done!!"
fi

read -p "Press [Enter] key to continue..."

clear

echo "Cleaning up downloaded shit!"
rm Python-2.5.6.tgz
rm Python-2.5.6
rm make-3.81.tar.gz
rm make-3.81
rm jdk-6u45-linux-x64.bin
rm adt-bundle-linux-x86-20130522
rm adt-bundle-linux-x86-20130522.zip
rm adt-bundle-linux-x86_64-20130522
adt-bundle-linux-x86_64-20130522.zip
read -p "Press [Enter] key to continue..."
clear

echo "Done!"

echo "Cheers!"
echo ""
echo "Thanks for using this script!"
echo "Now, Enjoy compiling roms/kernels :)"
read -p "Press [Enter] key to exit..."
exit