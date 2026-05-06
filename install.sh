#!/bin/bash

# 1. Ask for sudo upfront and keep the keep-alive alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Starting installation..."

# 2. Setup Directory Structure & Clone Dotfiles
# We do this first so we have access to the Brewfile and .tool-versions
mkdir -p ~/Git/$(whoami)
if [ ! -d "$HOME/Git/$(whoami)/dotfiles" ]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/vmarlier/dotfiles.git ~/Git/$(whoami)/dotfiles
else
    echo "Dotfiles already exist, pulling latest changes..."
    cd ~/Git/$(whoami)/dotfiles && git pull && cd -
fi

# 3. Setup Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to path for the current session
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 4. Setup Oh My Zsh (Unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 5. Brew installations
# Points directly to the Brewfile in your repo
echo "Installing Brew bundle..."
brew bundle --file ~/Git/$(whoami)/dotfiles/brew/Brewfile

# 6. Make useful paths
mkdir -p ~/.config/nvim ~/.kube ~/.aws ~/go ~/kube_contexts

# 7. Propagated configurations (Symlinks)
echo "Creating symlinks..."
ln -sfn ~/Git/$(whoami)/dotfiles/nvim ~/.config/nvim
ln -sfn ~/Git/$(whoami)/dotfiles/zsh/.zshrc ~/.zshrc
ln -sfn ~/Git/$(whoami)/dotfiles/zsh/.zsh_aliases.zshrc ~/.zsh_aliases.zshrc
ln -sfn ~/Git/$(whoami)/dotfiles/zsh/.zsh_export.zshrc ~/.zsh_export.zshrc
ln -sfn ~/Git/$(whoami)/dotfiles/asdf/.tool-versions ~/.tool-versions
ln -sfn ~/Git/$(whoami)/dotfiles/zsh/starship.toml ~/.config/starship.toml

# Copy fonts (Symlinking fonts folder can sometimes be finicky on macOS)
cp -r ~/Git/$(whoami)/dotfiles/fonts/* ~/Library/Fonts/ 2>/dev/null || true

# 8. ASDF Plugins Setup
echo "Adding asdf plugins..."
# Using a loop to keep it clean
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

# 9. Tools & Agents
echo "Installing agents and CLI tools..."
curl -fsSL https://claude.ai/install.sh | bash
pipx ensurepath
pipx install aws-sso-util || true

# 10. Neovim Provider Setup (Node only, Python/Ruby omitted for cleanliness)
npm install -g neovim

echo -e "\n--- Manual Steps Required ---"
echo "1. Run 'asdf install' in your HOME folder to install all language versions."
echo "2. Download manually: Arc, ITERM2, BITWARDEN, RECTANGLE, DASH, DisplayLink Manager, Find My, Jabra Direct, Logi Options+, Logitech G Hub, NordVPN, pgAdmin4, Proton Drive, Proton Mail, Proton Authenticator, Proton Pass, qBittorrent, RayCast, Signal, Stocks, VLC, Yaak, What's app, Zoom \n\n\n"
echo -e "Installation complete!\n"
