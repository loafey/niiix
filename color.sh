gdbus call --session --dest org.gnome.Shell.Screenshot --object-path /org/gnome/Shell/Screenshot --method org.gnome.Shell.Screenshot.PickColor\
    | sed -e 's/[a-zA-Z]//g' -e "s/[<>\(\)\{\}':\ ]//g" -e 's/.$//'\
    | tr ',' "\n"\
    | awk -F "\n" '{print $1*255}'\ 
    | awk -F "\n" '{printf("%02x",$1)}'\
    | awk '{printf("#"$1)}'\
    | wl-copy