const express=require('express');
const router=express.Router();
const User=require('../../models/users');
const checkAuth=require('../../middleware/managerAuth');
require('dotenv').config();
//route for listing all plastic details
router.get('/',checkAuth,(req,res,next)=>{
    User.find()
    .exec()
    .then(users=>{
        const plasticDetails=users.map(user=>{
            return {
                userId:user.userId,
                plasticDetails:user.plasticDetails
            }
        });
         res.status(200).json({
            plasticDetails:plasticDetails
        });
    })
    .catch(err=>{
        
        return res.status(500).json({
            message:'Internal server error.'
        });
    });
})




//route for listing plastic details of specific user
router.get('/:id',checkAuth,(req,res,next)=>{
    const userId=req.params.id;
    User.findOne({userId})
    .exec()
    .then(user=>{
        if(!user){
            return res.status(400).json({
                message:'user not found'
            });
        }
        res.status(200).json({
            userId:user.userId,
            plasticDetails:user.plasticDetails
        });
    })
    .catch(err=>{
        return res.status(500).json({
            message:'Internal server error.'
        });
    });

});


//route for updating plastic details of specific user
router.put('/accept',checkAuth,(req,res,next)=>{
    const {token}=req.body;
    User.findOneAndUpdate({ token: token }, { status: 'accepted' })
    .exec()
    .then(user => {
        if (!user) {
            return res.status(400).json({
                message: 'User not found'
            });
        }
        res.status(200).json({
            message: 'Plastic details updated successfully'
        });
    })
    .catch(err => {
        return res.status(500).json({
            message: 'Internal server error.'
        });
    });
});




module.exports=router;