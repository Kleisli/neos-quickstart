#!/bin/sh

PROJECT_NAME=$(echo "$1" | awk '{print tolower($0)}')
NEOS_PACKAGE_NAME="$1.Site"
COMPOSER_PACKAGE_NAME="$PROJECT_NAME/site"

echo "Rename Quickstart.Site to ${NEOS_PACKAGE_NAME}"

find ./.ddev -type f -name 'config.yaml' | xargs sed -i "s/quickstart/${PROJECT_NAME}/g"
ddev add-on get ddev/ddev-pnpm
ddev start
ddev flow cr:setup --content-repository default
ddev flow package:adopt Quickstart.Site ${NEOS_PACKAGE_NAME}
ddev composer require ${COMPOSER_PACKAGE_NAME}
ddev composer remove 'quickstart/site'
ddev flow neos.flow:package:rescan
find . -type f -name 'pipeline.yaml' | xargs sed -i "s/Quickstart\.Site/${NEOS_PACKAGE_NAME}/g"
ddev composer reinstall carbon/pipeline
ddev flow site:create ${PROJECT_NAME} ${NEOS_PACKAGE_NAME} ${NEOS_PACKAGE_NAME}:Document.Page
echo "Configure admin user"
ddev flow user:create --roles Administrator
ddev describe
