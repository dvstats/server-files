#!/bin/sh

##
## DVSTATS Update Script
##
## Generates, processes, and (optionally) uploads a new stats file/page.
##


##
## Globals
##

SFDIR=/home/breakthrough/git-repos/dvstats-server-files
PUSH_TO_REMOTE=true


##
## CLI Argument Processing
##

while :; do
    case $1 in
#        -h|-\?|--help)   # Call a "show_help" function to display a synopsis, then exit.
#            show_help
#            exit
#            ;;
        -n|--no-upload)
            PUSH_TO_REMOTE=false
            ;;
        --)              # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'DVSTATS: WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)               # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done


##
## Stats-File Generation
##

echo 'DVSTATS: Generating stats file...
'
cd $SFDIR/output
pisg \
    --configfile=$SFDIR/config/pisg.conf            \
    --cfg CssDir=$SFDIR/template/                   \
    --cfg PageHead=$SFDIR/template/header.html      \
    --cfg PageFoot=$SFDIR/template/footer.html

echo '
DVSTATS: Stats file generation complete.'


##
## Post-Processing
##

echo 'DVSTATS: Post-processing stats file...'

# Insert font/CSS template into HTML header
sed -e "5r $SFDIR/template/fonts.html" -i $SFDIR/output/dvstats.html

echo 'DVSTATS: Post-processing complete.'


##
## Upload to Remote Git Repo
##

if [ "$PUSH_TO_REMOTE" = true ]; then
    echo 'DVSTATS: Pushing update to remote repository...
'
fi

