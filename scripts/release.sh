#!/bin/bash

######################################################################################
# $ release.sh broker/http                                                           #
#                                                                                    #
# Release plugins that have changed it requires to be in a git repo with a clean tag #
#                                                                                    #
######################################################################################

function increment_version ()
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

function last_tags() {
    local alltags=$(git tag --sort=-creatordate)
    for t in ${alltags}; do
        if [[ ${t} == *"${1}"* ]]; then
            echo ${t}
        fi
    done

}

function release() {
    if [[ ! -d "${1}" ]]; then
        echo "Unknown package '${1}' given."
        exit 1
    fi

    local pkg="${1}"
    local last_tag=$(last_tags "${pkg}" | head -n 1)
    local last_tag_split=(${last_tag//\// })
    
    local v_version=${last_tag_split[-1]}
    local version=${v_version:1}

    local tmp_new_tag="$(printf "/%s" "${last_tag_split[@]::${#last_tag_split[@]}-1}")/v$(increment_version ${version})"
    local new_tag=${tmp_new_tag:1}

    echo -e "# Run:\ngh release "${pkg}/${new_tag}" --generate-notes"
}

release "${1}"