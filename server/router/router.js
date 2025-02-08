import express from 'express'
import { allData, signIn, signUp, validateToken } from '../controllers/controller.js';
import { userIsValid } from '../middleware/auth_middleware.js';


const router = express.Router();




router.post("/api/signin",signIn);
router.post("/api/signup",signUp);
router.get("/",userIsValid,allData);
router.get("/tokenIsValid",validateToken);



export default router;