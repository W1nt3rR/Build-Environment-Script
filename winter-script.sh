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
echo " > [W I N T E R R] <"
echo
echo " Build Environment Setup Script"
echo
echo " Script for automatically obtaining all required dependencies "
echo " for all kinds of Android Developing (kernel compilation/mutation,"
echo " rom compilation/mutation, reverse engineering and theming)"
echo 
echo " The argument '--auto' can be used for assuming yes on most queries" 
echo
echo


if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Entering SCRIPT FILE'S DOWNLOAD Directory"
echo
if [ ! -d ~/winter-script ]; then
  mkdir -p ~/winter-script
fi
cd ~/winter-script

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
wget http://www.python.org/ftp/python/3.6.0/Python-3.6.0a2.tgz
tar -xvzf Python-3.6.0a2.tgz
cd ~/winter-script/Python-3.6.0a2
./configure --prefix=/usr/local/python3.6
make -j${JOBS}
sudo make install -j${JOBS}
sudo ln -s /usr/local/python3.6/bin/python /usr/bin/python3.6
cd ~/winter-script

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing CCache!"
echo
wget http://www.samba.org/ftp/ccache/ccache-3.2.5.tar.gz
tar -xvzf ccache-3.2.5.tar.gz
cd ~/winter-script/ccache-3.2.5
./configure
make -j${JOBS}
sudo make install -j${JOBS}
echo "export USE_CCACHE=1" >> ~/.bashrc
ccache -M 25G
cd ~/winter-script

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing JDK 6!"
echo
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java6-installer
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
cd ~/winter-script
wget http://ftp.gnu.org/gnu/make/make-4.2.1.tar.gz
tar -xvzf make-4.2.1.tar.gz
cd ~/winter-script/make-4.2.1
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
lib32ncurses5-dev lib32z-dev

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
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20140702.zip
        echo "Download Complete!!"
        echo "Extracting"
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86_64-20140702 ~/adt-bundle/adt_x64.zip
        cd ~/adt-bundle
        unzip adt_x64.zip
        mv -f adt-bundle-linux-x86_64-20140702/* .
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
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20140702.zip
        echo "Download Complete!!"
        echo "Extracting"
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86-20140702.zip ~/adt-bundle/adt_x86.zip
        cd ~/adt-bundle
        unzip adt_x86.zip
        mv -f adt-bundle-linux-x86-20140702/* .
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
echo "Installing DSIXDA's Android Kitchen"
echo
cd ~/winter-script
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
rm -f ~/winter-script/Python-3.6.0a2.tgz
sudo rm -rf ~/winter-script/Python-3.6.0a2
rm -f ~/winter-script/make-4.2.1.tar.gz
rm -rf ~/winter-script/make-4.2.1
rm -f ~/winter-script/ccache-3.2.5.tar.gz
rm -rf ~/winter-script/ccache-3.2.5
rm -rf ~/adt-bundle/adt-bundle-linux-x86_64-20140702
rm -rf ~/adt-bundle/adt-bundle-linux-x86-20140702
rm -f ~/adt-bundle/adt_x64.zip
rm -f ~/adt-bundle/adt_x86.zip
rm -f ~/winter-script/master.zip

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
echo "> [T E A M  R A D I U M] <"
echo
echo "Updated by:"
echo "> [W I N T E R R] "
echo 
read -p "Press [Enter] key to exit..."
exit
