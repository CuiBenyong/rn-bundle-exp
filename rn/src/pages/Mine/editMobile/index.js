import React, {Component} from 'react';
import {ScrollView, Text, TextInput, TouchableOpacity, View} from 'react-native';
import {connect} from 'react-redux';
import styles from './styles';
import {dismissLoading, isMobile, showLoading, showToast} from '../../../../utils/fn';
import {MIN_SMS_SEND_TIME} from '../../../../utils/const';

class EditMobile extends Component {
    constructor(props) {
        super(props);
        this.state = {
            old_mobile: '',
            old_code: '',
            new_mobile: '',
            new_code: '',

            old_send_time: Date.now() - MIN_SMS_SEND_TIME,
            old_send_text: '获取验证码',

            new_send_time: Date.now() - MIN_SMS_SEND_TIME,
            new_send_text: '获取验证码',
        };
    }

    componentWillUnmount() {
        this.oldTimer && clearInterval(this.oldTimer);
        this.newTimer && clearInterval(this.newTimer);
    }

    onSendSMSPress(mobile, type, sendText, callback) {
        if (sendText !== '获取验证码') {
            return;
        }
        if (!mobile) {
            showToast('请输入手机号码');
            return;
        }
        if (!isMobile(mobile)) {
            showToast('请输入正确的手机号码');
            return;
        }
        let param = {};
        if (type === 1) {
            param.old_mobile = mobile;
        } else {
            param.new_mobile = mobile;
        }
    }

    onConfirm() {
        const {new_mobile, new_code, old_mobile, old_code} = this.state;

        if (!old_mobile) {
            showToast('请输入原手机号码');
            return;
        }
        if (!isMobile(old_mobile)) {
            showToast('请输入正确的原手机号码');
            return;
        }
        if (!old_code) {
            showToast('请输入手机验证码');
            return;
        }

        if (!new_mobile) {
            showToast('请输入新手机号码');
            return;
        }
        if (!isMobile(new_mobile)) {
            showToast('请输入正确的新手机号码');
            return;
        }
        if (!new_code) {
            showToast('请输入手机验证码');
            return;
        }

        showLoading();

        setTimeout(() => {
          dismissLoading();
        }, 3000);


    }

    renderInputItem(title, placeholder, value, onChange) {
        return <View style={styles.inputContainer}>
            <Text style={styles.title}>{title}：</Text>
            <TextInput
                placeholder={placeholder}
                style={styles.inputStyle}
                defaultValue={value}
                onChangeText={onChange}
            />
        </View>;
    }


    renderVerifyCodeItem(defaultValue, sendText, onSendSMSPress, onChangeText) {
        return <View style={styles.inputContainer}>
            <Text style={styles.title}>验证码：</Text>
            <TextInput
                placeholder={'请输入验证码'}
                style={styles.inputStyle}
                defaultValue={defaultValue}
                onChangeText={onChangeText}
            />
            <TouchableOpacity style={styles.getCodeButton} onPress={onSendSMSPress}>
                <Text style={styles.getCode}>{sendText}</Text>
            </TouchableOpacity>
        </View>;
    }


    render() {
        const {new_code, new_mobile, old_code, old_mobile, old_send_time, old_send_text, new_send_text, new_send_time} = this.state;
        return (
            <ScrollView keyboardShouldPersistTaps={'handled'}
                        contentContainerStyle={styles.container}>
                <View style={styles.inputs}>
                    {
                        this.renderInputItem('手机号', '请输入手机号', old_mobile, (old_mobile) => {
                            this.setState({old_mobile});
                        })
                    }
                    {
                        this.renderVerifyCodeItem(old_code, old_send_text, () => {}, (old_code) => this.setState({old_code}))
                    }
                </View>
                <View style={[styles.inputs, {marginTop: 10}]}>
                    {
                        this.renderInputItem('新手机号', '请输入手机号', new_mobile, (new_mobile) => {
                            this.setState({new_mobile});
                        })
                    }
                    {
                        this.renderVerifyCodeItem(new_code, new_send_text, () => {}, (new_code) => this.setState({new_code}))
                    }
                </View>
                <TouchableOpacity activeOpacity={0.9} onPress={this.onConfirm.bind(this)} style={styles.nextButton}>
                    <Text style={styles.nextText}>完成</Text>
                </TouchableOpacity>

            </ScrollView>
        );
    }
}


EditMobile.navigationOptions = ({navigation}) => {
    return ({
        title: '修改手机号',
    });
};


export default connect(state => ({}), dispatch => ({
}))(EditMobile);


