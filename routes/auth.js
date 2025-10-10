const express = require("express");
const bcrypt = require("bcryptjs");   // для хешування паролів
const jwt = require("jsonwebtoken");  // для токенів
const db = require("../config/db");   // наше підключення до MySQL

const router = express.Router();

// 🔑 Реєстрація
router.post("/register", async (req, res) => {
  const { username, email, password } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ message: "Всі поля обов’язкові" });
  }

  // хешування пароля
  const hashedPassword = await bcrypt.hash(password, 10);

  db.query(
    "INSERT INTO users (username, email, password) VALUES (?, ?, ?)",
    [username, email, hashedPassword],
    (err) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: "Помилка при реєстрації" });
      }
      res.json({ message: "✅ Користувача зареєстровано" });
    }
  );
});

// 🔑 Логін
router.post("/login", (req, res) => {
  const { email, password } = req.body;

  db.query("SELECT * FROM users WHERE email = ?", [email], async (err, results) => {
    if (err) return res.status(500).json({ message: "Помилка сервера" });
    if (results.length === 0) return res.status(400).json({ message: "Користувача не знайдено" });

    const user = results[0];

    // перевірка пароля
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: "❌ Невірний пароль" });

    // створюємо токен
    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });

    res.json({ message: "✅ Логін успішний", token });
  });
});

module.exports = router;
