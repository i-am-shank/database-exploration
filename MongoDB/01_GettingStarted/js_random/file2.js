let book = {
    title: "Red Rising",
    author: "Pierce Brown",
    year: 2014,

    bookDetails: () => {
        return `Title : ${book.title} , author : ${book.author}`;
    },
};

console.log(book);

console.log(book.bookDetails());
