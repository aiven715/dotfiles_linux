USR=$1

# Copy repositories
sudo cp ./repos/*.list /etc/apt/sources.list.d/ &&

# Install repositories keys
sudo apt-get install -y apt-transport-https lsb-release gnupg &&
wget -qO- https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - &&
wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add - &&
sudo apt-get update &&

# Install packages
sudo apt-get install -y unzip curl adwaita-icon-theme gnome-themes-standard gnome-themes-extra adwaita-icon-theme-full fonts-noto-color-emoji xbacklight xterm qtile ttf-ubuntu-font-family fonts-dejavu fonts-liberation2 fonts-open-sans fonts-roboto fonts-ubuntu chromium-browser vim acpi alsa-tools materia-gtk-theme light-locker lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings git sublime-text nodejs lxappearance &&

# Create config dirs
mkdir -p ~/.config/qtile &&
mkdir -p ~/.config/sublime-text-3/Packages/User &&
mkdir -p ~/Images &&
sudo mkdir -p /usr/share/fonts/googlefonts &&
sudo mkdir -p /etc/lightdm &&

# Appending to .bashrc
(printf "\n" && cat ./config/.bashrc) >> ~/.bashrc &&

# Append wallpaper path with username
(printf "[greeter]\nbackground = /home/$USR/Images/wallpaper.jpg\n" && cat ./config/lightdm-gtk-greeter.conf) | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf &&

# Copy config files, fonts and wallpaper
cp ./config/.gtkrc-2.0 ./config/.vimrc ./config/.Xresources ./config/.xprofile ~/ &&
cp ./config/config.py ~/.config/qtile/ &&
cp ./config/Default\ \(Linux\).sublime-keymap ./config/Agila\ Oceanic\ Next.tmTheme ./config/Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/ &&
sudo cp ./config/20-custom.conf /usr/share/X11/xorg.conf.d/ &&
sudo cp ./config/keyboard /etc/default/ &&
sudo cp SourceCodePro-Regular.ttf /usr/share/fonts/googlefonts/ &&
cp wallpaper.jpg ~/Images/ &&

tput setaf 2 &&
echo "Success" &&
tput sgr0
