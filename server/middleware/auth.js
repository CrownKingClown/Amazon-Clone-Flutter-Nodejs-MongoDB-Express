const jwt = require('jsonwebtoken')
const User = require('../models/user')

const auth = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token')
        if(!token) return res.status(401).json({
            status: 'error',
            message: 'No authentication token, authorization denied'
        })
        const verified = jwt.verify(token, 'secret')
        if(!verified) return res.status(401).json({
            status: 'error',
            message: 'Token verification failed, authorization denied'
        })
        // const user = await User.findById(verified.id)
        // if(!user) return res.status(401).json({
        //     status: 'error',
        //     message: 'No user found, authorization denied'
        // })
        req.user = verified.id
        req.token = token
        next()
    } catch (error) {
        console.log(error.message)
        return res.status(500).json({
            status: 'error',
            message: error.message
        })
    }}
    module.exports = auth
