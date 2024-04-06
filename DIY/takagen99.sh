#!/bin/bash
#添加PY支持
cp -rf $GITHUB_WORKSPACE/DIY/png/图标7-1.png app/src/main/res/drawable/app_banner.png
cp -rf $GITHUB_WORKSPACE/DIY/png/图标7.png app/src/main/res/drawable/app_icon.png
cp -rf $GITHUB_WORKSPACE/DIY/png/等待图标.png app/src/main/res/drawable/icon_loading.png
cp -rf $GITHUB_WORKSPACE/DIY/qbox/epg_data.json app/src/main/assets/epg_data.json
sed -i 's%TVBox%大仙TV%g' app/src/main/res/values-zh/strings.xml 
sed -i 's%app_source">%app_source">https://agit.ai/wwz09/ubuntu/raw/branch/master/main.json%g' app/src/main/res/values-zh/strings.xml
sed -i 's%app_source">%app_source">https://agit.ai/wwz09/ubuntu/raw/branch/master/main.json%g' app/src/main/res/values/strings.xml
sed -i 's%com.github.tvbox.osc.tk%com.github.tvbox.osc.${{ matrix.osName }}%g' app/build.gradle
sed -i 's%HOME_REC, 2%HOME_REC, 0%g' app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i 's%putDefault(HawkConfig.SEARCH_VIEW, 2);    // Text or Picture%putDefault(HawkConfig.SEARCH_VIEW, 2);    // 文字或图片\n      putDefault(HawkConfig.HOME_SHOW_SOURCE, true);    // 显示首页源\n%g' app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i 's%HomeActivity.getRes().getString(R.string.app_source));% "https://agit.ai/wwz09/ubuntu/raw/branch/master/main.json");%g' app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java     

echo 'DIY end'