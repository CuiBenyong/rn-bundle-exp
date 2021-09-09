import React, { Component } from 'react';
import { View, Text } from 'react-native';
import { TouchableOpacity } from 'react-native-gesture-handler';
import { connect } from 'react-redux';
import { startPage } from '../../../../utils/fn';


class Home extends Component {
  constructor(props) {
    super(props);

  }

  componentDidMount() {

  }

  componentWillUnmount() {

  }



  render() {
    return (
      <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>

        <Text>我是首页</Text>
        <Text>我是首页</Text>
        <Text>我是首页</Text>
        <Text>我是首页</Text>
        <Text>我是首页</Text>
        <Text>我是首页</Text>
        <Text>我是首页</Text>
        <Text>我是首页</Text>
        <Text>我是首页</Text>
        
      <TouchableOpacity
        onPress={()=>{
          startPage('Mine','Index',{})
        }}
        style={{marginTop: 20}}
      >
        <Text>进入我的页面</Text>
      </TouchableOpacity>
      </View>
    );

  }
}

Home.navigationOptions = ({ navigation }) => {
  const { state: { params } } = navigation;
  return ({
    headerShown: false,
  });
};


export default connect(({ }) => ({}), dispatch => ({}))(Home);
