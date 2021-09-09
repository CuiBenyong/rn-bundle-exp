function getAssetData(assetData){
    const { httpServerLocation } = assetData;
    const config = {
        ...assetData,
        httpServerLocation: "/"+ process.env.buildFolder  + httpServerLocation
    }

    console.log(">>>>>>>>>>",process.env.buildFolder, config.httpServerLocation)
    return config;
}

module.exports = getAssetData;
