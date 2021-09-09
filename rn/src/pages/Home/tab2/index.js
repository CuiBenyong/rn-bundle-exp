import React, { Component } from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import { connect } from 'react-redux';
import { startPage } from '../../../../utils/fn';
import styles from "./styles";

class Tab2 extends Component {

  constructor(props) {
    super(props);
  }

  componentDidMount() {

  }

  render() {

    return <View style={styles.container}>
      <Text>我是Tab2</Text>


      <TouchableOpacity
        onPress={() => {
          startPage('Setting', 'WebView', { uri: 'https://iot.tuya.com', title: '默认标题' })
        }}
        style={{ marginTop: 20 }}
      >
        <Text>打开一个网页</Text>
      </TouchableOpacity>
    </View>
  }
}

Tab2.navigationOptions = ({ navigation }) => {
  return ({
    headerShown: false
  });
};


export default connect(state => ({
}), dispatch => ({
}))(Tab2);
