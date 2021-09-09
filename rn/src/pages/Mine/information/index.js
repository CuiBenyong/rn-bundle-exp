import React, { Component } from 'react';
import { ScrollView, Text, TouchableOpacity, View } from 'react-native';
import { connect } from "react-redux";
import styles from "../../Setting/main/styles";

class UserInformation extends Component {
  constructor(props) {
    super(props);
  }
  renderItem(title, onPress, value) {
    return <TouchableOpacity activeOpacity={0.9} onPress={onPress} style={styles.item}>
      <Text style={styles.title}>{title}</Text>
      <Text style={styles.value}>{value}</Text>
      <View
        style={styles.rightArrow}
      />
    </TouchableOpacity>
  }

  render() {
    return (
      <ScrollView style={styles.container}>
        <View style={styles.content}>
        <Text>啥也不是88888888</Text>
        <Text>啥也不是88888888</Text>
        <Text>啥也不是88888888</Text>
        <Text>啥也不是88888888</Text>
        <TouchableOpacity style={{marginTop: 20}} onPress={()=>{
          this.props.navigation.navigate('Wallet',{})
        }}>
          <Text>我的钱包,应该是没钱的</Text>
        </TouchableOpacity>
        </View>

      </ScrollView>
    );
  }
}


UserInformation.navigationOptions = ({ navigation }) => {
  return ({
    title: '个人资料',
  });
};



export default connect(state => ({
}), dispatch => ({
}))(UserInformation);


