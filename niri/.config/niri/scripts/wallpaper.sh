#!/usr/bin/env bash
#  _      __     ____
# | | /| / /__ _/ / /__  ___ ____  ___ ____
# | |/ |/ / _ `/ / / _ \/ _ `/ _ \/ -_) __/
# |__/|__/\_,_/_/_/ .__/\_,_/ .__/\__/_/
#                /_/       /_/

_writeLog() {
  m=$1
  echo ":: $m"
}

use_cache=1
_writeLog "Using Wallpaper Cache"

# -----------------------------------------------------
# Create cache folder
# -----------------------------------------------------
cache_folder="$HOME/.cache/dotfiles"

if [ ! -d $cache_folder ]; then
  mkdir -p $cache_folder
fi

# -----------------------------------------------------
# Set defaults
# -----------------------------------------------------

force_generate=0

# Cache for generated wallpapers with effects
generatedversions="$cache_folder/wallpaper-generated"
if [ ! -d $generatedversions ]; then
  mkdir -p $generatedversions
fi

# Will be set when waypaper is running
waypaperrunning=$cache_folder/waypaper-running
if [ -f $waypaperrunning ]; then
  rm $waypaperrunning
  exit
fi

cachefile="$cache_folder/current_wallpaper"
blurredwallpaper="$cache_folder/blurred_wallpaper.png"
squarewallpaper="$cache_folder/square_wallpaper.png"
rasifile="$cache_folder/current_wallpaper.rasi"
defaultwallpaper="$HOME/.config/wallpapers/default.jpg"
wallpapereffect="$HOME/.config/settings/wallpaper-effect.sh"
blur="50x30"

# -----------------------------------------------------
# Get selected wallpaper
# -----------------------------------------------------

if [ -z $1 ]; then
  if [ -f $cachefile ]; then
    wallpaper=$(cat $cachefile)
  else
    wallpaper=$defaultwallpaper
  fi
else
  wallpaper=$1
fi
used_wallpaper=$wallpaper
_writeLog "Setting wallpaper with source image $wallpaper"
tmpwallpaper=$wallpaper

# -----------------------------------------------------
# Copy path of current wallpaper to cache file
# -----------------------------------------------------

if [ ! -f $cachefile ]; then
  touch $cachefile
fi
echo "$wallpaper" >$cachefile
_writeLog "Path of current wallpaper copied to $cachefile"

# -----------------------------------------------------
# Get wallpaper filename
# -----------------------------------------------------

wallpaperfilename=$(basename $wallpaper)
_writeLog "Wallpaper Filename: $wallpaperfilename"

# -----------------------------------------------------
# Detect Theme
# -----------------------------------------------------

SETTINGS_FILE="$HOME/.config/gtk-3.0/settings.ini"
THEME_PREF=$(grep -E '^gtk-application-prefer-dark-theme=' "$SETTINGS_FILE" | awk -F'=' '{print $2}')

# -----------------------------------------------------
# Execute matugen
# -----------------------------------------------------

_writeLog "Execute matugen with $used_wallpaper"
if [ "$THEME_PREF" -eq 1 ]; then
  matugen image $used_wallpaper -m "dark"
else
  matugen image $used_wallpaper -m "light"
fi

# -----------------------------------------------------
# Reload Waybar
# -----------------------------------------------------

sleep 1
$HOME/.config/niri/waybar/launch.sh

# -----------------------------------------------------
# Update SwayNC
# -----------------------------------------------------

sleep 0.1
swaync-client -rs

# -----------------------------------------------------
# Created blurred wallpaper
# -----------------------------------------------------

if [ -f $generatedversions/blur-$blur-$wallpaperfilename.png ] && [ "$force_generate" == "0" ] && [ "$use_cache" == "1" ]; then
  _writeLog "Use cached wallpaper blur-$blur-$wallpaperfilename"
else
  _writeLog "Generate new cached wallpaper blur-$blur-$wallpaperfilename with blur $blur"
  # notify-send --replace-id=1 "Generate new blurred version" "with blur $blur" -h int:value:66
  magick $used_wallpaper -resize 75% $blurredwallpaper
  _writeLog "Resized to 75%"
  if [ ! "$blur" == "0x0" ]; then
    magick $blurredwallpaper -blur $blur $blurredwallpaper
    cp $blurredwallpaper $generatedversions/blur-$blur-$wallpaperfilename.png
    _writeLog "Blurred"
  fi
fi
cp $generatedversions/blur-$blur-$wallpaperfilename.png $blurredwallpaper

# -----------------------------------------------------
# Create rasi file
# -----------------------------------------------------

if [ ! -f $rasifile ]; then
  touch $rasifile
fi
echo "* { current-image: url(\"$blurredwallpaper\", height); }" >"$rasifile"

# -----------------------------------------------------
# Created square wallpaper
# -----------------------------------------------------

_writeLog "Generate new cached wallpaper square-$wallpaperfilename"
magick $tmpwallpaper -gravity Center -extent 1:1 $squarewallpaper
cp $squarewallpaper $generatedversions/square-$wallpaperfilename.png
