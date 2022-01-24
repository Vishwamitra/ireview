import express from 'express'
import api from './api'
import dotenv from 'dotenv'
import cors from 'cors' 
import bodyParser from 'body-parser'

const app = express()
const port = process.env.PORT || 5000
dotenv.config()

// Cors
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(cors())

app.use('/', api)

app.listen(port, () => console.log(`Running on port ${port}`))
