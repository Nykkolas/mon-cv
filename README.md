# Pour créer le package à déployer

1. Récupérer le contenu static en prod (./build/dump-static-content.sh)
2. Faire les modifications nécessaires, tester
3. Tester que les conteneur Docker se construisent bien (./build/build-and-test.sh)
4. Commit
5. Attendre que les workflows Github soient ok

# Pour déployer sur un serveur

1. Créer une release Github (avec un tag pour la version)
2. Télécharger le package TAR de la release sur le serveur
3. Extraire les fichiers du package
4. Créer le fichier .env si nécessaire
5. exécuter ./build/deploy.sh

