const express = require('express')
const router = express.Router()
const User = require('../models/user')
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken')
const auth = require('../middleware/auth')
//@TODO: add winston logging

/**
 * @route POST api / auth / signup
 * @desc Create a new user
 * @access Public
 * @param {string} email
 * @param {string} password
 * @param {string} name
 * @returns {string} message, success or failure
 */
router.post('/signup', async (req, res) => {
    try {
        console.log(req.body)
        const {
            name,
            email,
            password
        } = req.body
        const existingUser = await User.findOne({
            email
        }).lean();
        if (existingUser) {
            return res.json({
                status: 'error',
                message: 'Email already in use'
            })
        } else {
            const hashedPassword = await bcryptjs.hash(password, 10)
            let user = await User.create({
                name,
                email,
                password: hashedPassword
            })
            user = await user.save()
            return res.status(400).json({
                status: 'success',
                message: 'User created'
            })
        }
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            status: 'error',
            message: 'Internal server error'
        })
    }
})


/**
 * 
 * @route POST api / auth / signin
 * @desc Login a user   
 * @access Public
 * @param {string} email
 * @param {string} password
 * @returns {object} user with token
 * */
router.post('/signin', async (req, res) => {
    try {
        const {
            email,
            password
        } = req.body
        const user = await User.findOne({
            email
        }).lean()
        if (!user) {
            return res.status(400).json({
                status: 'error',
                message: 'Invalid email/password'
            })
        } else {
            bcryptjs.compare(password, user.password, function (err, result) {
                if (err) {
                    return res.status(500).json({
                        status: 'error',
                        message: err.message
                    })
                }
                if (result) {
                    const token = jwt.sign({
                        id: user._id,
                        email: user.email
                    }, 'secret', {
                        expiresIn: '1h'
                    })
                    return res.status(200).json({
                        status: 'success',
                        message: 'Login successful',
                        token,
                        user: user
                    })
                } else {
                    return res.status(400).json({
                        status: 'error',
                        message: 'Invalid email/password'
                    })
                }
            })
        }
    } catch (error) {
        console.log(error.message)
        return res.status(500).json({
            status: 'error',
            message: error.message
        })
    }
})

/**
 * @route GET api / auth / user
 * @desc checks if token is valid and if user exists
 * @access public
 * @param {string} token
 * @returns {boolean} valid or not
 * */

router.post('/tokenIsValid', async (req, res) => {
    try {
        const token = req.header('x-auth-token')
        if(!token) return res.json(false)
        const verified = jwt.verify(token, 'secret')
        if(!verified) return res.json(false)
        const user = await User.findById(verified.id)
        if(!user) return res.json(false)
        return res.json(true)
    } catch (error) {
        console.log(error.message)
        return res.status(500).json({
            status: 'error',
            message: error.message
        })
    }
})

router.get('/', auth ,async (req, res) => {
    console.log(0)
    const user = await User.findById(req.user).lean() //req.user is the id of the user
    console.log(user)
    res.json({user:user,token:req.token})

})



















module.exports = router