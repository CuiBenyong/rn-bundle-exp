'use strict';

import React, { Component } from 'react';
import {
  View,
  Image,
  Text,
  TouchableOpacity,
  StyleSheet
} from 'react-native';
import PropTypes from "prop-types";

const styles = StyleSheet.create({
  touchable: {
    height: 44,
    justifyContent: 'center',
    alignItems: 'center',
    paddingLeft: 16,
    paddingRight: 16,
  },

  arrow: {
    width: 9,
    height: 16
  },

  close: {
    width: 15,
    height: 15
  }
});

const closeIcon = require('./imgs/header_close.png');
const arrowIcon = require('./imgs/wihte_back.png');

/**
 * @name EZNavigatorHeaderLeft（路由导航左侧按钮）
 * @description 该组件是页面的导航栏左侧按钮的形态，通常用在页面组件的navigationOptions配置项中
 * @demo
 SomePageComp.navigationOptions = ({ navigation }) => ({
  title: '标题',
  headerLeft: <EZNavigatorHeaderLeft
    onPress={() => {
      navigation.goBack();
    }}
  />,
  });
 */
export default class HeaderLeft extends Component {
  render() {
    let {
      onPress,
      type,
    } = this.props;
    onPress = onPress || (() => {});
    return (
      <View>
        <TouchableOpacity accessibilityLabel="rn_back" style={styles.touchable}  activeOpacity={0.6} onPress={onPress}>
          {
            type === 'close'
              ? <Image style={styles.close} source={closeIcon} />
              : <Image style={styles.arrow} source={arrowIcon} />
          }
        </TouchableOpacity>
      </View>
    )
  }
}
HeaderLeft.propTypes = {
  /**
   * 左侧按钮的图标类型 默认：向左箭头；'close'：叉叉
   */
  type: PropTypes.string,
  /**
   * 点击事件
   */
  onPress: PropTypes.func,
};

HeaderLeft.defaultProps = {
  type: '',
  onPress: () => {},
};
