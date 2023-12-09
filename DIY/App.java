package com.github.tvbox.osc.bbox.base;

import android.app.Activity;
import android.widget.Toast;
import androidx.multidex.MultiDexApplication;
import com.github.tvbox.osc.bbox.bean.VodInfo;
import com.github.tvbox.osc.bbox.callback.EmptyCallback;
import com.github.tvbox.osc.bbox.callback.LoadingCallback;
import com.github.tvbox.osc.bbox.data.AppDataManager;
import com.github.tvbox.osc.bbox.server.ControlManager;
import com.github.tvbox.osc.bbox.util.*;
import com.github.tvbox.osc.bbox.util.js.JSEngine;
import com.kingja.loadsir.core.LoadSir;
import com.orhanobut.hawk.Hawk;
import com.p2p.P2PClass;
import com.xuexiang.xupdate.XUpdate;
import com.xuexiang.xupdate.entity.UpdateError;
import com.xuexiang.xupdate.listener.OnUpdateFailureListener;
import com.xuexiang.xupdate.utils.UpdateUtils;
import me.jessyan.autosize.AutoSizeConfig;
import me.jessyan.autosize.unit.Subunits;

import java.util.ArrayList;
import java.util.HashMap;

import static com.xuexiang.xupdate.entity.UpdateError.ERROR.CHECK_NO_NEW_VERSION;

/**
 * @author pj567
 * @date :2020/12/17
 * @description:
 */
public class App extends MultiDexApplication {
    // ^(?!.*(HWComposer|TrafficController|lowmemorykiller)).*$

    private static App instance;

    private static P2PClass p;
    public static String burl;

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        initParams();
        // OKGo
        OkGoHelper.init(); // 台标获取
        EpgUtil.init();
        // 初始化Web服务器
        ControlManager.init(this);
        // 初始化数据库
        AppDataManager.init();
        LoadSir.beginBuilder()
                .addCallback(new EmptyCallback())
                .addCallback(new LoadingCallback())
                .commit();
        AutoSizeConfig.getInstance().setCustomFragment(true).getUnitsManager()
                .setSupportDP(false)
                .setSupportSP(false)
                .setSupportSubunits(Subunits.MM);
        PlayerHelper.init();
        JSEngine.getInstance().create();
        FileUtils.cleanPlayerCache();
        initXUpdate();
    }

    private void initXUpdate() {
        XUpdate.get()
            .debug(true)
            // 默认设置只在wifi下检查版本更新
            .isWifiOnly(false)
            // 默认设置使用get请求检查版本
            .isGet(true)
            // 默认设置非自动模式，可根据具体使用配置
            .isAutoMode(false)
            // 设置默认公共请求参数
            .param("versionCode", UpdateUtils.getVersionCode(this))
            .param("appKey", getPackageName())
            // 设置版本更新出错的监听
            .setOnUpdateFailureListener(new OnUpdateFailureListener() {
                @Override
                public void onFailure(UpdateError error) {
                    error.printStackTrace();
                    // 对不同错误进行处理
                    if (error.getCode() != CHECK_NO_NEW_VERSION) {
                        Toast.makeText(getApplicationContext(), error.toString(), Toast.LENGTH_SHORT).show();
                    }
                }
            })
            // 设置是否支持静默安装，默认是true
            .supportSilentInstall(false)
            // 这个必须设置！实现网络请求功能。
            // .setIUpdateHttpService(new OkGoUpdateHttpService())
            // 这个必须初始化
            .init(this);
    }

    private void initParams() {
        // Hawk
        Hawk.init(this).build();

        // 默认线路地址
        String defaultApiName = "main";
        String defaultApi = "https://agit.ai/wwz09/ubuntu/raw/branch/master/main.json";
        // 默认仓库地址
        // String defaultStoreApi = "https://raw.staticdn.net/mlabalabala/TVResource/main/boxCfg/ori_source.json";
        // String defaultStoreApi = "https://raw.gitmirror.com/mlabalabala/TVResource/main/boxCfg/ori_source.json";
        // String defaultStoreApi = "https://ghproxy.com/https://raw.githubusercontent.com//mlabalabala/TVResource/main/boxCfg/ori_source.json";
        // String defaultStoreApi = "https://raw.githubusercontent.com/mlabalabala/TVResource/main/boxCfg/ori_source.json";
        String defaultStoreApi = "https://agit.ai/wwz09/ubuntu/raw/branch/master/TXT/dc.json";

        HashMap<String, String> defaultApiMap = Hawk.get(HawkConfig.API_MAP, new HashMap<>());
        defaultApiMap.put(defaultApiName, defaultApi);

        ArrayList<String> defaultApiHistory = Hawk.get(HawkConfig.API_NAME_HISTORY, new ArrayList<>());
        defaultApiHistory.add(defaultApiName);

        Hawk.put(HawkConfig.DEBUG_OPEN, false);

        // 不添加默认线路
        putDefault(HawkConfig.API_URL, defaultApi);
        putDefault(HawkConfig.API_NAME, defaultApiName);
        // putDefault(HawkConfig.API_NAME_HISTORY, defaultApiHistory);
        // putDefault(HawkConfig.API_MAP, defaultApiMap);

        putDefault(HawkConfig.DEFAULT_STORE_API, defaultStoreApi);
        putDefault(HawkConfig.PLAY_TYPE, 1);
        putDefault(HawkConfig.HOME_REC, 1);
        // 默认渲染方式：推荐手机使用0-texture，电视1-surface
        putDefault(HawkConfig.PLAY_RENDER, 1);
        putDefault(HawkConfig.IJK_CODEC, "硬解码");
        putDefault(HawkConfig.HOME_REC_STYLE, false);// 首页多行
    }

    private void putDefault(String key, Object value) {
        if (!Hawk.contains(key)) {
            Hawk.put(key, value);
        }
    }

    public static App getInstance() {
        return instance;
    }

    @Override
    public void onTerminate() {
        super.onTerminate();
        JSEngine.getInstance().destroy();
    }

    public static P2PClass getp2p() {
        try {
            if (p == null) {
                p = new P2PClass(instance.getExternalCacheDir().getAbsolutePath());
            }
            return p;
        } catch (Exception e) {
            LOG.e(e.toString());
            return null;
        }
    }

    private VodInfo vodInfo;

    public void setVodInfo(VodInfo vodinfo) {
        this.vodInfo = vodinfo;
    }

    public VodInfo getVodInfo() {
        return this.vodInfo;
    }

    public Activity getCurrentActivity() {
        return AppManager.getInstance().currentActivity();
    }
}
