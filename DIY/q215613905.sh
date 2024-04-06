#!/bin/bash
#添加PY支持
cp -rf $GITHUB_WORKSPACE/DIY/png/图标9-1.png app/src/main/res/drawable/app_banner.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标9.png app/src/main/res/drawable-hdpi/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标9.png app/src/main/res/drawable-xhdpi/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标9.png app/src/main/res/drawable-xxhdpi/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标9.png app/src/main/res/drawable-xxxhdpi/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/qbox/config.xml app/src/main/res/values/config.xml
cp -rf $GITHUB_WORKSPACE/DIY/qbox/epg_data.json app/src/main/assets/epg_data.json
cp -rf $GITHUB_WORKSPACE/DIY/qbox/QBOXdialog_about.xml app/src/main/res/layout/dialog_about.xml
cp -rf $GITHUB_WORKSPACE/DIY/png/app_bg.png app/src/main/res/drawable/app_bg.png
sed -i 's%播放器 % %g' app/src/main/java/com/github/tvbox/osc/util/PlayerHelper.java
sed -i 's%android:layout_width="@dimen%vs_560"%g'  app/src/main/res/values/dimens.xml 
sed -i 's%6000%5000%g'  app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java
sed -i 's%380+200*spanCount%680+600*spanCount%g'  app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's%spanCount+1%spanCount%g'  app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's%com.github.tvbox.osc%com.github.tvbox.osc.${{ matrix.osName }}%g' app/build.gradle
sed -i 's%TVBox%大师影视%g' app/src/main/res/values/strings.xml
sed -i 's%(HawkConfig.API_URL, "");%(HawkConfig.API_URL, "https://agit.ai/wwz09/ubuntu/raw/branch/master/main.json");%g' app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java   
sed -i 's%Hawk.put(HawkConfig.PLAY_TYPE, 1);%Hawk.put(HawkConfig.HOME_REC, 0);       // Home Rec 0=豆瓣, 1=推荐, 2=历史\n Hawk.put(HawkConfig.PLAY_TYPE, 1);      // Player   0=系统, 1=IJK, 2=Exo\n Hawk.put(HawkConfig.IJK_CODEC, "硬解码"); // IJK Render 软解码, 硬解码\n%g' app/src/main/java/com/github/tvbox/osc/base/App.java

echo 'DIY end'