import React, {PureComponent} from "react";
import {View, StyleSheet, TouchableOpacity, Text, Image} from "react-native";

export default class Button extends PureComponent {
    constructor(props) {
        super(props)
    }

    render() {
        const {title, numberOfLines, iconPosition, iconStyle, titleStyle, icon, style, onPress} = this.props;
        return (
            <TouchableOpacity
                onPress={onPress}
                style={[styles.container, style]}>
                {
                    iconPosition === 'left' && <Image
                        source={icon}
                        style={iconStyle}
                    />
                }

                <Text numberOfLines={numberOfLines} style={[styles.title, titleStyle]}>{title}</Text>
                {
                    iconPosition === 'right' && <Image
                        source={icon}
                        style={iconStyle}
                    />
                }
            </TouchableOpacity>
        )
    }
}

const styles = StyleSheet.create({
    container:{
        flexDirection: 'row',
        alignItems: 'center',
        flex: 1,
        backgroundColor:'red'
    },
    title:{
        fontSize: 14,
        color: "#999"
    }
})