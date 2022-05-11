class Customer {
  late final String id;
  late final String customerName;
  late final String fullName;
  late final String email;
  late final String password;
  late final String imagePath;
  late final bool isDarkMode;
  late final String about;

  Customer(
      {required this.customerName,
      required this.fullName,
      required this.email,
      required this.password});

  factory Customer.fromJSON(dynamic json) {
    Customer customer = Customer(
        customerName: json['customerName'],
        fullName: json['fullName'],
        email: json['email'],
        password: json['password']);
    customer.id = json['_id'];
    return customer;
  }

  static Map<String, dynamic> toJson(Customer customer) {
    return {
      'customerName': customer.customerName,
      'fullName': customer.fullName,
      'email': customer.email,
      'password': customer.password,
    };
  }
}
