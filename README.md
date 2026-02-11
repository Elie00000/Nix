NixOS Configuration

Configuration personnelle NixOS, versionnée afin de garantir un système reproductible, maintenable et facilement déployable sur une ou plusieurs machines.

configuration.nix : Configuration principale du système

hardware-configuration.nix : Configuration matérielle générée par NixOS

flake.nix : Définition Flake (si utilisée)

flake.lock : Verrouillage des versions des dépendances

modules/ : Modules NixOS personnalisés

home/ : Configuration Home Manager (si utilisée)

Installation avec Flakes (méthode recommandée)

Les Flakes permettent un déploiement reproductible et une gestion explicite des dépendances.

1. Activer les flakes

Ajouter dans configuration.nix :

nix.settings.experimental-features = [ "nix-command" "flakes" ];


Puis reconstruire :

sudo nixos-rebuild switch

2. Installation depuis le dépôt local

Cloner le dépôt :

git clone https://github.com/Elie00000/Nix.git
cd Nix


Identifier le nom d’hôte :

hostname


Reconstruction :

sudo nixos-rebuild switch --flake .#nom-de-la-machine

3. Installation directe depuis GitHub

Sans cloner le dépôt :

sudo nixos-rebuild switch --flake github:Elie00000/Nix#nom-de-la-machine

Installation sans Flakes (méthode classique)

Cette méthode utilise la configuration traditionnelle située dans /etc/nixos.

1. Cloner le dépôt
git clone https://github.com/Elie00000/Nix.git
cd Nix

2. Copier les fichiers dans /etc/nixos
sudo cp configuration.nix /etc/nixos/
sudo cp hardware-configuration.nix /etc/nixos/

3. Reconstruction
sudo nixos-rebuild switch

Réinstallation complète sur une nouvelle machine

Après une installation minimale de NixOS :

nix-shell -p git
git clone https://github.com/Elie00000/Nix.git
cd Nix
sudo nixos-rebuild switch --flake .#nom-de-la-machine


Si le matériel est différent, il est recommandé de régénérer :

sudo nixos-generate-config


et d’adapter hardware-configuration.nix.
