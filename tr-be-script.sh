#!/bin/bash

export JOBS=`nproc`;

if [[ ${1} = "--auto" ]]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM=""
  export SKIP=0
fi

clear

echo
echo " > [T E A M   R A D I U M] <"
echo
echo " Build Environment Setup Script"
echo
echo " Script for automatically obtaining all required dependencies "
echo " for all kinds of Android Developing (kernel compilation/mutation,"
echo " rom compilation/mutation, reverse engineering and theming)"
echo 
echo " The argument '--auto' can be used for assuming yes on most queries" 
echo
echo " Visit us at:"
echo " - https://github.com/TeamRadium"
echo


if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing System Update "
echo
sudo apt-get update

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Entering Downloads Directory"
echo
if [ ! -d ~/Downloads ]; then
  mkdir -p ~/Downloads
fi
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing Python!"
echo
sudo apt-get install build-essential gcc $PARAM
wget http://www.python.org/ftp/python/2.5.6/Python-2.5.6.tgz
tar -xvzf Python-2.5.6.tgz
cd ~/Downloads/Python-2.5.6
./configure --prefix=/usr/local/python2.5
make -j${JOBS}
sudo make install -j${JOBS}
sudo ln -s /usr/local/python2.5/bin/python /usr/bin/python2.5
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing CCache!"
echo
wget http://www.samba.org/ftp/ccache/ccache-3.1.tar.gz
tar -xvzf ccache-3.1.tar.gz
cd ~/Downloads/ccache-3.1
./configure
make -j${JOBS}
sudo make install -j${JOBS}
echo "export USE_CCACHE=1" >> ~/.bashrc
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing JDK 6!"
echo
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

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing GNU Make!"
echo
wget http://ftp.gnu.org/gnu/make/make-4.0.tar.gz
tar -xvzf make-4.0.tar.gz
cd ~/Downloads/make-4.0
./configure
sudo make install -j${JOBS}
cd ~/


if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing Required Packages!"
echo
sudo apt-get install git-core gnupg flex bison gperf build-essential \
zip curl zlib1g-dev libc6-dev libncurses5-dev x11proto-core-dev \
libx11-dev libreadline6-dev libgl1-mesa-dev tofrodos python-markdown \
libxml2-utils xsltproc pngcrush gcc-multilib lib32z1 schedtool \
libqt4-dev lib32stdc++6 libx11-dev:i386 g++-multilib lib32z1-dev \
lib32ncurses5-dev ia32-libs mingw32 lib32z-dev

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Add  terminal to The mouse right button shortcut!"
echo
sudo apt-get install nautilus-open-terminal $PARAM
nautilus -q

echo
echo "Installing GIT!"
echo
sudo apt-get install git $PARAM

echo
echo "Installing Repo"
echo
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
fi
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo
echo "Installing ADB Drivers!"
echo
wget http://www.broodplank.net/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Downloading and Configuring Android SDK!!"
echo "Making sure unzip is installed"
echo
sudo apt-get install unzip $PARAM

if [ `getconf LONG_BIT` = "64" ]
then
        echo
        echo "Downloading SDK for 64bit Linux System"
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20131030.zip
        echo "Download Complete!!"
        echo "Extracting"
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86_64-20131030.zip ~/adt-bundle/adt_x64.zip
        cd ~/adt-bundle
        unzip adt_x64.zip
        mv -f adt-bundle-linux-x86_64-20131030/* .
        echo "Configuring environment"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
        echo "Placing desktop shortcuts"
        ln -s ~/adt-bundle/eclipse/eclipse ~/Desktop/Eclipse
        ln -s ~/adt-bundle/sdk/tools/android ~/Desktop/SDK-Manager
        echo "Done!!"
else
        echo
           echo "Downloading SDK for 32bit Linux System"
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20131030.zip
        echo "Download Complete!!"
        echo "Extracting"
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86-20131030.zip ~/adt-bundle/adt_x86.zip
        cd ~/adt-bundle
        unzip adt_x86.zip
        mv -f adt-bundle-linux-x86_64-20131030/* .
        echo "Configuring environment"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
        echo "Placing desktop shortcuts"
        ln -s ~/adt-bundle/eclipse/eclipse ~/Desktop/Eclipse
        ln -s ~/adt-bundle/sdk/tools/android ~/Desktop/SDK-Manager
        echo "Done!!"
fi

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing APKTool"
echo
wget http://android-apktool.googlecode.com/files/apktool1.5.2.tar.bz2
tar -jxf apktool1.5.2.tar.bz2
mv -f apktool1.5.2/apktool.jar ~/bin/apktool.jar
wget http://android-apktool.googlecode.com/files/apktool-install-linux-r05-ibot.tar.bz2
tar -jxf apktool-install-linux-r05-ibot.tar.bz2
mv -f apktool-install-linux-r05-ibot/aapt ~/bin/aapt
mv -f apktool-install-linux-r05-ibot/apktool ~/bin/apktool

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing DSIXDA's Android Kitchen"
echo
wget https://github.com/dsixda/Android-Kitchen/archive/master.zip
unzip master.zip
mv -f Android-Kitchen-master ~/Android-Kitchen
echo -e '\n#!/bin/bash\ncd ~/Android-Kitchen\n./menu' >> ~/Android-Kitchen/kitchen
chmod 755 ~/Android-Kitchen/kitchen
ln -s ~/Android-Kitchen/kitchen ~/bin/kitchen
ln -s ~/Android-Kitchen/kitchen ~/Desktop/Android-Kitchen

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Cleaning up temporary files..."
echo
rm -f ~/Downloads/Python-2.5.6.tgz
rm -Rf ~/Downloads/Python-2.5.6
rm -f ~/Downloads/make-4.0.tar.gz
rm -Rf ~/Downloads/make-4.0
rm -f ~/Downloads/jdk-6u45-linux-x64.bin
rm -f ~/Downloads/ccache-3.1.tar.gz
rm -Rf ~/Downloads/ccache-3.1
rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20131030
rm -Rf ~/adt-bundle/adt-bundle-linux-x86-20131030
rm -f ~/adt-bundle/adt_x64.zip
rm -f ~/adt-bundle/adt_x86.zip
rm -f ~/Downloads/master.zip
rm -f ~/Downloads/apktool1.5.2.tar.bz2
rm -Rf ~/Downloads/apktool1.5.2
rm -f ~/Downloads/apktool-install-linux-r05-ibot.tar.bz2
rm -Rf ~/Downloads/apktool-install-linux-r05-ibot

clear

echo
echo "Done!"
echo
echo "Cheers!"
echo
echo "Thanks for using this script!"
echo "Now, Enjoy compiling roms/kernels :)"
echo
echo "Credits:"
echo 
echo "Script created by:"
echo " - nolinuxnoparty"
echo 
echo "Additional implementations by:"
echo " - broodplank"
echo " - Ruling"
echo
read -p "Press [Enter] key to exit..."
exit
