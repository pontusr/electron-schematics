set -e
set -v

# build & pack the packages
npm run build

cd packages/schematics
npm version 0.0.1 -git-tag-version false
npm pack

cd ../build-electron
npm version 0.0.1 -git-tag-version false
npm pack

npm i @angular/cli -g

# install packages & generate electron project
cd ../../e2e
npm i ../packages/schematics/electron-schematics-schematics-0.0.1.tgz
ng g @electron-schematics/schematics:electron
npm i ../packages/build-electron/electron-schematics-build-electron-0.0.1.tgz

# run the app with auto exit
mv --force 'main.ts' 'projects/electron/main.ts'
ng serve electron

# check if log file exists
# if [[ ! -f e2e.log ]] ; then
#     exit 1
# fi

# try to build the app
rm -r ./dist
ng build electron

# read -p "Press enter to continue"