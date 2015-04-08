# Redirect all output to ~/.vim_ruby_versions_paths
exec > ~/.vim_ruby_version_paths

# Get the names of all the installed Ruby versions
VERSIONS=`rbenv versions --bare`
case $VERSIONS in
    *system*)
        # VERSIONS already includes "system" - nothing to do
        ;;
    *)  # VERSIONS does not include "system" - check if it should
        if RBENV_VERSION=system rbenv which ruby &>/dev/null
        then
            VERSIONS="$VERSIONS system"
        fi
        ;;
esac

echo 'let g:ruby_version_paths = {'

for rv in $VERSIONS
do
    echo "  \\ '$rv': "
    # Print load path for version $rv
    RBENV_VERSION=$rv ruby -e 'print "  \\   #{$:}"' 2>/dev/null
    echo ","
done

echo '  \ }'
