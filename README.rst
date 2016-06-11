WallScreen
==========

Écran connecté du HAUM.

Applications
------------

wallscreen
~~~~~~~~~~

Il s'agit d'une application codée en QtQuick/QML qui gère l'affiche sur
l'écran.

buildroot
~~~~~~~~~

Il s'agit d'un utilitaire permettant de générer l'ensemble des
bibliothèques et logiciels pour faire fonctionner l'écran, y compris le
noyau linux et le bootloader.

Notes
-----

Compilation avec QtCreator
~~~~~~~~~~~~~~~~~~~~~~~~~~

Dans le projet, il faut ajouter une étape de cmpilation "make install"
qui installera les fichiers nécessaires dans le dossier de build.

Diaporama
~~~~~~~~~

Un dossier diaporama/ avec exclusivement des photos doit être présent
pour profiter de la fonction diaporama.

IRC
~~~

La réception des messages du canal IRC est extrêmement moche (d'où le
nom dirty de la classe). Par exemple, si un utilisateur utilise déjà le
pseudo wallscreen sur le serveur, cette partie du programme ne
fonctionne pas.

buildroot
~~~~~~~~~

À l'heure actuelle, aucun développement n'a été réalisé sur buildroot.
La procédure d'utilisation sera ajoutée après que le travail aura été
commencé.
