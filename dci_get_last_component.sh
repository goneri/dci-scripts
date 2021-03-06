#!/bin/bash

if [ -z $1 ]; then
    echo "Usag: $0 topic_name"
    exit 1
fi
topic_name=$1
topic_id=$(dcictl --format json topic-list --where name:OSP12|jq -r '.topics[0].id')
component_id=$(dcictl --format json component-list --topic-id e33fe610-f7ac-4bb5-9c37-423b3ffdd245 --limit 1|jq -r .components[0].id)
component_name=$(dcictl --format json component-list --topic-id e33fe610-f7ac-4bb5-9c37-423b3ffdd245 --limit 1|jq -r .components[0].name|sed 's, ,_,g')
component_file_id=$(dcictl --format json component-file-list $component_id|jq -r .component_files[0].id)
target="~/tmp/dci/${component_name}.tar"
dir=$(dirname $(echo $target))

echo "topic_id $topic_id"
echo "component_name $component_name"
echo "component_id $component_id"
echo "component_file_id $component_file_id"

[ -d ${dir} ] || mkdir -p ${dir}
echo "Downloading ${target}"
dcictl component-file-download $component_id --file-id $component_file_id --target ${target}
#tar tf ~/tmp/toto.tar|grep container_images.yaml
