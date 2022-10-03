#!/bin/bash

######################################################################################
# $ release.sh broker/http                                                           #
#                                                                                    #
# Release plugins that have changed it requires to be in a git repo with a clean tag #
#                                                                                    #
######################################################################################

# https://stackoverflow.com/a/8659330
function increment_minor_version ()
{
    declare -a part=( ${1//\./ } )
    declare    new
    declare -i carry=1

    for (( CNTR=${#part[@]}-2; CNTR>=0; CNTR-=1 )); do
        len=${#part[CNTR]}
        new=$((part[CNTR]+carry))
        [ ${#new} -gt $len ] && carry=1 || carry=0
        [ $CNTR -gt 0 ] && part[CNTR]=${new: -len} || part[CNTR]=${new}
    done
    new="${part[*]}"
    echo -e "${new// /.}"
}

function increment_patch_version ()
{
    declare -a part=( ${1//\./ } )
    declare    new
    declare -i carry=1

    for (( CNTR=${#part[@]}-1; CNTR>=0; CNTR-=1 )); do
        len=${#part[CNTR]}
        new=$((part[CNTR]+carry))
        [ ${#new} -gt $len ] && carry=1 || carry=0
        [ $CNTR -gt 0 ] && part[CNTR]=${new: -len} || part[CNTR]=${new}
    done
    new="${part[*]}"
    echo -e "${new// /.}"
}

function release() {
    if [[ ! -d "${1}" ]]; then
        echo "Unknown package '${1}' given."
        exit 1
    fi

    local pkg="${1}"
    local last_tag=$(git tag --list --sort='-creatordate' "${pkg}/*"  | head -n1)
    if [[ "${last_tag}" == "" ]]; then
        echo -e "# No previous tag\n# Run:\ngh release create "${pkg}/v5.0.1" -n 'Initial release'"
        exit 0
    fi

    echo "# last_tag: ${last_tag}"
    local changes=$(git --no-pager log "${last_tag}..HEAD" --format="%s" "${pkg}/*")
    if [[ "${#changes[@]}" == "1" ]]; then
        echo "# No changes detected"
        exit 1
    fi

    local last_tag_split=(${last_tag//\// })
    
    local v_version=${last_tag_split[-1]}
    local version=${v_version:1}

    local feat_detected=$(git --no-pager log "${last_tag}..HEAD" --format="%s" "${pkg}/*" | grep -q "^feat" && echo "yes" || echo "no")
    if [[ "x${feat_detected}" == "xyes" ]]; then
        local tmp_new_tag="$(printf "/%s" "${last_tag_split[@]::${#last_tag_split[@]}-1}")/v$(increment_minor_version ${version})"
        local new_tag=${tmp_new_tag:1}
    else
        local tmp_new_tag="$(printf "/%s" "${last_tag_split[@]::${#last_tag_split[@]}-1}")/v$(increment_patch_version ${version})"
        local new_tag=${tmp_new_tag:1}
    fi

    echo -e "# Run:\ngh release create "${pkg}/${new_tag}" --generate-notes --notes-start-tag ${last_tag}"
}

release "${1}"