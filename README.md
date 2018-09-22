Usage:

    docker run -it scndel/python3-opencv python
    >>> import cv2

Cette image est créée selon la configuration d'environnement prévue par le Linux Magazine / France Hors-série n°96 "Vision assistée par Ordinateur avec OpenCV".

Pour inclure vos propres fichiers d'images, montez un volume dans le container lié au dossier local de votre machine les contenant:

    docker run -it -v <localDirectoryPath>:/home/ -w="/home" scndel/python3-opencv python
    >>> import cv2

Thanks to jjanzic for his great work. This image is a fork of https://hub.docker.com/r/jjanzic/docker-python3-opencv/ and contains OpenCV contrib.   