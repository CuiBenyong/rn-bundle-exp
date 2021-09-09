import React, { Component } from 'react';
import { NativeModules, ScrollView, Text, TouchableOpacity, View } from 'react-native';
import { connect } from "react-redux";
import { startPage } from "../../../../utils/fn";
import { checkRNbundles } from '../../../../utils/hotupdate';
import styles from "./styles";

class Index extends Component {
  constructor(props) {
    super(props);
  }

  renderItem(title, onPress) {
    return <TouchableOpacity activeOpacity={0.9} onPress={onPress} style={styles.item}>
      <Text style={styles.title}>{title}</Text>
    </TouchableOpacity>
  }



  render() {
    return (
      <ScrollView style={styles.container}>
        <View style={styles.content}>

          {
            this.renderItem('清除缓存', () => {
              NativeModules.RNBridge.clearCache()
            })
          }
          <View style={styles.line} />

          {
            this.renderItem('用户协议', () => {

            })
          }
          <View style={styles.line} />

          {
            this.renderItem('修改手机绑定', () => {
              startPage('Mine', 'EditMobile', {})
            })
          }


          <View style={styles.line} />
          {
            this.renderItem('热更新', () => {
              checkRNbundles(() => { });
            })
          }

        </View>

      </ScrollView>
    );
  }
}


Index.navigationOptions = ({ navigation }) => {
  return ({
    title: '设置',
  });
};


export default connect(state => ({
}), dispatch => ({

}))(Index);


