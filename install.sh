#!/bin/bash

# Check if pip3 is installed
if ! command -v pip3 &> /dev/null
then
    echo "No pip3 in $(PATH)"
    exit
fi

# Setup brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Setup OMZ
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# brew installations
brew tap koekeishiya/formulae
brew install wget
brew install git
brew install ansible
brew install pipx
brew install asdf
brew install pre-commit
brew install gnu-tar
brew install gpg
brew install fzf
brew install yq
brew install watch
brew install bat
brew install fd
brew install borders
brew install kind
# sketchybar related
brew install lua
brew install switchaudio-osx
brew install nowplaying-cli
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

brew services start borders

# pip installations
pip3 install pew
pipx ensurepath && pipx install aws-sso-util

# make useful path
mkdir -p ~/.config/nvim ~/.kube ~/.aws ~/Git ~/go ~/.config/borders ~/.config/sketchybar

# macOS Settings
echo "Changing macOS defaults..."
defaults write com.apple.Finder AppleShowAllFiles -bool true # show hidden files too
defaults write com.apple.finder CreateDesktop false killall Finder # no icons on desktop


# add asdf plugins
asdf plugin add awscli         https://github.com/MetricMike/asdf-awscli.git
asdf plugin add golang         https://github.com/kennyp/asdf-golang.git
asdf plugin add jq             https://github.com/azmcode/asdf-jq.git
asdf plugin add kubectl        https://github.com/Banno/asdf-kubectl.git
asdf plugin add kubectx        https://gitlab.com/wt0f/asdf-kubectx.git
asdf plugin add neovim         https://github.com/richin13/asdf-neovim.git
asdf plugin add terraform      https://github.com/Banno/asdf-hashicorp.git
asdf plugin add nodejs         https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add yarn           https://github.com/twuni/asdf-yarn.git
asdf plugin add rust           https://github.com/code-lever/asdf-rust.git
asdf plugin add kubent         https://github.com/virtualstaticvoid/asdf-kubent.git
asdf plugin add k9s            https://github.com/looztra/asdf-k9s.git
asdf plugin add terraform-docs https://github.com/looztra/asdf-terraform-docs.git
asdf plugin add helm-docs      https://github.com/sudermanjr/asdf-helm-docs.git
asdf plugin add lazygit        https://github.com/nklmilojevic/asdf-lazygit.git
asdf plugin add lua            https://github.com/Stratus3D/asdf-lua.git
asdf plugin add github-cli     https://github.com/bartlomiejdanek/asdf-github-cli.git
asdf plugin add rust           https://github.com/code-lever/asdf-rust.git
asdf plugin add tmux           https://github.com/aphecetche/asdf-tmux.git

# neovim installers
npm install -g neovim
pip3 install neovim
read -p "Enter Sudo Password" passwd
echo $passwd | sudo -S gem install neovim

# propagated configurations
mkdir -p ~/Git/$(whoami)
git clone https://github.com/vmarlier/dotfiles.git ~/Git/$(whoami)/dotfiles
ln -s ~/Git/$(whoami)/dotfiles/nvim ~/.config/nvim
ln -s ~/Git/$(whoami)/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/Git/$(whoami)/dotfiles/asdf/.tool-versions ~/.tool-versions
ln -s ~/Git/$(whoami)/dotfiles/borders/bodersrc ~/.config/borders/
ln -s ~/Git/$(whoami)/dotfiles/fonts ~/Library/Fonts
ln -s ~/Git/$(whoami)/dotfiles/yabai ~/.config/yabai
ln -s ~/Git/$(whoami)/dotfiles/skhd ~/.config/skhd

echo "OTHER SOFT TO DL => ITERM2, SPARK, AUTHY, BITWARDEN, ALFRED4, CLEAN MY MAC X, RECTANGLE"
echo "ASDF => run asdf install on your HOME folder"

csrutil status
echo "(optional) Disable SIP for advanced yabai features."
echo "(optional) Add sudoer manually:\n '$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | awk "{print \$1;}") $(which yabai) --load-sa' to '/private/etc/sudoers.d/yabai'"
echo "Installation complete...\n"
