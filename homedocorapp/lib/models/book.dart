class Book {
  int? id;
  String bookName;
  String author;
  String description;
  List<int>? bookImage;
  double rates;
  String summary; 

  Book({
    this.id,
    required this.bookName,
    required this.author,
    required this.description,
    this.bookImage,
    this.rates = 0,
    required this.summary, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_name': bookName,
      'author': author,
      'description': description,
      'book_image': bookImage,
      'rates': rates,
      'summary': summary, 
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      bookName: map['book_name'],
      author: map['author'],
      description: map['description'],
      bookImage: map['book_image'],
      rates: map['rates'].toDouble(),
      summary: map['summary'] ?? '', 
    );
  }
}
