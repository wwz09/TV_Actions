#!/bin/bash
#添加PY支持
       cp -rf $GITHUB_WORKSPACE/DIY/png/图标5-1.png app/src/main/res/drawable/app_banner.png
       cp -rf $GITHUB_WORKSPACE/DIY/png/图标5.png app/src/main/res/drawable-hdpi/app_icon.png
       cp -rf $GITHUB_WORKSPACE/DIY/png/图标5.png app/src/main/res/drawable-xhdpi/app_icon.png
       cp -rf $GITHUB_WORKSPACE/DIY/png/图标5.png app/src/main/res/drawable-xxhdpi/app_icon.png
       cp -rf $GITHUB_WORKSPACE/DIY/png/图标5.png app/src/main/res/drawable-xxxhdpi/app_icon.png
       cp -rf $GITHUB_WORKSPACE/DIY/qbox/config.xml app/src/main/res/values/config.xml
       cp -rf $GITHUB_WORKSPACE/DIY/png/app_bg.png app/src/main/res/drawable/app_bg.png  
       sed -i 's%com.github.tvbox.osc%com.github.tvbox.osc.${{ matrix.osName }}%g' app/build.gradle
       sed -i 's%TVBox%源源影视%g' app/src/main/res/values/strings.xml
       sed -i 's%TVBox%源源影视%g' app/src/main/res/values-zh/strings.xml 
       sed -i 's%Hawk.put(HawkConfig.PLAY_TYPE, 1);%Hawk.put(HawkConfig.HOME_REC, 0);       // Home Rec 0=豆瓣, 1=推荐, 2=历史\n Hawk.put(HawkConfig.PLAY_TYPE, 1);      // Player   0=系统, 1=IJK, 2=Exo\n Hawk.put(HawkConfig.IJK_CODEC, "硬解码"); // IJK Render 软解码, 硬解码\n%g' app/src/main/java/com/github/tvbox/osc/base/App.java
echo 'DIY end'