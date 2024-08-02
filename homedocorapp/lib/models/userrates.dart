class UserRating {
  final int? id;
  final int userId;
  final int bookId;
  final double rating;

  UserRating({
    this.id,
    required this.userId,
    required this.bookId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'bookId': bookId,
      'rating': rating,
    };
  }

  factory UserRating.fromMap(Map<String, dynamic> map) {
    return UserRating(
      id: map['id'],
      userId: map['userId'],
      bookId: map['bookId'],
      rating: map['rating'],
    );
  }
}
