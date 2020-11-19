#!/bin/bash

# 初始化记录项目pwd
projectDir=`pwd`

# step 1 clean
echo 'clean old build'
find . -depth -name "build" | xargs rm -rf
cd ${projectDir} # 回到项目
rm -rf .android/Flutter/build
#flutter clean

# step 2 package get
echo 'packages get'
cd ${projectDir} # 回到项目
flutter packages get

# step 3 build aar，生成aar,然后上传到对应maven仓库
echo 'build aar'
cd ${projectDir}
flutter build apk
if [ $? -eq 0 ]; then
    echo '打包成aar 成功！'
else
    echo '打包成aar 失败！'
    exit 1
fi

cd ${projectDir}/.android
./gradlew flutter:uploadArchives

if [ $? -eq 0 ]; then
    echo 'uploadArchives 成功！'
else
    echo 'uploadArchives 失败！'
    exit 1
fi

echo '<<<<<<<<<<<<<<<<<<<<<<<<<< 打包成功,aar上传成功 >>>>>>>>>>>>>>>>>>>>>>>>>'
echo "打包成功 : flutter-release.aar, 本地仓库:${projectDir}/repo-local"
exit
