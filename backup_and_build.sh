#!/bin/bash

# ===========================================
# Script : backup_and_build.sh
# But : Sauvegarder l'image Docker actuelle et reconstruire le projet
# ===========================================

# Nom de l'image
IMAGE_NAME="bblm_image"

# Générer un tag de backup avec la date et l'heure
BACKUP_TAG="backup-$(date +%Y%m%d-%H%M)"

echo "------------------------------------------"
echo "1️⃣  Sauvegarde de l'image actuelle..."
docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${BACKUP_TAG}

if [ $? -eq 0 ]; then
    echo "✅ Image sauvegardée avec le tag : ${IMAGE_NAME}:${BACKUP_TAG}"
else
    echo "❌ Erreur lors de la sauvegarde de l'image."
    exit 1
fi

echo "------------------------------------------"
echo "2️⃣  Construction du nouveau build..."

# Build la nouvelle image depuis le Dockerfile du répertoire actuel
docker build -t ${IMAGE_NAME}:latest .

if [ $? -eq 0 ]; then
    echo "✅ Nouveau build terminé avec succès !"
else
    echo "❌ Erreur lors du build. Vous pouvez restaurer l'image précédente avec :"
    echo "   docker tag ${IMAGE_NAME}:${BACKUP_TAG} ${IMAGE_NAME}:latest"
    exit 1
fi

echo "------------------------------------------"
echo "3️⃣  Vérification des images Docker existantes..."
docker images | grep ${IMAGE_NAME}

echo "------------------------------------------"
echo "✅ Tout est prêt !"
echo "Si nécessaire, vous pouvez restaurer la sauvegarde avec :"
echo "   docker tag ${IMAGE_NAME}:${BACKUP_TAG} ${IMAGE_NAME}:latest"


# Place ce fichier dans ton répertoire de projet (là où est ton Dockerfile).
#Rends-le exécutable :

## chmod +x backup_and_build.sh

# Lance le script :
## ./backup_and_build.sh