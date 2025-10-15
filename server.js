const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
require('dotenv').config();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
//const { use } = require("react");
const SECRET = "supersecret"; // краще винести у .env
const app = express();

app.use(express.json());
app.use(cors());
// Підключення до MySQL
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "library_online"
});

db.connect(err => {
  if (err) {
    console.error("Помилка з'єднання з MySQL:", err);
    return;
  }
  console.log("✅ Підключено до MySQL");
});

// ==================== MIDDLEWARE ====================
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Токен відсутній' });
  }

  jwt.verify(token, SECRET, (err, user) => {
    if (err) {
      return res.status(403).json({ error: 'Токен недійсний' });
    }
    req.user = user;
    next();
  });
};

// ==================== АВТЕНТИФІКАЦІЯ ====================
app.post("/register", (req, res) => {
  const { name, email, password } = req.body;
  const hashedPassword = bcrypt.hashSync(password, 10);
  db.query("INSERT INTO users (name, email, password) VALUES (?, ?, ?)",
    [name, email, hashedPassword],
    (err, result) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ message: "✅ Користувача зареєстровано!" });
    }
  );
});

app.post("/login", (req, res) => {
  const { email, password } = req.body;
  db.query("SELECT * FROM users WHERE email = ?", [email], (err, users) => {
    if (err) return res.status(500).json({ error: err });
    if (users.length === 0) return res.status(400).json({ error: "❌ Користувач не знайдений" });
    const user = users[0];
    if (!bcrypt.compareSync(password, user.password)) {
      return res.status(400).json({ error: "❌ Невірний пароль" });
    }
    const token = jwt.sign({ id: user.id }, SECRET, { expiresIn: "1h" });
    res.json({ message: "✅ Вхід успішний", token, user: { id: user.id, name: user.name, email: user.email } });
  });
});

// ==================== ОСОБИСТИЙ КАБІНЕТ ====================
app.get("/profile", authenticateToken, (reg, res) =>{
  const userID = req.user.id;
  const sqlQuery = "SELECT id, name, email, FROM users WHERE id=?"

  db.query(sqlQuery, [userID], (err, users)=>{
    if (err){
      console.error("Error receiving profile:", err);
      return res.status(500).json({error:"Server's error "});
    
  }
  if(users.length ===0){
    return res.status(404).json({error: "User not found"})
  }
res.json(users[0])
  })
})



// ==================== КОШИК ====================
app.post("/cart/add", authenticateToken, (req, res) => {
  const { bookId } = req.body;
  const userId = req.user.id;

  db.query("INSERT INTO cart (user_id, book_id) VALUES (?, ?)", [userId, bookId], (err) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: "✅ Додано у кошик" });
  });
});

app.get("/cart/:userId", authenticateToken, (req, res) => {
  const userId = req.params.userId;
  
  // Перевіряємо, чи користувач має доступ до цього кошика
  if (req.user.id != userId) {
    return res.status(403).json({ error: "Доступ заборонено" });
  }

  db.query(
    "SELECT books.* FROM cart JOIN books ON cart.book_id = books.id WHERE cart.user_id = ?",
    [userId],
    (err, results) => {
      if (err) return res.status(500).json({ error: err });
      res.json(results);
    }
  );
});

// ==================== ОСНОВНІ ЕНДПОІНТИ КНИГ ====================
app.get("/books", (req, res) => {
  db.query("SELECT * FROM books", (err, results) => {
    if (err) {
      console.error("ПОМИЛКА ЗАПИТУ ДО БАЗИ ДАНИХ:", err); // Додамо лог помилки
      return res.status(500).json(err);
    }
    console.log("РЕЗУЛЬТАТИ З БАЗИ ДАНИХ:", results); // <-- ОСЬ ЦЕЙ РЯДОК
    res.json(results);
  });
});

app.post("/books", (req, res) => {
  const { title, author, year, genre, description, cover_url } = req.body;
  db.query(
    "INSERT INTO books (title, author, year, genre, description, cover_url) VALUES (?, ?, ?, ?, ?, ?)",
    [title, author, year, genre, description, cover_url],
    (err, results) => {
      if (err) return res.status(500).json(err);
      res.json({ message: "Книга додана!" });
    }
  );
});

app.put("/books/:id", (req, res) => {
  const id = req.params.id;
  const { title, author, year, genre, description, cover_url } = req.body;
  db.query(
    "UPDATE books SET title = ?, author = ?, year = ?, genre = ?, description = ?, cover_url = ? WHERE id = ?",
    [title, author, year, genre, description, cover_url, id],
    (err, results) => {
      if (err) return res.status(500).json(err);
      res.json({ message: "Книгу оновлено!" });
    }
  );
});

app.delete("/books/:id", (req, res) => {
  const id = req.params.id;
  db.query("DELETE FROM books WHERE id = ?", [id], (err, results) => {
    if (err) return res.status(500).json(err);
    res.json({ message: "Книгу видалено!" });
  });
});

// ==================== НОВІ ЕНДПОІНТИ KSD ====================

// Оновлення рейтингу книги (допоміжна функція)
const updateBookRating = (bookId) => {
  db.query(
    "SELECT AVG(rating) as avgRating, COUNT(*) as count FROM reviews WHERE book_id = ?",
    [bookId],
    (err, results) => {
      if (!err && results[0].avgRating) {
        const avgRating = parseFloat(results[0].avgRating).toFixed(2);
        const reviewsCount = results[0].count;
        
        db.query(
          "UPDATE books SET rating = ?, reviews_count = ? WHERE id = ?", 
          [avgRating, reviewsCount, bookId],
          (updateErr) => {
            if (updateErr) console.error("Помилка оновлення рейтингу:", updateErr);
          }
        );
      }
    }
  );
};

