#!/bin/bash
#Collecting infos via zenity

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

#detecting software for proper filehandling

if [[ "$EXEC" =~ ".sh" ]]; then 
    EXECSTRG="sh " && echo "found exec sh"
fi


if [[ "$EXEC" =~ ".mp3" ]]; then 
    EXECSTRG="vlc " && echo "found exec vlc"
fi

if [[ "$EXEC" =~ ".xls" ]]; then 
    EXECSTRG="ooffice " && echo "found exec office"
fi

if [[ "$EXEC" =~ ".odt" ]]; then 
    EXECSTRG="ooffice " && echo "found exec office"
fi

if [[ "$EXEC" =~ ".doc" ]]; then 
    EXECSTRG="ooffice " && echo "found exec office"
fi





#create desktop file and fill it up
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

#move file to ~/.local/share/applications

mv ~/$NAME.desktop ~/.local/share/applications
echo "file moved"

zenity --info --text "Alles erledigt!"

exit 1
