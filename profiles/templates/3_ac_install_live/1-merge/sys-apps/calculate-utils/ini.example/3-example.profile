# Calculate comment=# append=after name=ini.env.example in(os_linux_pkglist,CLDG)!=
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
#=========================== User profile settings ===========================
#os_install_locale_language#
#?os_install_locale_language==ru#
#======================= Настройки профиля пользователя ======================
#os_install_locale_language#
#?os_install_locale_language==fr#
#======================= Paramètres de profil utilisateur ====================
#os_install_locale_language#
[profile]

#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Mouse cursor theme
#os_install_locale_language#
#?os_install_locale_language==ru#
# Тема курсора мышки
#os_install_locale_language#
#?os_install_locale_language==fr#
# Thème du curseur de la souris
#os_install_locale_language#
; appearance-cursor = Calculate

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Icon theme
#os_install_locale_language#
#?os_install_locale_language==ru#
# Тема иконок
#os_install_locale_language#
#?os_install_locale_language==fr#
# Thème des icônes
#os_install_locale_language#
; appearance-icons = Calculate

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Screen saver
#os_install_locale_language#
#?os_install_locale_language==ru#
# Заставка экрана
#os_install_locale_language#
#?os_install_locale_language==fr#
# Économiseur d'écran
#os_install_locale_language#
; appearance-screensaver =

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Look and feel
#os_install_locale_language#
#?os_install_locale_language==ru#
# Внешний вид
#os_install_locale_language#
#?os_install_locale_language==fr#
# Apparence
#os_install_locale_language#
; appearance-style =

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Desktop wallpaper. To change it, we recommended to use the parameters in
# the “theme” section
#os_install_locale_language#
#?os_install_locale_language==ru#
# Фоновое изображение рабочего стола. Рекомендуется менять обои при помощи
# настройки темы в секции "theme"
#os_install_locale_language#
#?os_install_locale_language==fr#
# Fond d’écran utilisateur. Il est recommandé d’utiliser les réglages
# appropriés de la section “thème” pour changer de fond d’écran
#os_install_locale_language#
; appearance-wallpaper =
; appearance-wallpaper-dark =

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Font size
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер шрифта
#os_install_locale_language#
#?os_install_locale_language==fr#
# Taille de la police
#os_install_locale_language#
; font-size = 10

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Keyboard delay (milliseconds)
#os_install_locale_language#
#?os_install_locale_language==ru#
# Задержка нажатия клавиш в миллисекундах
#os_install_locale_language#
#?os_install_locale_language==fr#
# Délai de frappe du clavier (millisecondes)
#os_install_locale_language#
; keyboard-delay = 330

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Keyboard repeat rate (characters per second)
#os_install_locale_language#
#?os_install_locale_language==ru#
# Частота повтора (знаков в секунду)
#os_install_locale_language#
#?os_install_locale_language==fr#
# Taux de répétition du clavier (caractères/sec)
#os_install_locale_language#
; keyboard-rate = 30

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Mouse click policy ('single' or 'double')
#os_install_locale_language#
#?os_install_locale_language==ru#
# Настройка клика мышки ('single' or 'double')
#os_install_locale_language#
#?os_install_locale_language==fr#
# Configuration du clic de la souris ('single' ou 'double')
#os_install_locale_language#
; mouse-clickpolicy = single

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Mouse double click delay (milliseconds)
#os_install_locale_language#
#?os_install_locale_language==ru#
# Задержка в миллисекундах двойного клика мышки
#os_install_locale_language#
#?os_install_locale_language==fr#
# Délai du double-clic (millisecondes)
#os_install_locale_language#
; mouse-doubleclick-delayed = 400

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Left hand mouse configuration
#os_install_locale_language#
#?os_install_locale_language==ru#
# Настройка мышки для левшей.
#os_install_locale_language#
#?os_install_locale_language==fr#
# Configuration de la souris pour gaucher
#os_install_locale_language#
; mouse-lefthanded = off

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Switching to standby mode when powered from the mains
#os_install_locale_language#
#?os_install_locale_language==ru#
# Переключение в режим ожидания при питании от сети
#os_install_locale_language#
#?os_install_locale_language==fr#
# Passage en mode veille lorsqu'il est alimenté par le secteur
#os_install_locale_language#
; power-ac-type = off

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Switching to standby mode when powered by battery
#os_install_locale_language#
#?os_install_locale_language==ru#
# Переключение в режим ожидания при питании от батареи
#os_install_locale_language#
#?os_install_locale_language==fr#
# Passage en mode veille lorsqu'il est alimenté par batterie
#os_install_locale_language#
; power-battery-type = off

#in#
#?in(os_linux_pkglist, CLDG)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Time in seconds before the display is turned off when idle, '0' - never
#os_install_locale_language#
#?os_install_locale_language==ru#
# Время в секундах, после которого дисплей переходит в режим ожидания, '0' -
# никогда
#os_install_locale_language#
#?os_install_locale_language==fr#
# Mettre en veille après (secondes), '0', ne jamais arrêter
#os_install_locale_language#
; power-display-sleep = 15

#in#
