import 'dart:convert';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  var baseUrl = "http://10.0.2.2:3000/api/customers";

  //In Dart, promises are called Future.

  Future<Customer?> login(String customerName, String password) async {
    var res = await http.get(Uri.parse(baseUrl + '/name/' + customerName));
    if (res.statusCode == 404) {
      return null;
    }
    Customer customer = Customer.fromJSON(jsonDecode(res.body));
    if (customer.password == password) {
      return customer;
    }
    return null;
  }

  Future<Customer?> update(Customer customer, String id) async {
    var res = await http.put(Uri.parse(baseUrl + '/' + id),
        headers: {'content-type': 'application/json'},
        body: json.encode(Customer.toJson(customer)));

    if (res.statusCode == 201) {
      Customer newCustomer = Customer.fromJSON(res.body);
      return newCustomer;
    }
    return null;
  }

  Future<List<Customer>?> getAllCustomers() async {
    var res = await http.get(Uri.parse(baseUrl));

    List<Customer> allCustomers = [];
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded
          .forEach((customer) => allCustomers.add(Customer.fromJSON(customer)));
      return allCustomers;
    }

    return null;
  }

  Future<Customer?> addCustomer(Customer customer) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: {'content-type': 'application/json'},
        body: json.encode(Customer.toJson(customer)));

    if (res.statusCode == 201) {
      Customer newCustomer = Customer.fromJSON(res.body);
      return newCustomer;
    }
    return null;
  }

  Future<bool> deleteCustomer(String _id) async {
    var res = await http.delete(Uri.parse(baseUrl + '/' + _id));
    int statusCode = res.statusCode;
    if (statusCode == 200) return true;
    return false;
  }
}
