const mongoose = require('mongoose');

const connection = mongoose.createConnection(`mongodb://127.0.0.1:27017/qr_person`).on('open',()=>{
    console.log("MongoDB Connected");}).on('error',()=>{
    console.log("MongoDB Connection error");
});

module.exports = connection;