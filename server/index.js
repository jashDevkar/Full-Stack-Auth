import express from "express"
import router from './router/router.js'
import dotenv from 'dotenv'
import mongoose from 'mongoose'
import user from "./models/user_model.js"

dotenv.config()
const app = express();


const PORT = process.env.PORT || 8000

mongoose.connect(process.env.URI).then(()=>console.log('connected successfully')).catch((e)=>console.log(e));

app.use(express.json());
app.use(router);


app.listen(PORT,()=>{
    console.log(`Server is listening at port ${PORT}`);
});