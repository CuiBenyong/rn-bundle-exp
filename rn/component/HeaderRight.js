'use strict';

import React, { Component } from 'react';
import {
  TouchableOpacity,
  Text,
  StyleSheet,
  Image,
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
  text: {
    backgroundColor: '#fefefe',
    textAlign: 'center',
    fontSize: 14,
    color: '#333',
  },
  image: {
    width: 21,
    height: 21,
  },
});
/**
 * @name EZNavigatorHeaderRight（路由导航右侧按钮）
 * @description 该组件是页面的导航栏右侧按钮的形态，通常用在页面组件的navigationOptions配置项中
 * @demo
 SomePageComp.navigationOptions = ({ navigation }) => ({
  title: '标题',
  headerRight: <EZNavigatorHeaderRight
    text="保存"
    onPress={() => {
      // todo
    }}
  />,
  });
 */
export default class HeaderRight extends Component {
  render() {
    let {
      onPress,
      text,
      textStyle,
      type,
    } = this.props;
    return (
      <TouchableOpacity
        style={styles.touchable}
        onPress={() => onPress && onPress()}>
        {
          type === 'setting' ?
            <Image
              style={styles.image}
              source={require('./imgs/setIcon.png')}/>
            :
            <Text
              style={[styles.text, textStyle]}
            >{text}</Text>
        }
      </TouchableOpacity>
    )
  }
}
HeaderRight.propTypes = {
  /**
   * 右侧按钮的图标类型 默认：无；'setting'：齿轮设置图标，
   */
  type: PropTypes.string,
  /**
   * 右侧文字，只有无图标的时候显示
   */
  text: PropTypes.string,
  /**
   * 右侧文字样式
   */
  textStyle: PropTypes.oneOfType([PropTypes.shape({}), PropTypes.number]),
  /**
   * 点击事件
   */
  onPress: PropTypes.func,
};

HeaderRight.defaultProps = {
  type: '',
  text: '',
  textStyle: {},
  onPress: () => {},
};
