# Installation
Download Ubuntu net-install .iso and install it without any additional packages.

Install git:
  ```
  sudo apt-get install git
  ```

Clone that repo:
  ```
  git clone git@github.com:aiven715/dotfiles_linux.git
  ```
  
Go to dotfiles:
  ```
  cd ./dotfiles_linux
  ```

Run `install.sh` and provide your username as an argument:
  ```
  sudo ./install.sh your-username
  ```

Install `wicd`:
  ```
  sudo apt-get install wicd
  ```

Finish installation by removing dotfiles dir and rebooting:
  ```
  cd ../ && rm -rf ./dotfiles_linux && reboot
  ```
