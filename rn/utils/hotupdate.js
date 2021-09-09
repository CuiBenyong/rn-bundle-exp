import {NativeModules, Platform} from "react-native";
import {dismissLoading, showLoading, showToast} from "./fn";
import {CHECK_RNBUNDLE_UPDATE} from "./const";
import RNFS from "react-native-fs";
import {unzip} from "react-native-zip-archive";

var dataLength = 0;
var doneCount = 0;
export async function checkRNbundles(callback) {

    const bundles = await NativeModules.RNBridge.getBundleVersions();
    if (!!bundles) {
        const list = bundles.map(obj=>{
            console.log(obj)
            const { version, bundleName } = obj;
            const subversion = version.split("-")[1];
            return {
                bundleName,
                subversion
            }
        })
        showLoading('正在检测更新')
        let formdata = new FormData();
        formdata.append('bundles', JSON.stringify(list));
        formdata.append('platform', Platform.OS);

        fetch(CHECK_RNBUNDLE_UPDATE, {
            method: 'POST',
            headers: {

            },
            body: formdata,
        }).then(res => res.json())
            .then(response => {
                console.log(response);
                callback(response);

                const {data, host} = response;
                if(data.length > 0){
                    showToast(`发现${data.length}个更新包`)
                    showLoading(`正在下载1/${data.length}个更新包`)
                }else{
                    showToast(`所有业务包已是最新`)
                    dismissLoading();
                }
                dataLength = data.length;
                data.map(item => {
                    const {url, bundle_name} = item;
                    downloadZip(host, url, bundle_name);
                });

            }).catch(error => {
            console.log(error);
            callback(false);
            dismissLoading();

        });
    }

}


async function downloadZip(host, url, bundle_name) {

    const progress = data => {
        const percentage = ((100 * data.bytesWritten) / data.contentLength) | 0;
        const text = `Progress ${percentage}%`;
        console.log(text);
    };
    const begin = res => {
        console.log('Download has begun');
    };
    const progressDivider = 1;
    const filePath = RNFS.TemporaryDirectoryPath + '/RNDownload/';
    const exists = await RNFS.exists(filePath);
    if (!exists) {
        await RNFS.mkdir(filePath);

    }
    const downloadDestName = RNFS.TemporaryDirectoryPath + '/RNDownload/' + bundle_name + '.zip';
    const unZipPath = RNFS.DocumentDirectoryPath + '/RNBundles/';

    const ret = RNFS.downloadFile({
        fromUrl: host + url,
        toFile: downloadDestName,
        begin,
        progress,
        cacheable: false,
        progressDivider,
    });

    const jobId = ret.jobId;

    ret.promise.then(res => {
        console.log('file download ');
        console.log(downloadDestName);
        console.log(res);

        // 调用解压函数
        unzip(downloadDestName, unZipPath, 'UTF-8').then(path => {
            console.log(path);
            doneCount+=1;
            showLoading(`正在下载第${doneCount}/${dataLength}个业务包`)
            if(doneCount === dataLength){
                dismissLoading();
                showToast("所有业务包已是最新")
                doneCount = 0;
                dataLength = 0;
            }
            RNFS.unlink(downloadDestName);
        }).catch(error => {
            RNFS.exists(downloadDestName).then(result => {
                console.log('文件', downloadDestName, result);
            });
            console.log(error);
        })


    }).catch(err => {
        console.log(err)
    });
}
