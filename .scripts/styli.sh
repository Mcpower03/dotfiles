#!/usr/bin/env bash
link="https://source.unsplash.com/random/"

if [ -z ${XDG_CONFIG_HOME+x} ]; then
    XDG_CONFIG_HOME="${HOME}/.config"
fi
if [ -z ${XDG_HOME+x} ]; then
    XDG_HOME="${HOME}"
fi
confdir="${XDG_CONFIG_HOME}/styli.sh"
if [ ! -d "${confdir}" ]; then
    mkdir -p "${confdir}"
fi
cachedir="${XDG_HOME}/Pictures/wallpapers"
if [ ! -d "${cachedir}" ]; then
    mkdir -p "${cachedir}"
fi

wallpaper="${cachedir}/wallpaper.jpg"

die() {
    printf "ERR: %s\n" "$1" >&2
    exit 1
}

# https://github.com/egeesin/alacritty-color-export
alacritty_change() {
    DEFAULT_MACOS_CONFIG="$HOME"/.config/alacritty/alacritty.yml
    
    # Wal generates a shell script that defines color0..color15
    SRC="$HOME"/.cache/wal/colors.sh
    
    [ -e "$SRC" ] || die "Wal colors not found, exiting script. Have you executed Wal before?"
    printf "Colors found, source ready.\n"
    
    READLINK=$( command -v greadlink || command -v readlink )
    
    # Get config file
    if [ -n "$1" ]; then
        [ -e "$1" ] || die "Selected config doesn't exist, exiting script."
        printf "Config found, destination ready.\n"
        CFG=$1
        [ -L "$1" ] && {
            printf "Following symlink to config...\n"
            CFG=$($READLINK -f "$1")
        }
    else
        # Default config path in Mac systems
        [ -e "$DEFAULT_MACOS_CONFIG" ] || die "Alacritty config not found, exiting script."
        
        CFG="$DEFAULT_MACOS_CONFIG"
        [ -L "$DEFAULT_MACOS_CONFIG" ] && {
            printf "Following symlink to config...\n"
            CFG=$($READLINK -f "$DEFAULT_MACOS_CONFIG")
        }
    fi
    
    # Get hex colors from Wal cache
    # No need for shellcheck to check this, it comes from pywal
    # shellcheck disable=SC1090
    . "$SRC"
    
    # Create temp file for sed results
    tempfile=$(mktemp)
    trap 'rm $tempfile' INT TERM EXIT
    
    # Delete existing color declarations generated by this script
    # If begin comment exists
    if grep -q '^# BEGIN ACE' "$CFG"; then
        # And if end comment exists
        if grep -q '^# END ACE' "$CFG"; then
            # Delete contents of the block
            printf "Existing generated colors found, replacing new colors...\n"
            sed '/^# BEGIN ACE/,/^# END ACE/ {
        /^# BEGIN ACE/! { /^# END ACE/!d; }
            }' "$CFG" > "$tempfile" \
            && cat "$tempfile" > "$CFG"
            # If no end comment, don't do anything
        else
            die "No '# END ACE' comment found, please ensure it is present."
        fi
        # If no begin comment found
    else
        # Don't do anything and notify user if there's an end comment in the file
        ! grep -q '^# END ACE' "$CFG" || die "Found '# END ACE' comment, but no '# BEGIN ACE' comment found. Please ensure it is present."
        printf "There's no existing 'generated' colors, adding comments...\n";
        printf '# BEGIN ACE\n# END ACE' >> "$CFG";
    fi
    
    # Write new color definitions
    # We know $colorX is unset, we set it by sourcing above
    # shellcheck disable=SC2154
    { sed "/^# BEGIN ACE/ r /dev/stdin" "$CFG" > "$tempfile" <<EOP
colors:
  primary:
    background: '$color0'
    foreground: '$color7'
  cursor:
    text:       '$color0'
    cursor:     '$color7'
  normal:
    black:      '$color0'
    red:        '$color1'
    green:      '$color2'
    yellow:     '$color3'
    blue:       '$color4'
    magenta:    '$color5'
    cyan:       '$color6'
    white:      '$color7'
  bright:
    black:      '$color8'
    red:        '$color9'
    green:      '$color10'
    yellow:     '$color11'
    blue:       '$color12'
    magenta:    '$color13'
    cyan:       '$color14'
    white:      '$color15'
EOP
} && cat "$tempfile" > "$CFG" \
&& rm "$tempfile"
trap - INT TERM EXIT
printf "'%s' exported to '%s'\n" "$SRC" "$CFG"
}

