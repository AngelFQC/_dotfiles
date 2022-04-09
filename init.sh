current_dir=$(pwd)

RED='\033[0;31m'
NC='\033[0m'

sudo apt update

### Install Zsh and plugins

printf "\n${RED}Installing Zsh plugins and load configuration${NC}\n"

sudo apt install -y zsh
sudo apt install -y zplug

curl -sS https://starship.rs/install.sh | sh

curl -sL https://raw.githubusercontent.com/dracula/zsh-syntax-highlighting/master/zsh-syntax-highlighting.sh > "$HOME/.dracula-zsh-syntax-highlighting.sh"

ln -s "$current_dir/.zshrc" "$HOME/.zshrc"
ln -s "$current_dir/.bashrc" "$HOME/.bashrc"
ln -s "$current_dir/starship.toml" "$HOME/.config/starship.toml"

