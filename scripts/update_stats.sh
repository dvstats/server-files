#!/bin/sh

##
## DVSTATS Update Script
##
## Generates, processes, and (optionally) uploads a new stats file/page.
##


##
## Globals
##

SF_DIR=/home/breakthrough/dvstats/server-files
PROD_DIR=/home/breakthrough/dvstats/repo-live
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
#cd $SF_DIR/output
cd ~/.muh
pisg \
    --configfile=$SF_DIR/config/pisg.conf            \
    --cfg CssDir=$SF_DIR/template/                   \
    --cfg PageHead=$SF_DIR/template/header.html      \
    --cfg PageFoot=$SF_DIR/template/footer.html
mv dvstats.html $SF_DIR/output/index.html
echo '
DVSTATS: Stats file generation complete.'


##
## Post-Processing
##

echo 'DVSTATS: Post-processing stats file...'

# Insert font/CSS template into HTML header
sed -e "5r $SF_DIR/template/fonts.html" -i $SF_DIR/output/index.html

echo 'DVSTATS: Post-processing complete.'


##
## Upload to Remote Git Repo
##

cp $SF_DIR/output/index.html $PROD_DIR/index.html

if [ "$PUSH_TO_REMOTE" = true ]; then
    echo 'DVSTATS: Pushing update to remote repository...
'
    cd $PROD_DIR
    git commit -a -m "Scheduled stats update."
    git push
fi

