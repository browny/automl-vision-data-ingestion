#!/bin/bash

$GCLOUD auth activate-service-account --key-file=/opt/key.json
formats=(jpg jpeg png webp gif bmp tiff ico)
DES_STORAGE_DIR=$1
echo Working dir: `pwd`

# === Rename files to ordered number ===
for dir in ./*/
do
  dir=${dir%*/}
  cd ${dir##*/}
  echo Current dir: `pwd`

  i=0
  for file in $(ls | sort -n); do
    extension="${file##*.}"
    if [[ ${formats[*]} =~ "$extension" ]]
    then
      mv "$file" "$i.$extension"
    else
      echo Delete not supported format: $file
      rm -rf $file
	fi
    ((i++))
  done

  cd ..
  echo Current dir: `pwd`
done

# === Upload files to Cloud Storage ===
# clean destination directory first
$GSUTIL -m rm -f -r $DES_STORAGE_DIR
$GSUTIL -m cp -r `pwd` $DES_STORAGE_DIR
# remove unnecessary files
$GSUTIL -m rm -r $DES_STORAGE_DIR/**/.DS_Store

# === Build csv index file ===
$GSUTIL ls -r $DES_STORAGE_DIR/** | while read -r line ; do
  label="$(echo $line | awk -F/ '{print $(NF-1)}')"
  echo "Processing: $line,$label"
  echo "$line,$label"  >> /tmp/index.csv
done
$GSUTIL cp /tmp/index.csv $DES_STORAGE_DIR
