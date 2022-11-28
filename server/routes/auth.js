const express = require('express')
const router = express.Router()
const User = require('../models/user')
const bcryptjs = require('bcryptjs')

router.post('/signup', async (req, res) => {

    try {
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
                password:hashedPassword
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






















module.exports = router