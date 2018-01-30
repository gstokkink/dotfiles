#/bin/env sh

echo "Installing Homebrew and some packages"
if [[ ! -x $(which brew) ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew install ruby vim cask postgresql@9.6 rbenv ack awscli imagemagick phantomjs redis curl git wget zsh zsh-syntax-highlighting
brew cask install iterm2 google-chrome moom firefox java atom slack
brew install elasticsearch@5.6

echo "Installing PostgreSQL and Elastic Search services"
brew link --force postgresql@9.6
brew link --force elasticsearch@5.6
brew services start postgresql@9.6
brew services start elasticsearch@5.6

echo "Installing Ruby and the Bundler gem"
rbenv install 2.5.0
rbenv global 2.5.0
gem install bundler
rbenv install 2.2.6
rbenv shell 2.2.6
gem install bundler
rbenv shell 2.5.0

echo "Installing oh-my-zsh"
if hash chsh >/dev/null 2>&1; then
  sudo chsh -s $(grep /zsh$ /etc/shells | tail -1) $(whoami)
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

cd ~/Downloads
curl -fsSLO https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf

echo "Setup dotfiles repo"
mkdir ~/Projects
cd ~/Projects
git clone https://github.com/gstokkink/dotfiles dotfiles
cd dotfiles
git submodule update -i
cd vim/bundle/command-t
rake clean
rake make
cd ../../..

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

echo "Installing projects"
cd ~/Projects
git clone git@github.com:bookingexperts/bookingexperts.git
cd bookingexperts
bundle
cd ..
git clone git@github.com:bookingexperts/parkcms.git
cd parkcms
bundle
cd ..
git clone git@github.com:bookingexperts/cms.git
cd cms
bundle
cd ..
git clone git@github.com:bookingexperts/mediator.git
cd mediator
bundle
cd ..
git clone git@github.com:bookingexperts/assistance.git
cd assistance
bundle
cd ..
git clone git@github.com:bookingexperts/nucleus.git
cd nucleus
bundle
cd ..
git clone git@github.com:bookingexperts/model_attributes.git
cd model_attributes
bundle
cd ..

echo "All done!"
