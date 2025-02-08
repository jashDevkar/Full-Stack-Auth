import jwt from "jsonwebtoken";

const userIsValid = (req, res, next) => {

    try {
        const token = req.header('auth-token');
        if (!token) {
            return res.status(401).json({ mssg: "No auth token,access denied" });
        }
        const isValid = jwt.verify(token, 'passwordKey');
        if (!isValid) {
            return res.status(401).json({ mssg: 'Unauthoraized access' });
        }
        req.id = isValid.id;
        req.token = token;

        next();
    } catch (e) {
        return res.status(500).json({ error: e });
    }
}


export { userIsValid }