import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/models/user_model.dart';

class FirebaseUtils {
static CollectionReference <Task> getTasksCollection(String uId){
    return getUsersCollection().doc(uId).collection(Task.collectionName).withConverter <Task>(
        fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()!),
        toFirestore: (task , options) => task.toFireStore());
  }

static Future <void> addTaskToFireStore(Task task , String uId) {
    var taskCollection = getTasksCollection(uId);
    DocumentReference<Task> taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

static Future <void> deleteTaskFromFireStore(Task task , String uId) {
    var taskCollection = getTasksCollection(uId);
    return taskCollection.doc(task.id).delete()
        .then((value) => print("Task Deleted"))
        .catchError((error) => print("Failed to delete Task: $error"));
  }

static Future<void> updateTaskInFireStore(Task task , String uId) {
    var taskCollection = getTasksCollection(uId);
    return taskCollection.doc(task.id).update(task.toFireStore())
        .then((value) => print("Task Updated"))
        .catchError((error) => print("Failed to update Task: $error"));
  }

static void signInAccount(String emailAddress, String password) async {
  try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      readUserFromFireStore(credential.user!.uid as Myuser );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        print('The email address is badly formatted.');
      } else if (e.code == 'user-disabled') {
        print('The user account has been disabled.');
      } else if (e.code == 'too-many-requests') {
        print('Too many requests');
      }
    }
}

static Future<void> signUpAccount(String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

static void signOut() async {
  await FirebaseAuth.instance.signOut()
  .then((value) => print("Signed Out"))
  .catchError((error) => print("Failed to sign out: $error"));
}

static CollectionReference<Myuser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(Myuser.collectionName).withConverter<Myuser>(
        fromFirestore: (snapshot, options) => Myuser.fromFirestore(snapshot.data()!),
        toFirestore: (myUser, options) => myUser.toFireStore());
}

static Future <void> addUserToFireStore(Myuser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
}

static void readUserFromFireStore(Myuser myUser) {
  getUsersCollection().doc(myUser.id).get();
  print(myUser.id);
  }

}

