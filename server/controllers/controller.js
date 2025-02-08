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
        return res.status(200).json({user:result})

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
        const token =    jwt.sign({id:user._id},'passwordKey');
        return  res.status(200).json({token,...user._doc});


    }catch(e){
        return res.status(500).json({error:e})
    }
}


export  {signIn,signUp};