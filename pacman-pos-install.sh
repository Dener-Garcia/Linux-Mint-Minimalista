#!/bin/bash

#CORES

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

# Internet conectando?
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

##DIRETÓRIOS E ARQUIVOS

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"

## Atualizando o repositório ##
just_update(){
sudo pacman -S --noconfirm
}

update(){
  sudo pacman -Syu --noconfirm
}

# Array dos softwares que seriam instalados com pacman

programasTerminal=(
wireshark-qt
  bitwarden
  gparted
  vlc
  git
  wget
  neofetch
  net-tools
  fragments
  virtualbox
  inkscape
  f3d
  onlyoffice-desktopeditors
  code
  freecad
  gimp
  v4l2loopback-utils
  warpinator
  flameshot
  vivaldi
  obs-studio
  deepin-picker
  deepin-draw
  flatpak 
  nodejs npm
  telegram-desktop
  discord
  barrier
  peek
  kodi
)

# Função para instalar pacotes via pacman

install_pacman() {
  echo -e "${VERDE}[INFO] - Instalando programas pelo pacman.${SEM_COR}"
  for nome_do_programa in "${programasTerminal[@]}"; do
    if ! pacman -Qi "$nome_do_programa" &> /dev/null; then
      sudo pacman -S "$nome_do_programa" --noconfirm
    else
      echo " [INSTALADO] - $nome_do_programa}"
    fi
  done
}


## Instalando pacotes Flatpak ##
install_flatpaks(){

  echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${VERDE}"

	# Cura - Slicer para impressao 3D
	flatpak install flathub com.ultimaker.cura -y 
	
	# Yoga - Otimiza e converte imagens
	flatpak install flathub org.flozz.yoga-image-optimizer -y

	# Insomnia - Criar teste de api com http
	flatpak install flathub rest.insomnia.Insomnia -y
	
	# QEletrotech - Cria diagramas elétricos
	flatpak install flathub org.qelectrotech.QElectroTech -y
	
	# Spotify - Streaming music
	flatpak install flathub com.spotify.Client -y
	
	# Proton VPN
	flatpak install flathub com.protonvpn.www -y
	
	# Portfolio Performance - Administrador financeiro
	flatpak install flathub info.portfolio_performance.PortfolioPerformance -y
	
	# Blender
	flatpak install flathub org.blender.Blender -y
	
	# Hidamari - Wallpaper motion
	flatpak install flathub io.github.jeffshee.Hidamari -y
	
	# Figma
	flatpak install flathub io.github.Figma_Linux.figma_linux -y
	
	# Mirror android screen
	flatpak install flathub in.srev.guiscrcpy -y
	
	# OpenRGB - Configuracao rgb devices
	flatpak install flathub org.openrgb.OpenRGB -y
	
	# Stremio - Plataforma de filmes e series
	flatpak install flathub com.stremio.Stremio
}
	
	#Cria pastas para produtividade no nautilus
	extra_config(){

	mkdir /home/$USER/Mundo3D
	mkdir /home/$USER/CriarBR 
	mkdir /home/$USER/Temp
	mkdir /home/$USER/Vídeos/'OBS Rec'
	mkdir /home/$USER/.AppImage
	mkdir /home/$USER/.ssh
	
	#Adiciona atalhos ao Nautilus

	if test -f "$FILE"; then
		echo "$FILE já existe"
	else
		echo "$FILE não existe, criando..."
		touch /home/$USER/.config/gkt-3.0/bookmarks
	fi

	echo "file:///home/$USER/Mundo3D 🎲 Mundo3D" >> $FILE
	echo "file:///home/$USER/CriarBR 👨🏻‍💻 CriarBR" >> $FILE
	echo "file:///home/$USER/Temp 🕖 Temp" >> $FILE
	echo "file:///home/$USER/.AppImage" >> $FILE
}
	
## Finalização, atualização e limpeza##

system_clean(){

sudo pacman -Sy --noconfirm
flatpak update -y
nautilus -q
}

# Chamando as função de instalação
testes_internet
update
install_pacman
just_update
install_flatpaks
extra_config
system_clean


  echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"

