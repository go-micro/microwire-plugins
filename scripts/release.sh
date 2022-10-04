#!/bin/bash

######################################################################################
# $ release.sh broker/http                                                           #
#                                                                                    #
# Release a plugin                                                                   #
#                                                                                    #
######################################################################################

function increment_minor_version ()
{
    declare -a part=( ${1//\./ } )
    part[2]=0
    part[1]=$((part[1] + 1))
    new="${part[*]}"
    echo -e "${new// /.}"
}

function increment_patch_version ()
{
    declare -a part=( ${1//\./ } )
    part[2]=$((part[2] + 1))
    new="${part[*]}"
    echo -e "${new// /.}"
}

function release() {
    if [[ ! -f "${1}/go.mod" ]]; then
        echo "Unknown package '${1}' given."
        exit 1
    fi

    local pkg="${1}"
    local last_tag=$(git tag --list --sort='-creatordate' "${pkg}/*"  | head -n1)
    if [[ "${last_tag}" == "" ]]; then
        echo -e "# No previous tag\n# Run:\ngh release create "${pkg}/v5.0.0" -n 'Initial release'"
        exit 0
    fi

    echo "# last_tag: ${last_tag}"
    local changes="$(git --no-pager log "${last_tag}..HEAD" --format="%s" "${pkg}")"
    if [[ "${#changes}" == "0" ]]; then
        echo "# No changes detected"
        exit 1
    fi

    declare -a last_tag_split=(${last_tag//\// })
    
    local v_version=${last_tag_split[-1]}
    local version=${v_version:1}
    # Remove the version from last_tag_split
    unset last_tag_split[-1]

    git --no-pager log "${last_tag}..HEAD" --format="%h" --grep="^feat" "${pkg}/*" 1>/dev/null
    if [[ "$?" == "0" ]]; then
        local tmp_new_tag="$(printf "/%s" "${last_tag_split[@]}")/v$(increment_minor_version ${version})"
        local new_tag=${tmp_new_tag:1}
    else
        local tmp_new_tag="$(printf "/%s" "${last_tag_split[@]}")/v$(increment_patch_version ${version})"
        local new_tag=${tmp_new_tag:1}
    fi

    echo -e "# Run:\ngh release create "${new_tag}" --generate-notes --notes-start-tag ${last_tag}"
}

release "${1}"