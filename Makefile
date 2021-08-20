###
#
# Install all I need for working.
# Some of the installed tools are only for working at my current job.
#
###

ifeq (, $(shell which pip3))
 $(error "No pip3 in $(PATH)")
endif

workspace: prerequisites tree
	# Setup Neovim prerequisites
	brew install node neovim
	npm install -g neovim
	pip3 install neovim
	@read -p "Enter Sudo Password" passwd; \
	sudo -S $$passwd gem install neovim

	# Setup Neovim plugins dependencies
	brew install terraform-ls tflint yamllint prettier
	npm install dockerfile-language-server-nodejs fixjson
	pip3 install autopep8
	go get -u golang.org/x/lint/golint
	go get -u golang.org/x/tools/cmd/goimports
	go get -u github.com/kisielk/errcheck

	# Install Pew, Asdf, aws-sso-util
	pip3 install pew credstash
	brew install asdf
	pipx ensurepath
	pipx install aws-sso-util

	# Get dotfiles
	mkdir -p ~/Git/$(whoami)
	git clone https://github.com/vmarlier/dotfiles.git ~/Git/$(whoami)/dotfiles
	ln -s ~/Git/$(whoami)/dotfiles/nvim ~/.config/nvim
	ln -s ~/Git/$(whoami)/dotfiles/zsh/.zshrc ~/.zshrc

	# Get Font
	wget -L https://github.com/Karmenzind/monaco-nerd-fonts/blob/master/fonts/Monaco%20Nerd%20Font%20Complete.otf -P ~/Downloads/

	# Instructions
	echo "NERDFONT => To add monaco-nerd-font, launch Font Book Preferences on MacOS and add the downloaded file (check ~/Downloads)"
	echo "ITERM2 => Set the new fonts, and the colorscheme from dotfiles repo"
	echo "OTHER SOFT TO DL => ITERM2, SPARK, AUTHY, BITWARDEN, ALFRED4, CLEAN MY MAC X, RECTANGLE, STATION"
	echo "NVIM MARKDOWN PREVIEW PLUGIN => May encounter some bugs, check :messages, if tslib is the problem go to ~/.cache/dein/.../markdown-preview.nvim then run npm install"

tree:
	mkdir -p ~/.config/nvim ~/.kube ~/.aws ~/Git ~/go

prerequisites:
	# Setup brew
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# Setup OMZ
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	# Setup wget, Git, Go (latest), Terraform (latest), Awscli (latest), kubectl (latest), kubectx
	brew install wget git go terraform awscli kubectl kubectx ansible pipx
