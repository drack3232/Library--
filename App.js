import React, { useEffect, useState } from "react";
import axios from "axios";

function App() {
  const [books, setBooks] = useState([]);
  const [newBook, setNewBook] = useState({
    title: "",
    author: "",
    year: "",
    genre: ""
  });

  const fetchBooks = () => {
    axios.get("http://localhost:3000/books")
      .then(res => setBooks(res.data))
      .catch(err => console.error("Помилка завантаження:", err));
  };

  useEffect(() => {
    fetchBooks();
  }, []);

  const addBook = () => {
    axios.post("http://localhost:3000/books", newBook)
      .then(() => {
        alert("✅ Книга додана!");
        fetchBooks();
      })
      .catch(err => console.error("Помилка додавання:", err));
  };

  const deleteBook = (id) => {
    if (window.confirm("Ви точно хочете видалити книгу?")) {
      axios.delete(`http://localhost:3000/books/${id}`)
        .then(() => fetchBooks())
        .catch(err => console.error("Помилка видалення:", err));
    }
  };

  const editBook = (book) => {
    const title = prompt("Назва книги:", book.title);
    const author = prompt("Автор:", book.author);
    const year = prompt("Рік видання:", book.year);
    const genre = prompt("Жанр:", book.genre);

    if (title && author && year && genre) {
      axios.put(`http://localhost:3000/books/${book.id}`, { title, author, year, genre })
        .then(() => fetchBooks())
        .catch(err => console.error("Помилка редагування:", err));
    }
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>📚 Онлайн-бібліотека</h1>

      <h2>Додати нову книгу</h2>
      <input placeholder="Назва" onChange={e => setNewBook({ ...newBook, title: e.target.value })} />
      <input placeholder="Автор" onChange={e => setNewBook({ ...newBook, author: e.target.value })} />
      <input placeholder="Рік" type="number" onChange={e => setNewBook({ ...newBook, year: e.target.value })} />
      <input placeholder="Жанр" onChange={e => setNewBook({ ...newBook, genre: e.target.value })} />
      <button onClick={addBook}>➕ Додати</button>

      <h2>Список книг</h2>
      <ul>
        {books.map(book => (
          <li key={book.id}>
            <b>{book.title}</b> — {book.author} ({book.year}), жанр: {book.genre} {" "}
            <button onClick={() => editBook(book)}>✏️</button>
            <button onClick={() => deleteBook(book.id)}>🗑️</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