reddit(){
useragent="thevinter"
timeout=60

sort=$2
top_time=$3
if [ -z $sort ]; then
    sort="hot"
fi

if [ -z $top_time ]; then
    top_time=""
fi

if [ ! -z $1 ]; then
    sub=$1
else
    if [ ! -f "${confdir}/subreddits" ]; then
        echo "Please install the subreddits file in ${confdir}"
        exit 2
    fi
    readarray subreddits < "${confdir}/subreddits"
    a=${#subreddits[@]}
    b=$(($RANDOM % $a))
    sub=${subreddits[$b]}
    sub="$(echo -e "${sub}" | tr -d '[:space:]')"
fi

url="https://www.reddit.com/r/$sub/$sort/.json?raw_json=1&t=$top_time"
content=`wget -T $timeout -U "$useragent" -q -O - $url`
urls=$(echo -n "$content"| jq -r '.data.children[]|select(.data.post_hint|test("image")?) | .data.preview.images[0].source.url')
names=$(echo -n "$content"| jq -r '.data.children[]|select(.data.post_hint|test("image")?) | .data.title')
ids=$(echo -n "$content"| jq -r '.data.children[]|select(.data.post_hint|test("image")?) | .data.id')
arrURLS=($urls)
arrNAMES=($names)
arrIDS=($ids)
wait # prevent spawning too many processes
size=${#arrURLS[@]}
if [ $size -eq 0 ]; then
    echo The current subreddit is not valid.
    exit 1
fi
idx=$(($RANDOM % $size))
target_url=${arrURLS[$idx]}
target_name=${arrNAMES[$idx]}
target_id=${arrIDS[$idx]}
ext=`echo -n "${target_url##*.}"|cut -d '?' -f 1`
newname=`echo $target_name | sed "s/^\///;s/\// /g"`_"$subreddit"_$target_id.$ext
wget -T $timeout -U "$useragent" --no-check-certificate -q -P down -O ${wallpaper} $target_url &>/dev/null
}

unsplash() {
    local search="${search// /_}"
    if [ ! -z $height ] || [ ! -z $width ]; then
        link="${link}${width}x${height}";
    else
        link="${link}1920x1080";
    fi
    
    if [ ! -z $search ]; then
        link="${link}/?${search}"
    fi
    
    wget -q -O ${wallpaper} $link
}

deviantart(){
    client_id=16531
    client_secret=68c00f3d0ceab95b0fac638b33a3368e
    payload="grant_type=client_credentials&client_id=${client_id}&client_secret=${client_secret}"
    access_token=`curl --silent -d $payload https://www.deviantart.com/oauth2/token | jq -r '.access_token'`
    if [ ! -z $1 ]; then
        artist=$1
        url="https://www.deviantart.com/api/v1/oauth2/gallery/?username=${artist}&mode=popular&limit=24"
    elif [ ! -z $search ]; then
        [[ "$search" =~ ^(tag:)(.*)$ ]] && tag=${BASH_REMATCH[2]}
        if [ ! -z $tag ]; then
            url="https://www.deviantart.com/api/v1/oauth2/browse/tags?tag=$tag&offset=${RANDOM:0:2}&limit=24"
        else
            url="https://www.deviantart.com/api/v1/oauth2/browse/popular?q=$search&limit=24&timerange=1month"
        fi
    else
        #url="https://www.deviantart.com/api/v1/oauth2/browse/hot?limit=24&offset=${offset}"
        topics=( "adoptables" "artisan-crafts" "anthro" "comics" "drawings-and-paintings" "fan-art" "poetry" "stock-images" "sculpture" "science-fiction" "traditional-art" "street-photography" "street-art" "pixel-art" "wallpaper" "digital-art" "photo-manipulation" "science-fiction" "fractal" "game-art" "fantasy" "3d" "drawings-and-paintings" "game-art" )
        rand=$[$RANDOM % ${#topics[@]}]
        url="https://www.deviantart.com/api/v1/oauth2/browse/topic?limit=24&topic=${topics[$rand]}"
    fi
    content=`curl --silent -H "Authorization: Bearer ${access_token}" -H "Accept: application/json" -H "Content-Type: application/json" $url`
    urls=$(echo -n $content | jq -r '.results[].content.src')
    arrURLS=($urls)
    size=${#arrURLS[@]}
    idx=$(($RANDOM % $size))
    target_url=${arrURLS[$idx]}
    wget --no-check-certificate -q -P down -O ${wallpaper} $target_url &>/dev/null
}

usage(){
    echo "Usage: styli.sh [-s | --search <string>]
    [-h | --height <height>]
    [-w | --width <width>]
    [-b | --fehbg <feh bg opt>]
    [-c | --fehopt <feh opt>]
    [-a | --artist <deviant artist>]
    [-r | --subreddit <subreddit>]
    [-l | --link <source>]
    [-p | --termcolor]
    [-d | --directory]
    [-k | --kde]
    [-x | --xfce]
    [-g | --gnome]
    [-m | --monitors <monitor count (nitrogen)>]
    [-n | --nitrogen]
    "
    exit 2
}

type_check() {
    mime_types=("image/bmp" "image/jpeg" "image/gif" "image/png" "image/heic")
    isType=false
    
    for requiredType in "${mime_types[@]}"
    do
        imageType=$(file --mime-type ${wallpaper} | awk '{print $2}')
        if [ "$requiredType" = "$imageType" ]; then
            isType=true
            break
        fi
    done
    
    if [ $isType = false ]; then
        echo "MIME-Type missmatch. Downloaded file is not an image!"
        exit 1
    fi
}

select_random_wallpaper () {
    wallpaper=$(find $dir -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.svg" -o -iname "*.gif" \) -print | shuf -n 1)
}

pywal_cmd() {
    
    if [ $pywal -eq 1 ]; then
        wal -c
        wal -i ${wallpaper} -n -q
        if [ $TERM = alacritty ]; then
            alacritty_change
        fi
    fi
    
}

sway_cmd() {
    if [ ! -z $bgtype ]; then
        if [ $bgtype == 'bg-center'  ]; then
            mode="center"
        fi
        if [ $bgtype == 'bg-fill' ]; then
            mode="fill"
        fi
        if [ $bgtype == 'bg-max' ]; then
            mode="fit"
        fi
        if [ $bgtype == 'bg-scale'	]; then
            mode="stretch"
        fi
        if [ $bgtype == 'bg-tile'  ]; then
            mode="tile"
        fi
    else
        mode="stretch"
    fi
    swaymsg output "*" bg "${wallpaper}" "${mode}"
    
}

nitrogen_cmd() {
    for ((monitor=0; monitor < $monitors; monitor++))
    do
        local nitrogen=(nitrogen --save --head=${monitor})
        
        if [ ! -z $bgtype ]; then
            if [ $bgtype == 'bg-center' ]; then
                nitrogen+=(--set-centered)
            fi
            if [ $bgtype == 'bg-fill' ]; then
                nitrogen+=(--set-zoom-fill)
            fi
            if [ $bgtype == 'bg-max' ]; then
                nitrogen+=(--set-zoom)
            fi
            if [ $bgtype == 'bg-scale' ]; then
                nitrogen+=(--set-scaled)
            fi
            if [ $bgtype == 'bg-tile' ]; then
                nitrogen+=(--set-tiled)
            fi
        else
            nitrogen+=(--set-scaled)
        fi
        
        if [ ! -z $custom ]; then
            nitrogen+=($custom)
        fi
        
        nitrogen+=(${wallpaper})
        
        "${nitrogen[@]}"
    done
}

kde_cmd() {
    cp ${wallpaper} "${cachedir}/tmp.jpg"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = \"org.kde.image\";d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");d.writeConfig(\"Image\", \"file:${cachedir}/tmp.jpg\")}"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = \"org.kde.image\";d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");d.writeConfig(\"Image\", \"file:${wallpaper}\")}"
    rm "${cachedir}/tmp.jpg"
}

xfce_cmd() {
    connectedOutputs=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
    activeOutput=$(xrandr | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
    connected=$(echo $connectedOutputs | wc -w)
    
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -n -t string -s ~/Pictures/1.jpeg
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorLVDS1/workspace0/last-image -n -t string -s  ~/Pictures/1.jpeg
    
    for i in $(xfconf-query -c xfce4-desktop -p /backdrop -l|egrep -e "screen.*/monitor.*image-path$" -e "screen.*/monitor.*/last-image$"); do
        xfconf-query -c xfce4-desktop -p $i -n -t string -s ${wallpaper}
        xfconf-query -c xfce4-desktop -p $i -s ${wallpaper}
    done
}

gnome_cmd() {
    gsettings set org.gnome.desktop.background picture-uri "file://${wallpaper}"
}

feh_cmd() {
    local feh=(feh)
    if [ ! -z $bgtype ]; then
        if [ $bgtype == 'bg-center' ]; then
            feh+=(--bg-center)
        fi
        if [ $bgtype == 'bg-fill' ]; then
            feh+=(--bg-fill)
        fi
        if [ $bgtype == 'bg-max' ]; then
            feh+=(--bg-max)
        fi
        if [ $bgtype == 'bg-scale' ]; then
            feh+=(--bg-scale)
        fi
        if [ $bgtype == 'bg-tile' ]; then
            feh+=(--bg-tile)
        fi
    else
        feh+=(--bg-scale)
    fi
    
    if [ ! -z $custom ]; then
        feh+=($custom)
    fi
    
    feh+=(${wallpaper})
    
    "${feh[@]}"
}

pywal=0
kde=false
xfce=false
gnome=false
nitrogen=false
sway=false
monitors=1

PARSED_ARGUMENTS=$(getopt -a -n $0 -o h:w:s:l:b:r:a:c:d:m:pknxgy --long search:,height:,width:,fehbg:,fehopt:,artist:,subreddit:,directory:,monitors:,termcolor:,kde,nitrogen,xfce,gnome,sway -- "$@")

VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
    usage
    exit
fi
while :
do
    case "${1}" in
        -b | --fehbg)     bgtype=${2} ; shift 2 ;;
        -s | --search)    search=${2} ; shift 2 ;;
        -h | --height)    height=${2} ; shift 2 ;;
        -w | --width)     width=${2} ; shift 2 ;;
        -l | --link)      link=${2} ; shift 2 ;;
        -r | --subreddit) sub=${2} ; shift 2 ;;
        -a | --artist) artist=${2} ; shift 2 ;;
        -c | --fehopt)    custom=${2} ; shift 2 ;;
        -m | --monitors)  monitors=${2} ; shift 2 ;;
        -n | --nitrogen)  nitrogen=true ; shift ;;
        -d | --directory) dir=${2} ; shift 2 ;;
        -p | --termcolor) pywal=1 ; shift ;;
        -k | --kde)       kde=true ; shift ;;
        -x | --xfce)      xfce=true ; shift ;;
        -g | --gnome)     gnome=true ; shift ;;
        -y | --sway)      sway=true ; shift ;;
        -- | '') shift; break ;;
        *) echo "Unexpected option: $1 - this should not happen." ; usage ;;
    esac
done

if [ ! -z $dir ]; then
    select_random_wallpaper
elif [ $link = "reddit" ] || [ ! -z $sub ]; then
    reddit "$sub"
elif [ $link = "deviantart" ] || [ ! -z $artist ]; then
    deviantart "$artist"
else
    unsplash
fi

type_check

if [ $kde = true ]; then
    kde_cmd
elif [ $xfce = true ]; then
    xfce_cmd
elif [ $gnome = true ]; then
    gnome_cmd
elif [ $nitrogen = true ]; then
    nitrogen_cmd
elif [ $sway = true ]; then
    sway_cmd
else
    feh_cmd
fi


pywal_cmd
