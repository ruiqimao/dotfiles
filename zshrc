# oh-my-zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="custom"
DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-syntax-highlighting)

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
	mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# PATH variable
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH

# Local zshrc
ZSHRC_LOCAL=$HOME/.zshrc.local
if [[ ! -a $ZSHRC_LOCAL ]]; then
	touch $ZSHRC_LOCAL
fi
source $ZSHRC_LOCAL
