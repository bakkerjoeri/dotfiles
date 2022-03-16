echo "Installing kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Antibody..."
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

echo "Installing tmux..."
apt install tmux

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "Installing language servers..."
npm install -g typescript typescript-language-server eslint_d prettier vscode-langservers-extracted

