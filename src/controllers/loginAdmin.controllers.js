import pool from "../database.js";
import bcryptjs from "bcryptjs";
import jwt from "jsonwebtoken";

import { JWT_SECRET_KEY } from "../config.js";

// CREAR UN NUEVO ADMINISTRADOR TRAMO
export const createAdmin = async (req, res) => {
  try {
    const correo = req.body.correo;
    const usuario = req.body.usuario;
    const password = req.body.password;
    let passHaas = await bcryptjs.hash(password, 8);

    if (correo && usuario && password) {
      const [rows] = await pool.query(`INSERT INTO Tbl_Administradores SET ?`, {
        correoAdmin: correo,
        Usuario: usuario,
        Contrasena: passHaas,
      });
      if (rows.affectedRows == 1) {
        res.json("Registro exitoso");
      } else {
        res.json("No se pudo registrar este usuario");
      }
    } else {
      res.json("Por favor ingrese todos los datos");
    }
  } catch (error) {
    return res.status(505).json(error);
  }
};

// VALIDAR EL IGRESO AL MODULO ADMINISTRADOR TRAMO
export const autenticacionAdmin = async (req, res) => {
  try {
    const correoAdmin = req.body.correoAdmin;
    const adminContra = req.body.passwordAdmin;

    let passHaas = await bcryptjs.hash(adminContra, 8);

    if (correoAdmin && adminContra) {
      const [rows] = await pool.query(
        `SELECT * FROM Tbl_Administradores WHERE correoAdmin=?`,
        [correoAdmin]
      );
      if (
        rows.length == 0 ||
        !(await bcryptjs.compare(adminContra, rows[0].Contrasena))
      ) {
        return res.status(400).json("USUARIO y/o CONTRASEÑA incorrecta");
      } else {
        const token = jwt.sign(
          { id: rows[0].idAdministradores, name: rows[0].Usuario },
          JWT_SECRET_KEY
        );
        res.status(200).json({
          message: "¡LOGIN CORRECTO!",
          token: token
        });
      }
    } else {
      return res.status(400).json("¡Por favor, llene los campos requeridos!");
    }
  } catch (error) {
    return res.status(500).json(error);
  }
};


// CERRAR SESIÓN DEL MODULO ADMINISTRADOR
export const cerraSesion = (req, res) => {
  try {
    res.clearCookie("token");
    res.status(200).json("sesion cerrada correctamente");
  } catch (error) {
    res.status(500).json(error);
  }
};
