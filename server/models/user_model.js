import mongoose from "mongoose";

const userSchema = mongoose.Schema({
    name:{
        type:String,
        required : true,
    },
    email:{
        type:String,
        required:true,
        validate:{
            validator:(email)=>{
                const re =/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return re.test(email);
            },
            message:'Enter a valid email',
        }

    },
    password:{
        type:String,
        required:true,
    }
});





const User = mongoose.model("Users",userSchema);


export default User