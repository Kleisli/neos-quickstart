# Todo
- Script to rename everything
- ./rename.sh MyProject
see https://github.com/code-q-web-factory/Neos-Skeleton/blob/master/docs/GETTING_STARTED.md
- https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script
- echo "MyProject" | awk '{print tolower($0)}'


# setup.sh
1. rename
2. ```ddev start```
3. ```ddev flow site:create myproject MyProject.Site MyProject.Site:Document.HomePage```
4. ```ddev flow site:list```
5. ```ddev flow user:create --roles Administrator```
6. ```ddev flow user:list```


# Setup 
0. ```./setup.sh MyProject```

## Frontend development
1. ```ddev npm install```
2. ```ddev npm run build``` bzw. ```bash ddev npm start``` 
