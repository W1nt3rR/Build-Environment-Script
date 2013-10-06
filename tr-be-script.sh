#!/bin/bash

export JOBS=`nproc`;

if [ $1 = "--auto" ]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM
  export SKIP=0
fi

clear
echo "TR Build Environment Setup Script"
echo "Written by nolinuxnoparty."
echo "Released under supervision of Team Radium."

if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo "Entering Downloads Directory"
if [ ! -d ~/Downloads ]; then
  mkdir -p ~/Downloads
fi
cd ~/Downloads

if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo "Installing Python!"
sudo apt-get install build-essential gcc $PARAM
wget http://www.python.org/ftp/python/2.5.6/Python-2.5.6.tgz
tar -xvzf Python-2.5.6.tgz
cd Python-2.5.6
./configure --prefix=/usr/local/python2.5
make -j${JOBS}
sudo make install -j${JOBS}
sudo ln -s /usr/local/python2.5/bin/python /usr/bin/python2.5
cd ..

if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo "Installing CCache!"
wget http://www.samba.org/ftp/ccache/ccache-3.1.9.tar.gz
tar -xvzf ccache-3.1.9.tar.gz
cd ccache-3.1.9
./configure
make -j${JOBS}
sudo make install -j${JOBS}
echo "export USE_CCACHE=1" >> ~/.bashrc
if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi


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

if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo "Installing GNU Make!"

wget -o make.tar.gz http://ftp.gnu.org/gnu/make/make-3.81.tar.gz
tar -xvzf make-3.81.tar.gz
cd make-3.81
./configure
sudo make install -j${JOBS}
cd ..

if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo "Installing Required Packages!"

sudo apt-get install git-core gnupg flex bison gperf build-essential \
zip curl zlib1g-dev libc6-dev libncurses5-dev x11proto-core-dev \
libx11-dev libreadline6-dev libgl1-mesa-dev tofrodos python-markdown \
libxml2-utils xsltproc pngcrush gcc-multilib lib32z1 schedtool \
libqt4-gui libqt4-core $PARAM

if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo "Installing GIT!"

sudo apt-get install git $PARAM

echo "Installing ADB Drivers!"
sudo apt-get install android-tools-adb $PARAM
sudo wget http://www.broodplank.net/51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules


if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo "Downloading and Configuring Android SDK!!"
echo "Making sure unzip is installed"
sudo apt-get install unzip $PARAM

if [ `getconf LONG_BIT` = "64" ]
then
        echo "Downloading SDK for 64bit Linux System"
	wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20130522.zip
	echo "Download Complete!!"
	echo "Extracting"
	mkdir adt-bundle
	mv adt-bundle-linux-x86_64-20130522.zip adt-bundle/adt-bundle-linux-x86-20130522.zip
	unzip adt-bundle-linux-x86_64-20130522.zip
	echo "Configuring"
	cd ~/adt-bundle-linux-x86_64-20130522/tools
	./configure
	echo "Done!!"
else
   	echo "Downloading SDK for 32bit Linux System"
	wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20130522.zip
	echo "Download Complete!!"
	echo "Extracting"
	mkdir adt-bundle
	mv adt-bundle-linux-x86-20130522.zip adt-bundle/adt-bundle-linux-x86-20130522.zip
	unzip adt-bundle-linux-x86-20130522.zip
	echo "Configuring"
	cd ~/adt-bundle/sdk/tools
	./configure
	echo "Done!!"
fi

if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo "Cleaning up temporary files..."
rm -f Python-2.5.6.tgz
rm -Rf Python-2.5.6
rm -f make-3.81.tar.gz
rm -Rf make-3.81
rm -f jdk-6u45-linux-x64.bin
rm -Rf adt-bundle-linux-x86-20130522
rm -f adt-bundle-linux-x86-20130522.zip
rm -Rf adt-bundle-linux-x86_64-20130522
rm -f ccache-3.1.9.tar.gz
rm -Rf ccache-3.1.9

if [ $SKIP==1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi
clear

echo "Done!"

echo "Cheers!"
echo ""
echo "Thanks for using this script!"
echo "Now, Enjoy compiling roms/kernels :)"
read -p "Press [Enter] key to exit..."
exit
