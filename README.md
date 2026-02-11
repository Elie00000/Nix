🧊 Configuration NixOS – Elie

Ce dépôt contient ma configuration personnelle NixOS, versionnée avec Git afin d’avoir un système :

✅ Reproductible

✅ Versionné

✅ Facilement réinstallable

✅ Déployable sur une nouvelle machine

📦 Contenu du dépôt

configuration.nix → Configuration principale du système

hardware-configuration.nix → Configuration matérielle générée par NixOS

flake.nix → Définition flake (si utilisée)

flake.lock → Verrouillage des versions des dépendances

modules/ → Modules personnalisés (si présents)

home/ → Configuration Home-Manager (si utilisée)

🚀 Installation avec Flakes (Méthode recommandée)

Les flakes permettent une configuration 100% reproductible, portable et moderne.

1️⃣ Activer les flakes (si pas déjà fait)

Dans /etc/nixos/configuration.nix :

nix.settings.experimental-features = [ "nix-command" "flakes" ];


Puis :

sudo nixos-rebuild switch

2️⃣ Installer depuis le dépôt local

Cloner le dépôt :

git clone https://github.com/Elie00000/Nix.git
cd Nix


Puis reconstruire le système :

sudo nixos-rebuild switch --flake .#nom-de-la-machine


👉 Remplace nom-de-la-machine par ton hostname :

hostname

3️⃣ Installer directement depuis GitHub

Sans cloner :

sudo nixos-rebuild switch --flake github:Elie00000/Nix#nom-de-la-machine

🧰 Installation sans Flakes (Méthode classique)

Si tu ne veux pas utiliser les flakes.

1️⃣ Cloner le dépôt
git clone https://github.com/Elie00000/Nix.git
cd Nix

2️⃣ Copier les fichiers dans /etc/nixos
sudo cp configuration.nix /etc/nixos/
sudo cp hardware-configuration.nix /etc/nixos/

3️⃣ Rebuild
sudo nixos-rebuild switch

🖥 Réinstallation complète d’un système

Sur une nouvelle installation NixOS :

nix-shell -p git
git clone https://github.com/Elie00000/Nix.git
cd Nix
sudo nixos-rebuild switch --flake .#nom-de-la-machine

🔒 À propos de hardware-configuration.nix

Ce fichier est spécifique à la machine.
Il est conservé ici pour rendre le système entièrement reproductible.

Pour une nouvelle machine, il est recommandé de régénérer :

sudo nixos-generate-config
