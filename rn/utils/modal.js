import React from 'react';
import {DeviceEventEmitter, NativeModules, Platform} from 'react-native';


export default {
    set(element, cid, callback) {
        const id = Date.now();
        DeviceEventEmitter.emit('setElement', cid || id, element, callback);
        if (Platform.OS === 'ios'){
                NativeModules.RNBridge.setPanGesture(false)
        }
        return cid || id;
    },

    remove(id, callback) {
        if (Platform.OS === 'ios'){
            NativeModules.RNBridge.setPanGesture(true)
        }
        DeviceEventEmitter.emit('removeElement', id, callback);
    },

    addVideo(element, cid, callback) {
        const id = Date.now();
        DeviceEventEmitter.emit('setVideo', cid || id, element, callback);
        return cid || id;
    },

    removeVideo(id, callback) {
        DeviceEventEmitter.emit('removeVideo', id, callback);
    },

};
