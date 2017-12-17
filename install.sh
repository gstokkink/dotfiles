#/bin/env sh

echo "Installing Homebrew and some packages"
if [[ ! -x $(which brew) ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew install cask postgresql@9.6 elasticsearch@5.6 rbenv ack awscli imagemagick phantom-js redis curl git vim wget zsh
brew cask install iterm2 google-chrome flux moomi firefox

echo "Installing Ruby and the Bundler gem"
rbenv install
gem install bundler

echo "Installing oh-my-zsh"
if hash chsh >/dev/null 2>&1; then
  sudo chsh -s $(grep /zsh$ /etc/shells | tail -1) $(whoami)
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

echo "Setup dotfiles repo"
mkdir ~/Projects
cd ~/Projects
git clone https://github.com/gstokkink/dotfiles dotfiles
cd dotfiles
git submodule update -i

echo "Linking dotfiles"
ln -nsf ~/Projects/dotfiles/zshrc ~/.zshrc
ln -nsf ~/Projects/dotfiles/gitignore ~/.gitignore
ln -nsf ~/Projects/dotfiles/gitconfig ~/.gitconfig
ln -nsf ~/Projects/dotfiles/iterm2 ~/.iterm2
ln -nsf ~/Projects/dotfiles/gemrc ~/.gemrc
ln -nsf ~/Projects/dotfiles/vimrc ~/.vimrc
ln -nsf ~/Projects/dotfiles/vim ~/.vim


echo "Switch dotfiles remote"
git remote rm origin
git remote add origin git@github.com:gstokkink/dotfiles.git

echo "All done!"
