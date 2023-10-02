###
#
# Install all I need for working.
# Some of the installed tools are only for working at my current job.
#
###

ifeq (, $(shell which pip3))
 $(error "No pip3 in $(PATH)")
endif

workspace: prerequisites brew pips tree asdf vim get instructions

instructions:
	echo "NERDFONT => To add monaco-nerd-font, launch Font Book Preferences on MacOS and add the downloaded file (check ~/Downloads)"
	echo "ITERM2 => Set the new fonts, and the colorscheme from dotfiles repo"
	echo "OTHER SOFT TO DL => ITERM2, SPARK, AUTHY, BITWARDEN, ALFRED4, CLEAN MY MAC X, RECTANGLE"
	echo "ASDF => run asdf install on your HOME folder"
	echo "NVIM => install LSP and Treesitter support listed in ~/Git/$(whoami)/dotfiles/lvim/README.md"
	echo "NVIM GO support => run a :checkhealth"

get:
	# Get dotfiles
	mkdir -p ~/Git/$(whoami)
	git clone https://github.com/vmarlier/dotfiles.git ~/Git/$(whoami)/dotfiles
	ln -s ~/Git/$(whoami)/dotfiles/lvim/config.lua ~/.config/lvim
	ln -s ~/Git/$(whoami)/dotfiles/zsh/.zshrc ~/.zshrc
	ln -s ~/Git/$(whoami)/dotfiles/asdf/.tool-versions ~/.tool-versions
	ln -s ~/Git/$(whoami)/dotfiles/zsh/kube-ps1.sh ~/.config/kube-ps1.sh
	ln -s ~/Git/$(whoami)/dotfiles/zsh/af-magic-reloaded.zsh-theme ~/.oh-my-zsh/custom/themes/af-magic-reloaded.zsh-theme
	echo "pew file -> vim /usr/local/lib/python3.9/site-packages/pew/shell_config/init.zsh need to be updated to make sure the init.zsh script does not break the zsh theme, comment the PS1 part." 
	# Get Font
	wget -L https://github.com/Karmenzind/monaco-nerd-fonts/blob/master/fonts/Monaco%20Nerd%20Font%20Complete.otf -P ~/Downloads/

vim:
	# Install neovim providers
	npm install -g neovim
	pip3 install neovim
	@read -p "Enter Sudo Password" passwd; \
	sudo -S $$passwd gem install neovim

nvim-completion:
	# see nvim/lua/plugins-settings.lua
	# 'gopls', 'bashls', 'jsonls', 'yamlls', 'terraform_lsp', 'ansiblels', 'cssls', 'html', 'pyright', 'dockerls'
	go install golang.org/x/tools/gopls@latest
	npm i -g bash-language-server
	npm i -g vscode-langservers-extracted #jsonls #cssls #html
	yarn global add yaml-language-server
	brew install hashicorp/tap/terraform-ls
	npm install -g @ansible/ansible-language-server
	pip3 install pyright
	npm install -g dockerfile-language-server-nodejs

asdf: 
	asdf plugin add awscli    https://github.com/MetricMike/asdf-awscli.git
	asdf plugin add golang    https://github.com/kennyp/asdf-golang.git
	asdf plugin add jq        https://github.com/azmcode/asdf-jq.git
	asdf plugin add kubectl   https://github.com/Banno/asdf-kubectl.git
	asdf plugin add kubectx   https://gitlab.com/wt0f/asdf-kubectx.git
	asdf plugin add neovim    https://github.com/richin13/asdf-neovim.git
	asdf plugin add terraform https://github.com/Banno/asdf-hashicorp.git
	asdf plugin add nodejs    https://github.com/asdf-vm/asdf-nodejs.git
	asdf plugin add yarn      https://github.com/twuni/asdf-yarn.git

tree:
	mkdir -p ~/.config/nvim ~/.kube ~/.aws ~/Git ~/go

pips:
	pip3 install pew credstash
	pipx ensurepath && pipx install aws-sso-util

brew:
	brew install wget git ansible pipx pew asdf pre-commit gnu-tar gpg

prerequisites:
	# Setup brew
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# Setup OMZ
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
