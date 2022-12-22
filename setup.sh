#!/bin/sh

if [ ! -d "DistributionPackages/Quickstart.Site" ]; then
  echo "Directory DistributionPackages/Quickstart.Site does not exist, exiting setup"
  exit 0
fi

PROJECT_NAME=$(echo "$1" | awk '{print tolower($0)}')
NEOS_PACKAGE_NAME="$1.Site"
COMPOSER_PACKAGE_NAME="$PROJECT_NAME\/site"

mv DistributionPackages/Quickstart.Site DistributionPackages/${NEOS_PACKAGE_NAME}

# OS X / BSD:
# find ./.ddev -type f -name 'config.yaml' | xargs sed -i '' "s/quickstart/${PROJECT_NAME}/g"
# find . -type f -name 'composer.json' | xargs sed -i '' "s/quickstart\/site/${COMPOSER_PACKAGE_NAME}/g"
# find . -type f ! -name 'setup.sh' | xargs sed -i '' "s/Quickstart\.Site/${NEOS_PACKAGE_NAME}/g"
# find . -type f ! -name 'setup.sh' | xargs sed -i '' "s/Quickstart/${1}/g"
# Linux / GNU:
find ./.ddev -type f -name 'config.yaml' | xargs sed -i "s/quickstart/${PROJECT_NAME}/g"
find . -type f -name 'composer.json' | xargs sed -i "s/quickstart\/site/${COMPOSER_PACKAGE_NAME}/g"
find . -type f ! -name 'setup.sh' | xargs sed -i "s/Quickstart\.Site/${NEOS_PACKAGE_NAME}/g"
find . -type f ! -name 'setup.sh' | xargs sed -i "s/Quickstart/${1}/g"

ddev start
ddev flow site:create ${PROJECT_NAME} ${NEOS_PACKAGE_NAME} ${NEOS_PACKAGE_NAME}:Document.HomePage
echo "Configure admin user"
ddev flow user:create --roles Administrator
ddev describe
