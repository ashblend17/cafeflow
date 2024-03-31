const mongoose = require('mongoose');

const tokenSchema = new mongoose.Schema({
    lastToken: { type: Number, required: true, default: 0 }
});
module.exports = mongoose.model('Token', tokenSchema);
