const jwt = require('jsonwebtoken');
require('dotenv').config();

module.exports = {
    signAccessToken: (userId,userRole) => {
        return new Promise((resolve, reject) => {
            const payload = {
                userId: userId,
                userRole:userRole
            };
            const options = {
                expiresIn: '1h'
            };
            
            jwt.sign(payload, process.env.jwt_key, options, (err, token) => {
                if (err) {
                    console.log('error signing access token:', err);
                    reject(err);
                } else {
                    resolve(token);
                }
            });
        });
    }
};
