import mongoose from "mongoose";
import bcryptjs from 'bcryptjs'
import User from "../models/user_model.js";
import jwt from 'jsonwebtoken'


 const signUp= async (req,res)=>{
    const {name,email,password} = req.body;
    try{
        const userExist = await User.findOne({email});
        if(userExist){
            return res.status(400).json({mssg:"User already exist"});
        }
        var hashPassword = await bcryptjs.hash(password,8);
        const user = User({
            name,
            email,
            password:hashPassword,
        })
        const result = await user.save();
        return res.status(200).json({...result._doc})

    }catch(e){
        res.status(500).json({error:e.message});
    }

}


const signIn = async(req,res)=>{
    const {email,password} = req.body;
    try{
        const user = await User.findOne({email});
        if(!user){
           return res.status(400).json({mssg:'User not found'})
        }

        const validUser = await bcryptjs.compare(password,user.password);
        if(!validUser){
            return res.status(400).json({mssg:'Invalid password'});  
        }
        const token = jwt.sign({id:user._id},'passwordKey');
        return  res.status(200).json({token,...user._doc});


    }catch(e){
        return res.status(500).json({error:e})
    }
}



const allData = async (req,res)=>{
    const token = req.token;
    const user = await User.findById(req.id);
    return res.status(200).json({token:token,...user._doc});
}


const validateToken = async(req,res)=>{
    try{
        const token = req.header('auth-token');
    if(!token){
        return res.json(false)
    }
    const isValid =  jwt.verify(token,'passwordKey');
    if(!isValid){
        return res.json(false);
    }

    const user = await User.findById(isValid.id);
    if(!user){
        return res.json(false);
    }

    return res.json(true)


    }catch(e){
        return res.status(500).json({error:e});
    }
}



export  {signIn,signUp,allData,validateToken};