import React, { Component } from 'react';
import { TouchableOpacity } from 'react-native';
import {
  FlatList, ScrollView, Text, View
} from 'react-native';
import { connect } from "react-redux";
import styles from "./styles";

class Wallet extends Component {
  constructor(props) {
    super(props);

    this.state = {
      show: false,
      show1: false
    }
  }

  onEndReached() {
  }

  render() {
    return (
      <ScrollView style={styles.container}>
        <View
          style={styles.walletBg}
        >

          <Text style={styles.account}>余额：¥1000万</Text>

          <View style={styles.moneyContainer}>
            <View style={styles.vLine} />
            <Text style={styles.money}>可用余额：¥1000万</Text>
          </View>
        </View>


        <View style={styles.accountDetail}>
          <TouchableOpacity onPress={() => {
            a.b.c;
          }}>
            <Text>点我逻辑崩溃</Text>
          </TouchableOpacity>
          <View style={{ height: 20 }} />
          <TouchableOpacity onPress={() => {
            this.setState({
              show: true
            })
          }}>
            <Text>点我界面崩溃</Text>
          </TouchableOpacity>

          <View style={{ height: 20 }} />
          <TouchableOpacity onPress={() => {
            this.setState({
              show1: true
            })
          }}>
            <Text>点我界面崩溃-定位到基础库</Text>
          </TouchableOpacity>


          {!!this.state.show && <View><Text>{a.b.c}</Text></View>}

          {!!this.state.show1 && <View>aaaaa</View>}
          <FlatList
            data={[]}
            keyExtractor={(item, index) => item + index}
            renderItem={({ item }) => {
              return <View>有钱</View>
            }}
            ListHeaderComponent={() => {
              return (
                <View style={styles.detailContainer}>
                  <Text style={styles.title}>余额明细</Text>
                </View>
              )
            }}

            ListEmptyComponent={<View><Text>啥也不是</Text></View>}
          />
        </View>
      </ScrollView>
    );
  }
}


Wallet.navigationOptions = ({ navigation }) => {
  return ({
    title: '我的钱包',
  });
};



export default connect(state => ({
}), dispatch => ({
}))(Wallet);


