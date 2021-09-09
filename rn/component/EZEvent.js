/**
 * @Author: yangshuang3
 * @Date:   2018-10-15T15:05:03+08:00
 * @Last modified by:   yangshuang3
 * @Last modified time: 2018-12-20T15:58:57+08:00
 */

'use strict';

import EventEmitter from 'eventemitter3';

class EZEvent extends EventEmitter {
  addListener(emitter, rootTag, fn) {
    super.addListener(`${emitter}-${rootTag}`, fn);
  }

  removeListener(emitter, rootTag, fn) {
    super.removeListener(`${emitter}-${rootTag}`, fn);
  }

  emit(emitter, rootTag, data) {
    super.emit(`${emitter}-${rootTag}`, data);
  }
}

module.exports = new EZEvent();
