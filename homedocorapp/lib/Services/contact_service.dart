import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {
  Future<void> getContacts() async {
    print('Requesting contacts permission...');
    PermissionStatus permission = await Permission.contacts.request();

    if (permission.isGranted) {
      print('Permission granted, fetching contacts...');
      Iterable<Contact> contacts = await ContactsService.getContacts();
      print('Contacts fetched: ${contacts.length}');
      for (var contact in contacts) {
        print('Name: ${contact.displayName}');
        for (var phone in contact.phones ?? []) {
          print('Phone: ${phone.value}');
        }
      }
    } else {
      print('Contacts permission denied');
    }
  }
}
