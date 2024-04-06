#!/bin/bash
#添加PY支持
cp -rf $GITHUB_WORKSPACE/DIY/png/图标6-1.png app/src/main/res/drawable/app_banner.png
cp -rf $GITHUB_WORKSPACE/DIY/png/app_bg.png app/src/main/res/drawable/app_bg.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标6.png app/src/main/res/drawable-hdpi/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标6.png app/src/main/res/drawable-xhdpi/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标6.png app/src/main/res/drawable-xxhdpi/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标6.png app/src/main/res/drawable-xxxhdpi/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/png/等待图标.png app/src/main/res/drawable/icon_loading.png
cp -rf $GITHUB_WORKSPACE/DIY/png/等待图标.png app/src/main/res/drawable-xhdpi/icon_loading.png
cp -rf $GITHUB_WORKSPACE/DIY/App.java app/src/main/java/com/github/tvbox/osc/bbox/base/App.java
cp -rf $GITHUB_WORKSPACE/DIY/ModelSettingFragment.java app/src/main/java/com/github/tvbox/osc/bbox/ui/fragment/ModelSettingFragment.java
cp -rf $GITHUB_WORKSPACE/DIY/StoreApiConfig.java app/src/main/java/com/github/tvbox/osc/bbox/api/StoreApiConfig.java
cp -rf $GITHUB_WORKSPACE/DIY/qbox/epg_data.json app/src/main/assets/epg_data.json
sed -i 's%com.github.tvbox.osc.tk%com.github.tvbox.osc.${{ matrix.osName }}%g' app/build.gradle
sed -i 's%玉幂草%酷影视%g' app/src/main/res/values/strings.xml

echo 'DIY end'