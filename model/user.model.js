const db = require('../config/db');
const bcrypt = require("bcrypt");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const userSchema = new Schema({
    email: {
        type: String,
        lowercase: true,
        required: [true, "userName can't be empty"],
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "password is required"],
    },
    nombre: {
        type: String,
        required: [true, "nombre is required"],
    },
    apellido: {
        type: String,
        required: [true, "apellido is required"],
    },
    edad: {
        type: Number,
        required: [true, "edad is required"],
    },
    cedula: {
        type: String,
        required: [true, "cedula is required"],
    },
    enfermedad: {
        type: [String],
        default: [],
    },
    alergia: {
        type: [String],
        default: [],
    },
    medicamento: {
        type: [String],
        default: [],
    },
},{timestamps:true});


// used while encrypting user entered password
userSchema.pre("save",async function(){
    var user = this;
    if(!user.isModified("password")){
        return
    }
    try{
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(user.password,salt);

        user.password = hash;
    }catch(err){
        throw err;
    }
});


//used while signIn decrypt
userSchema.methods.comparePassword = async function (candidatePassword) {
    try {
        console.log('----------------no password',this.password);
        // @ts-ignore
        const isMatch = await bcrypt.compare(candidatePassword, this.password);
        return isMatch;
    } catch (error) {
        throw error;
    }
};

const UserModel = db.model('users',userSchema);
module.exports = UserModel;