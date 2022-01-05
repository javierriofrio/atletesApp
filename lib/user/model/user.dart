
class User {
  String email;
  String firstName;
  String lastName;
  String userID;
  String profilePictureURL;
  String country;
  String city;
  int completed;
  int created;
  int points;
  Map<String,bool> sports;
  String description;

  User(
      {this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.userID = '',
      this.description = '',
      this.completed = 0,
      this.created = 0,
      this.country = '',
      this.city = '',
        this.points = 0,
      this.sports  = const  {},
      this.profilePictureURL = ''});

  String fullName() => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        country: parsedJson['country'] ?? parsedJson['country'] ?? '',
        city: parsedJson['city'] ?? parsedJson['city'] ?? '',
        completed: parsedJson['completed'] ?? parsedJson['completed'] ?? 0,
        created: parsedJson['created'] ?? parsedJson['created'] ?? 0,
        points: parsedJson['points'] ?? parsedJson['points'] ?? 0,
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': userID,
      'profilePictureURL': profilePictureURL,
      'city': city,
      'country': country,
      'sports': sports,
      'completed': completed,
      'created': created,
      'points': points
    };
  }
}
