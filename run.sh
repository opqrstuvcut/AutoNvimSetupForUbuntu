apt install software-properties-common -y
add-apt-repository ppa:neovim-ppa/unstable -y
apt update -y
apt install neovim -y
echo alias vim=nvim >> ~/.bashrc
source ~/.bashrc
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh 
sh ./installer.sh ~/.cache/dein
sed -i -e "s#HOMEPATH#"$HOME"#g" ./init.vim
mkdir -p ~/.config/nvim
cp ./init.vim ~/.config/nvim/init.vim

if type "pip3" > /dev/null 2>&1; then
    pip3 install pynvim
else
    pip install pynvim
fi

curl -sL install-node.now.sh/lts | bash
