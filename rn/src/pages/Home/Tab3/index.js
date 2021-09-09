import React, { Component } from 'react';
import { View, Text, TouchableOpacity} from 'react-native';
import { connect } from 'react-redux';
import { checkRNbundles } from '../../../../utils/hotupdate';
import styles from './styles';


class Tab3 extends Component {

  constructor(props) {
    super(props);

  }


  componentDidMount() {

  }

  render() {

    return <View style={styles.container}>

        <Text>我是Tab3</Text>
       
       
        <TouchableOpacity
        onPress={() => {
            checkRNbundles(()=>{
              
            })
        }}
        style={{ marginTop: 20 }}
      >
        <Text>热更新一下</Text>
      </TouchableOpacity>
    </View>
  }
}

Tab3.navigationOptions = ({ navigation }) => {
  return ({
    headerShown: false
  });
};


export default connect(state => ({}), dispatch => ({}))(Tab3);
