import React, { Component } from 'react';
import {
  KeyboardAvoidingView, Text, TouchableOpacity
} from 'react-native';
import { connect } from 'react-redux';
import { startPage } from '../../../../utils/fn';
import styles from './styles';


class Tab1 extends Component {
  constructor(props) {
    super(props);
  }




  componentDidMount() {

  }


  componentWillUnmount() {

  }



  render() {


    return <KeyboardAvoidingView behavior={'height'} enabled={true} keyboardVerticalOffset={0} style={styles.container}>

      <Text>我是Tab1</Text>

      <TouchableOpacity
        onPress={() => {
          startPage('Setting', 'Index', {})
        }}
        style={{ marginTop: 20 }}
      >
        <Text>进入设置页面</Text>
      </TouchableOpacity>

    </KeyboardAvoidingView>;
  }
}

Tab1.navigationOptions = ({ navigation }) => {
  return ({
    headerShown: false,
  });
};

export default connect(state => ({


}), dispatch => ({


}))(Tab1);