// Додавання відгуку
app.post("/books/:id/review", authenticateToken, (req, res) => {
  const { rating, comment } = req.body;
  const bookId = req.params.id;
  const userId = req.user.id;

  // Перевіряємо, чи користувач вже залишав відгук
  db.query(
    "SELECT id FROM reviews WHERE user_id = ? AND book_id = ?",
    [userId, bookId],
    (err, results) => {
      if (err) return res.status(500).json({ error: err });
      
      if (results.length > 0) {
        return res.status(400).json({ error: "Ви вже залишили відгук для цієї книги" });
      }

      // Додаємо новий відгук
      db.query(
        "INSERT INTO reviews (user_id, book_id, rating, comment) VALUES (?, ?, ?, ?)",
        [userId, bookId, rating, comment],
        (insertErr) => {
          if (insertErr) return res.status(500).json({ error: insertErr });
          
          // Оновлюємо рейтинг книги
          updateBookRating(bookId);
          res.json({ message: "Відгук додано!" });
        }
      );
    }
  );
});

// Отримання відгуків для книги
app.get("/books/:id/reviews", (req, res) => {
  const bookId = req.params.id;
  
  const query = `
    SELECT r.*, u.name as user_name 
    FROM reviews r 
    JOIN users u ON r.user_id = u.id 
    WHERE r.book_id = ? 
    ORDER BY r.id DESC
  `;
  
  db.query(query, [bookId], (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Популярні книги
app.get("/books/popular", (req, res) => {
  db.query(
    "SELECT * FROM books WHERE rating >= 4.0 ORDER BY reviews_count DESC, rating DESC LIMIT 10",
    (err, results) => {
      if (err) return res.status(500).json({ error: err });
      res.json(results);
    }
  );
});

// Отримання унікальних жанрів
app.get("/books/genres", (req, res) => {
  db.query(
    "SELECT DISTINCT genre FROM books WHERE genre IS NOT NULL AND genre != '' ORDER BY genre", 
    (err, results) => {
      if (err) return res.status(500).json({ error: err });
      res.json(results.map(row => row.genre));
    }
  );
});

// Розширений пошук
app.get("/books/search/advanced", (req, res) => {
  const { query, genre, yearFrom, yearTo, minRating, sortBy = 'title' } = req.query;
  
  let sql = "SELECT * FROM books WHERE 1=1";
  let params = [];

  if (query && query.trim() !== '') {
    sql += " AND (title LIKE ? OR author LIKE ? OR description LIKE ?)";
    const searchTerm = `%${query.trim()}%`;
    params.push(searchTerm, searchTerm, searchTerm);
  }
  
  if (genre && genre !== 'all') {
    sql += " AND genre = ?";
    params.push(genre);
  }
  
  if (yearFrom && !isNaN(yearFrom)) {
    sql += " AND year >= ?";
    params.push(parseInt(yearFrom));
  }
  
  if (yearTo && !isNaN(yearTo)) {
    sql += " AND year <= ?";
    params.push(parseInt(yearTo));
  }
  
  if (minRating && !isNaN(minRating)) {
    sql += " AND rating >= ?";
    params.push(parseFloat(minRating));
  }

  // Сортування
  const sortOptions = {
    'title': 'title ASC',
    'rating': 'rating DESC',
    'year': 'year DESC',
    'reviews': 'reviews_count DESC'
  };
  
  sql += ` ORDER BY ${sortOptions[sortBy] || 'title ASC'}`;

  db.query(sql, params, (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Рекомендації книг
app.get("/recommendations", authenticateToken, (req, res) => {
  const userId = req.user.id;
  
  const query = `
    SELECT DISTINCT b.* 
    FROM books b
    WHERE b.genre IN (
      SELECT DISTINCT genre FROM books 
      WHERE id IN (
        SELECT book_id FROM cart WHERE user_id = ?
      )
    )
    AND b.id NOT IN (
      SELECT book_id FROM cart WHERE user_id = ?
    )
    AND b.rating >= 3.5
    ORDER BY b.rating DESC 
    LIMIT 8
  `;
  
  db.query(query, [userId, userId], (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Статистика бібліотеки
app.get("/admin/stats", authenticateToken, (req, res) => {
  const statsQueries = {
    totalBooks: "SELECT COUNT(*) as count FROM books",
    totalUsers: "SELECT COUNT(*) as count FROM users", 
    totalReviews: "SELECT COUNT(*) as count FROM reviews",
    popularGenres: `
      SELECT genre, COUNT(*) as count 
      FROM books 
      WHERE genre IS NOT NULL 
      GROUP BY genre 
      ORDER BY count DESC 
      LIMIT 5
    `,
    topRatedBooks: `
      SELECT title, rating, reviews_count 
      FROM books 
      WHERE reviews_count > 0 
      ORDER BY rating DESC 
      LIMIT 5
    `
  };

  const stats = {};
  let completedQueries = 0;
  const totalQueries = Object.keys(statsQueries).length;

  Object.keys(statsQueries).forEach(key => {
    db.query(statsQueries[key], (err, results) => {
      if (err) {
        stats[key] = { error: err.message };
      } else {
        stats[key] = results;
      }
      
      completedQueries++;
      if (completedQueries === totalQueries) {
        res.json(stats);
      }
    });
  });
});

// ==================== СТАНДАРТНИЙ ЕНДПОІНТ ====================
app.get("/", (req, res) => {
  res.send("Це бекенд онлайн-бібліотеки. Використовуй /books для перегляду книг.");
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Сервер запущено на http://localhost:${PORT}`));