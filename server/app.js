const express = require('express')
const mongoose = require('mongoose')
const http = require('http')
const app = express()
const authRoutes = require('./routes/auth')
const port = 3000;
app.use(express.json())
app.use('/api', authRoutes)
app.use('*', (req, res) => {
    res.json('404')
})
mongoose.connect('mongodb://localhost:27017/DbAmazonClone', { useNewUrlParser: true, useUnifiedTopology: true }).then(() => {
    console.log('Connected to database DbAmazonClone on port 27017!')
}).catch((err) => {
    console.log(err)
})
app.listen(port, '0.0.0.0', () => console.log(`Amazon clone backend listening on ${port}!`));
