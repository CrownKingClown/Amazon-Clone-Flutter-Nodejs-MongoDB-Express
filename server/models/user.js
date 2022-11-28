const mongoose = require('mongoose')
const Schema = mongoose.Schema

const userSchema = Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: function (value) {
                return /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test(value);
            },
            message: props => `${props.value} is not a valid email address!`
        }
    },
    password: {
        type: String,
        required: true,
        validate: {
            validator: function (value) {
                return value.length > 6;
            },
            message: props => `${props.value} is not a valid password!`,
        },
    },
    address: {
        type: String,
        default: ''
    },
    type: {
        enum: ['user', 'admin'],
        type: String,
        default: 'user'
    },
})

module.exports = mongoose.model('User', userSchema)