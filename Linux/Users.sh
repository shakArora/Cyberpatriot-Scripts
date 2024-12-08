$i = 1
if [1 == $i]; then
    read -p "Unwanted user: (to exit type 00) " $USER
    if [ "$USER" != "00" ]; then
        sudo deluser $USER
    else
        echo "Exiting process."
        $i = 0
    fi
fi
