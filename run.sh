apt update -y
apt install neovim -y
echo alias vim=nvim >> ~/.bashrc
. ~/.bashrc
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh 
sh ./installer.sh ~/.cache/dein
sed -i -e "s/HOMEPATH/"$HOME ./init.vim
mkdir -p ~/.config/nvim
ln -s ./init.vim ~/.config/nvim/init.vim

if type "pip3" > /dev/null 2>&1; then
    pip3 install pyneovim
else
    pip install pyneovim
fi

curl -sL install-node.now.sh/lts | bash
