#!/bin/bash

# 1. Ask for sudo upfront and keep the keep-alive alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Starting installation..."

# 2. Setup Directory Structure & Clone Dotfiles
# We do this first so we have access to the Brewfile and .tool-versions
mkdir -p ~/Git/$USER
if [ ! -d "$HOME/Git/$USER/dotfiles" ]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/vmarlier/dotfiles.git ~/Git/$USER/dotfiles
else
    echo "Dotfiles already exist, pulling latest changes..."
    cd ~/Git/$USER/dotfiles && git pull && cd -
fi

# 3. Setup Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to path for the current session depending on architecture
    if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# 4. Setup Oh My Zsh (Unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 5. Brew installations
echo "Installing Brew bundle..."
brew bundle --file ~/Git/$USER/dotfiles/brew/Brewfile

# 6. Make useful paths & Public Safety Secret File
mkdir -p ~/.config/nvim ~/.kube ~/.aws ~/go ~/kube_contexts

# 7. Propagated configurations (Symlinks)
echo "Creating symlinks..."
ln -sfn ~/Git/$USER/dotfiles/nvim ~/.config/nvim
ln -sfn ~/Git/$USER/dotfiles/zsh/.zshrc ~/.zshrc
ln -sfn ~/Git/$USER/dotfiles/zsh/.zsh_aliases.zshrc ~/.zsh_aliases.zshrc
ln -sfn ~/Git/$USER/dotfiles/zsh/.zsh_export.zshrc ~/.zsh_export.zshrc
ln -sfn ~/Git/$USER/dotfiles/asdf/.tool-versions ~/.tool-versions
ln -sfn ~/Git/$USER/dotfiles/zsh/starship.toml ~/.config/starship.toml

# Copy fonts
cp -r ~/Git/$USER/dotfiles/fonts/* ~/Library/Fonts/ 2>/dev/null || true

# Source asdf for the current shell session so we can use it below
. $(brew --prefix asdf)/libexec/asdf.sh

# 8. ASDF Plugins Setup
echo "Adding asdf plugins..."
ASDF_PLUGINS=(
    "awscli https://github.com/MetricMike/asdf-awscli.git"
    "firebase https://github.com/jthegedus/asdf-firebase.git"
    "flux2 https://github.com/tablexi/asdf-flux2.git"
    "github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git"
    "golang https://github.com/kennyp/asdf-golang.git"
    "helm-docs https://github.com/sudermanjr/asdf-helm-docs.git"
    "helm https://github.com/Antiarchitect/asdf-helm.git"
    "istioctl https://github.com/virtualstaticvoid/asdf-istioctl.git"
    "jq https://github.com/azmcode/asdf-jq.git"
    "krew https://github.com/bjw-s/asdf-krew.git"
    "kubectl https://github.com/Banno/asdf-kubectl.git"
    "kubectx https://gitlab.com/wt0f/asdf-kubectx.git"
    "kubent https://github.com/virtualstaticvoid/asdf-kubent.git"
    "kustomize https://github.com/Banno/asdf-kustomize.git"
    "lua https://github.com/Stratus3D/asdf-lua.git"
    "neovim https://github.com/richin13/asdf-neovim.git"
    "nodejs https://github.com/asdf-vm/asdf-nodejs.git"
    "opentofu https://github.com/virtualroot/asdf-opentofu.git"
    "postgres https://github.com/smashedtoatoms/asdf-postgres.git"
    "ripgrep https://gitlab.com/wt0f/asdf-ripgrep.git"
    "ruby https://github.com/asdf-vm/asdf-ruby.git"
    "starship https://github.com/gr1m0h/asdf-starship.git"
    "terraform-docs https://github.com/looztra/asdf-terraform-docs.git"
    "terraform https://github.com/Banno/asdf-hashicorp.git"
    "yarn https://github.com/twuni/asdf-yarn.git"
)

for item in "${ASDF_PLUGINS[@]}"; do
    asdf plugin add $item || true
done

# Automate tool installations
echo "Installing asdf tools..."
cd ~ && asdf install

# 9. Tools & Agents
echo "Installing agents and CLI tools..."
curl -fsSL https://claude.ai/install.sh | bash
# pipx should be available from brew, but ensure path anyway
pipx ensurepath
pipx install aws-sso-util || true

# 10. Neovim Provider Setup (Node only, Python/Ruby omitted for cleanliness)
# Node is now successfully installed via asdf above, so npm will work
echo "Setting up Neovim node provider..."
npm install -g neovim

echo -e "\n--- Manual Steps Required ---"
echo "Download manually: Arc, ITERM2, BITWARDEN, RECTANGLE, DASH, DisplayLink Manager, Find My, Jabra Direct, Logi Options+, Logitech G Hub, NordVPN, pgAdmin4, Proton Drive, Proton Mail, Proton Authenticator, Proton Pass, qBittorrent, RayCast, Signal, Stocks, VLC, Yaak, What's app, Zoom, KeepingYouAwake, FlyCut \n\n\n"
echo "Review Settings, Finder sidebar, Dock settings, Widgets.."
echo -e "Installation complete!\n"
