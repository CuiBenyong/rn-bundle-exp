import React, { Component } from 'react';
import { BackHandler } from 'react-native';
import WebViewComponent from "react-native-webview";
import { connect } from "react-redux";
import HeaderLeft from "../../../../component/HeaderLeft";

class WebView extends Component {
  constructor(props) {
    super(props);
    this.state = {

    }
    props.navigation.setParams({
      onBackPress: this.onBackPress.bind(this)
    })
    BackHandler.addEventListener('hardwareBackPress', this.handleBackPress.bind(this))
  }
  onBackPress() {
    if (this.canGoBack) {
      this.webview.goBack()
      return true;
    } else {
      this.props.navigation.goBack()
      return true;
    }
  }

  handleBackPress() {
    if (this.canGoBack) {
      this.webview.goBack()
      return true;
    }
    return false;
  }

  componentWillUnmount() {
    BackHandler.removeEventListener('hardwareBackPress', this.handleBackPress)
  }

  render() {
    const uri = this.props.navigation.getParam('uri') || this.props.uri;
    console.log(uri)
    return (
      <WebViewComponent
        ref={e => this.webview = e}
        source={{ uri }}
        style={{ width: '100%', height: '100%' }}
        onLoad={(e) => console.log('onLoad')}
        onLoadEnd={(e) => {
          console.log('onLoadEnd')

        }}
        onLoadStart={(e) => {
          console.log('onLoadStart')

        }}
        onNavigationStateChange={navState => {
          // Keep track of going back navigation within component
          this.props.navigation.setParams({
            title: navState.title
          })
          this.canGoBack = navState.canGoBack;
        }}
      />
    );
  }
}


WebView.navigationOptions = ({ navigation }) => {
  const title = navigation.getParam('title', '')
  const onBackPress = navigation.getParam('onBackPress', () => { navigation.goBack() })
  return ({
    title,
    headerLeft: () => <HeaderLeft onPress={onBackPress} />
  });
};



export default connect(state => ({
  uri: state.base.uri
}), dispatch => ({
}))(WebView);


