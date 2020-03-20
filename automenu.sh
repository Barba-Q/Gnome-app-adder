#!/bin/bash
#Infos per Zenity sammeln

if ! NAME=$(zenity --entry --text "Name der im Menü angezeigt werden soll" --title "Bezeichnung"); then
  exit;
fi
echo "file name ok"
if ! EXEC=$(zenity --file-selection --title="Datei auswählen"); then
    exit;
fi
echo "exec ok"
if ! ICON=$(zenity --file-selection --title="Icon auswählen"); then
    exit;
fi
echo "icon ok"

#Ausführungspräfix für shellscripte

if [[ "$EXEC" =~ ".sh" ]]; then 
    EXECSTRG="sh " && echo "found exec sh"
fi

#Ausführungspräfix für medien
#Beliebig erweiterbar

if [[ "$EXEC" =~ ".mp3" ]]; then 
    EXECSTRG="vlc " && echo "found exec vlc"
fi


#Ausführungspräfix für office Dateien
#Beliebig erweiterbar

if [[ "$EXEC" =~ ".xls" ]]; then 
    EXECSTRG="ooffice " && echo "found exec office"
fi

if [[ "$EXEC" =~ ".odt" ]]; then 
    EXECSTRG="ooffice " && echo "found exec office"
fi

if [[ "$EXEC" =~ ".doc" ]]; then 
    EXECSTRG="ooffice " && echo "found exec office"
fi





#Datei im heimverzeichnis anlegen und mit Infos füttern
echo "creating .desktop file"
touch ~/$NAME.desktop 
echo "file created"
echo "[Desktop Entry]"                  >> ~/$NAME.desktop
echo "Name=$NAME"                       >> ~/$NAME.desktop
echo "Exec=$EXECSTRG${EXEC// /\\ }"     >> ~/$NAME.desktop
echo "Icon=${ICON// /\\ }"              >> ~/$NAME.desktop
echo "Terminal=false"                   >> ~/$NAME.desktop
echo "Type=Application"                 >> ~/$NAME.desktop
echo "file creation done"

#Datei in Heimverzeichnis/.local/share/Applications/ verschieben
#Danach ist das Icon im Gnomenü verfügbar

mv ~/$NAME.desktop ~/.local/share/applications
echo "file moved"

zenity --info --text "Alles erledigt!"

exit 1
