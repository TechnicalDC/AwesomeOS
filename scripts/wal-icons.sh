#!/bin/bash

ICON_DIR="$HOME/.config/awesome/theme/icons"

normal=$(xrdb -query | grep "*.color6:" | cut -d":" -f'2' | cut -d" " -f1)

close=$(xrdb -query | grep "*.color4:" | cut -d":" -f'2' | cut -d" " -f1)
float=$(xrdb -query | grep "*.color5:" | cut -d":" -f'2' | cut -d" " -f1)
max=$(xrdb -query | grep "*.color3:" | cut -d":" -f'2' | cut -d" " -f1)

# FOR TITLEBAR ICONS
ls -r $ICON_DIR/titlebar | while read line; do
# sed  -e "s/fill:#....../fill:$normal/" -e "s/stroke:#....../stroke:$normal/" $line
	if grep "normal" $ICON_DIR/titlebar/$line; then
		sed -i -e "s/fill:#....../fill:$normal/" -e "s/stroke:#....../stroke:$normal/" $ICON_DIR/titlebar/$line
		echo "Normal"
		echo $line
	fi
	if grep "close" $ICON_DIR/titlebar/$line; then
		sed -i -e "s/fill:#....../fill:$close/" -e "s/stroke:#....../stroke:$close/" $ICON_DIR/titlebar/$line
		echo "Close"
		echo $line
	fi
	if grep "floating" $ICON_DIR/titlebar/$line; then
		sed -i -e "s/fill:#....../fill:$float/" -e "s/stroke:#....../stroke:$float/" $ICON_DIR/titlebar/$line
		echo "Float"
		echo $line
	fi
	if grep "maximize" $ICON_DIR/titlebar/$line; then
		sed -i -e "s/fill:#....../fill:$max/" -e "s/stroke:#....../stroke:$max/" $ICON_DIR/titlebar/$line
		echo "Max"
		echo $line
	fi
done


# FOR LAYOUT ICONS
ls -r $ICON_DIR/layouts | while read line; do
	sed -i -e "s/fill:#....../fill:$normal/" -e "s/stroke:#....../stroke:$normal/" $ICON_DIR/layouts/$line
done
