const UserServices = require('../service/user.service');

exports.register = async (req, res, next) => {
    try {
        const { email, password, nombre, apellido, edad, cedula, enfermedad, alergia, medicamento } = req.body;
        
        const duplicate = await UserServices.getUserByEmail(email);
        if (duplicate) {
            throw new Error(`UserName ${email}, Already Registered`)
        }
        
        // Modify this part to include the new attributes in the registerUser function
        const response = await UserServices.registerUser(email, password, nombre, apellido, edad, cedula, enfermedad, alergia, medicamento);

        res.json({ status: true, success: 'User registered successfully' });
    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            throw new Error('Parameter are not correct');
        }
        
        let user = await UserServices.checkUser(email);
        if (!user) {
            throw new Error('User does not exist');
        }

        const isPasswordCorrect = await user.comparePassword(password);

        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
        }

        // Creating Token
        let tokenData;
        tokenData = { _id: user._id, email: user.email };
    
        const token = await UserServices.generateAccessToken(tokenData, "secret", "1h");

        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}
