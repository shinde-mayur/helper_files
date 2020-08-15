programs="openjdk-8-jre-headless imagemagick unzip"
android=30
linux_tools=6609375
android_home=$HOME/android-sdk
# Install necessary programs
echo "Installing $programs"
sudo apt-get install $programs -y
echo "$programs installed"


mkdir $android_home # Create android-sdk folder
echo "Created folder at $android_home"

#Download sdk tools
echo "Downloading android sdk tools..."
wget "https://dl.google.com/android/repository/commandlinetools-linux-"$linux_tools"_latest.zip" -o "tools.zip"
echo "Sdk tools downloaded"

echo "Copying tools inside android"
unzip tools.zip -d $android_home
rm tools.zip
echo "SDK tools copied to $android_home"

# Configures sdk to be used anywhere
echo "Configuring SDK..."
echo -e "\n\n
        # Android sdk config
        \n\n
        export ANDROID_HOME=$android_home \n
        export PATH=$PATH:$ANDROID_HOME/tools/bin \n
        export PATH=$PATH:$ANDROID_HOME/platform-tools" >> $HOME/.bashrc
source $HOME/.bashrc
sudo ln -s $ANDROID_HOME/tools/bin/sdkmanager /usr/bin/sdkmanager
sdkmanager --sdk_root=$ANDROID_HOME --version
echo "SDK configured."

echo "Downloading required tools for building apk.."
sdkmanager –sdk_root=$ANDROID_HOME 'platform-tools' 'platforms;android-30'
