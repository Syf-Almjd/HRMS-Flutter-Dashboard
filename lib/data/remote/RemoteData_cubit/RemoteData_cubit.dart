import 'package:admin/config/utils/styles/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_secure/dart_secure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/Models/UserModel.dart';
import '../../../config/utils/managers/app_constants.dart';
import '../../../domain/Models/announcementModel.dart';
import '../../../domain/Models/attendanceModel.dart';
import '../../../domain/Models/eLeaveModel.dart';
import '../../../domain/Models/eventModel.dart';
import '../../../presentation/Cubits/navigation_cubit/navi_cubit.dart';
import '../../../presentation/Shared/Components.dart';
import '../../local/localData_cubit/local_data_cubit.dart';

part 'RemoteData_states.dart';

class RemoteDataCubit extends Cubit<RemoteAppStates> {
  RemoteDataCubit() : super(InitialAppState());

  static RemoteDataCubit get(context) => BlocProvider.of(context);

  ///FIREBASE DATA

// Imports all docs in Collection snapshot
  List<String> firebaseDocIDs(snapshot) {
    List<String> dataList = [];

    for (var element in snapshot.data!.docs) {
      dataList.add(element.id);
    }

    return dataList;
  }

  //Firebase get current user data
  Future<UserModel> getUserData(uid) async {
    emit(GettingData());
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.allStaffCollection)
          .doc(uid)
          .get();

      if (userSnapshot.exists) {
        final userData = UserModel.fromJson(userSnapshot.data()!);
        emit(GetDataSuccessful());
        return userData;
      } else {
        emit(GetDataError());
        throw ("User Doesn't Exist");
      }
    } on FirebaseAuthException {
      emit(GetDataError());
      rethrow;
    }
  }

  //Firebase get current user data
  Future<UserModel> getAdminData(context) async {
    emit(GettingData());
    try {
      if (FirebaseAuth.instance.currentUser?.email == AppConstants.adminEmail) {
        final userSnapshot = await FirebaseFirestore.instance
            .collection(AppConstants.adminsData)
            .doc(AppConstants.ppkAdminData)
            .get();
        var userData = UserModel.fromJson(userSnapshot.data()!);
        emit(GetDataSuccessful());
        return userData;
      } else {
        emit(GetDataError());
        showToast("Unauthorized", Colors.red, context);
        return UserModel.loadingUser();
      }
    } on FirebaseAuthException {
      emit(GetDataError());
      rethrow;
    }
  }

  //Firebase get current user data
  Future<void> updateAdminData(UserModel userModel) async {
    emit(GettingData());
    try {
      if (FirebaseAuth.instance.currentUser?.email == AppConstants.adminEmail) {
        await FirebaseFirestore.instance
            .collection(AppConstants.adminsData)
            .doc(AppConstants.ppkAdminData)
            .update(userModel.toJson());
        emit(GetDataSuccessful());
      } else {
        emit(GetDataError());
      }
    } on FirebaseAuthException {
      emit(GetDataError());
      rethrow;
    }
  }

  //Firebase Login with current user data
  Future<void> adminUserLogin(String mail, String pwd, context) async {
    emit(GettingData());
    try {
      String password = hashEncrypt(text: pwd, keyIV: mail.substring(0, 8));
      if (mail == AppConstants.adminEmail) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: mail, password: password);

        FirebaseFirestore.instance
            .collection(AppConstants.adminsData)
            .doc(AppConstants.ppkAdminData)
            .update({AppConstants.lastLogin: DateTime.now().toString()});

        showToast("Successful Login", Colors.blue, context);
        emit(GetDataSuccessful());
        NaviCubit.get(context).navigateToHome(context);
      } else {
        emit(GetDataError());
        showToast("Login Failed!", Colors.red, context);
      }
    } on FirebaseAuthException catch (e) {
      showToast("${e.message}", Colors.red, context);
      emit(GetDataError());
    }
  }

  //Firebase Register with current user data
  Future<void> userRegister(UserModel userModel, context) async {
    emit(GettingData());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password)
          .then((value) =>
              userModel.userID = FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance
          .collection(AppConstants.allStaffCollection)
          .doc(userModel.userID)
          .set(userModel.toJson());
      showToast(
          "User Successfully Registered!", AppColors.primaryColor, context);
      emit(GetDataSuccessful());
    } on FirebaseException catch (error) {
      showToast("Error in RegisterMethod $error", Colors.red, context);
      emit(GetDataError());
    }
  }

  Future<void> userUpdateData(UserModel userModel, context) async {
    emit(GettingData());
    try {
      reAuthUser();
      await FirebaseFirestore.instance
          .collection(AppConstants.allStaffCollection)
          .doc(userModel.userID)
          .update(userModel.toJson());
      showToast("User Successfully Updated!", AppColors.primaryColor, context);
    } on FirebaseException catch (error) {
      showToast("Error in RegisterMethod $error", Colors.red, context);
      emit(GetDataError());
    }
  }

  Future<void> userDeleteData(UserModel userModel, context) async {
    emit(GettingData());
    try {
      reAuthUser();
      await FirebaseFirestore.instance
          .collection(AppConstants.allStaffCollection)
          .doc(userModel.userID)
          .delete();
      await FirebaseFirestore.instance
          .collection(AppConstants.attendanceStaffCollection)
          .doc(userModel.userID)
          .delete();
      await FirebaseFirestore.instance
          .collection(AppConstants.eLeaveStaffCollection)
          .doc(userModel.userID)
          .delete();

      showToast(
          "User Successfully Deleted, for your Security please Login Again",
          AppColors.primaryColor,
          context);
      emit(GetDataSuccessful());
    } on FirebaseException catch (error) {
      showToast("Error in RegisterMethod $error", Colors.red, context);
      emit(GetDataError());
    }
  }

  Future<String> getRegistrationKey(context) async {
    emit(GettingData());
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.usersCollection)
          .doc(AppConstants.PPKstaff)
          .get();
      if (userSnapshot.exists) {
        emit(GetDataSuccessful());
        return userSnapshot.data()![AppConstants.staffKey];
      } else {
        showToast("Error occurred", AppColors.redColor, context);
        emit(GetDataError());
        return "Error";
      }
    } on FirebaseAuthException catch (error) {
      showToast("error $error", AppColors.redColor, context);
      emit(GetDataError());
      return "Error";
    }
  }

  Future<void> updateRegistrationKey(newKey, context) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.usersCollection)
          .doc(AppConstants.PPKstaff)
          .update({AppConstants.staffKey: newKey});

      emit(GetDataSuccessful());
    } on FirebaseAuthException catch (error) {
      showToast("error $error", AppColors.redColor, context);
      emit(GetDataError());
    }
  }

  Future<void> reAuthUser() async {
    await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
            email: FirebaseAuth.instance.currentUser!.email.toString(),
            password: "admin1")); //TODO CHANGE it
  }

  //annoucenment, evemts, attendence, eleave
  // users, -> profile page
  //dashboard ->

  Future<List<Object>> getEventPostsData() async {
    emit(GettingData());
    List<Object> data = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.eventsCollection)
          .get();

      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(AppConstants.eventsCollection)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(EventModel.fromJson(documentSnapshot.data()!));
        }
      }
      emit(GetDataSuccessful());
      return data;
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<void> updateEventPostsData(EventModel eventModel) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.eventsCollection)
          .doc(eventModel.title)
          .update(eventModel.toJson());
      emit(GetDataSuccessful());
    } on FirebaseException {
      emit(GetDataError());
    }
  }

  Future<void> addEventPostsData(EventModel eventModel) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.eventsCollection)
          .doc(eventModel.title)
          .set(eventModel.toJson());
      emit(GetDataSuccessful());
    } on FirebaseException {
      emit(GetDataError());
    }
  }

  Future<void> deleteEventPostsData(EventModel eventModel) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.eventsCollection)
          .doc(eventModel.title)
          .delete();
      emit(GetDataSuccessful());
    } on FirebaseException {
      emit(GetDataError());
    }
  }

//state bloc
  Future<List<Object>> getAnnouncementPostsData() async {
    emit(GettingData());
    List<Object> data = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.announcementCollection)
          .get();

      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(AppConstants.announcementCollection)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(AnnouncementModel.fromJson(documentSnapshot.data()!));
        }
      }
      emit(GetDataSuccessful());
      return data;
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<void> updateAnnouncementPostsData(
      AnnouncementModel announcementModel) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.announcementCollection)
          .doc(announcementModel.title)
          .update(announcementModel.toJson());
      emit(GetDataSuccessful());
    } on FirebaseException {
      emit(GetDataError());
    }
  }

  Future<void> addAnnouncementPostsData(
      AnnouncementModel announcementModel) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.announcementCollection)
          .doc(announcementModel.title)
          .set(announcementModel.toJson());
      emit(GetDataSuccessful());
    } on FirebaseException {
      emit(GetDataError());
    }
  }

  Future<void> deleteAnnouncementPostsData(
      AnnouncementModel announcementModel) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.announcementCollection)
          .doc(announcementModel.title)
          .delete();
      emit(GetDataSuccessful());
    } on FirebaseException {
      emit(GetDataError());
    }
  }

  Future<bool> recordTodayAttendance(
      AttendanceModel attendanceModel, context) async {
    emit(GettingData());
    try {
      String userName = await LocalDataCubit.get(context)
          .getSharedMap(AppConstants.savedUser)
          .then((value) => value['name']);
      await FirebaseFirestore.instance
          .collection(AppConstants.attendanceStaffCollection)
          .doc(userName)
          .collection(AppConstants.attendanceRecordCollection)
          .doc(attendanceModel.dateTime)
          .set(attendanceModel.toJson());

      emit(GetDataSuccessful());
      return true;
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      emit(GetDataError());
      return false;
    }
  }

  // Future<List<EleaveModel>> getTodayStaffEleave() async {
  //   emit(GettingData());
  //   List<EleaveModel> data = [];
  //   try {
  //     final staffSnapshot = await FirebaseFirestore.instance
  //         .collection('/Tabs/eleave/staff/')
  //         .doc()
  //         .collection("eleaveRecord")
  //         .doc()
  //         .get();
  //     print("object");
  //     print("object");
  //     print("object");
  //     print("object");
  //     print("object");
  //     print("object");
  //     print("object");
  //     print(staffSnapshot.reference);
  //     // for (var staffDoc in staffSnapshot.docs) {
  //     //   final eleaveRecordSnapshot = await staffDoc.reference
  //     //       .collection('eleaveRecord')
  //     //       .where('dateTime', isEqualTo: "2024-01-31 16:26:51.384754")
  //     // .get();
  //
  //     // eleaveRecordSnapshot.docs.forEach((doc) {
  //     //   if (doc.exists) {
  //     //     data.add(EleaveModel.fromJson(doc.data()));
  //     //   } else {
  //     //     print(
  //     //         "Document does not exist for staff ID: ${staffDoc.id} and date: ");
  //     //   }
  //     // });
  //     // }
  //
  //     emit(GetDataSuccessful());
  //     return data;
  //   } catch (e) {
  //     print("Error fetching eleave records: $e");
  //     emit(GetDataError());
  //     return [];
  //   }
  // }

  // Future<List<EleaveModel>> getTodayStaffEleave() async {
  //   try {
  //     print("aaaaaaaaaaa");
  //     final querySnapshot = await FirebaseFirestore.instance
  //         // .collection("/Tabs/eleave/staff")
  //         .collection("dashboard/staff/members")
  //         .get();
  //     // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //     //     .collection("/Tabs/eleave/staff/")
  //     //     .get();
  //     List<String> documentNames = [];
  //     QuerySnapshot asd = querySnapshot;
  //     querySnapshot.docs.forEach((doc) {
  //       documentNames.add(doc.id);
  //     });
  //     print("aaaaaaaaaaa");
  //
  //     for (var element in documentNames) {
  //       asd = await FirebaseFirestore.instance
  //           .collection("/Tabs/eleave/staff/")
  //           .doc(element)
  //           .collection("eleaveRecord")
  //           .get();
  //       print("aaaaaaaaaaa");
  //     }
  //     print("aaaaaaaaaaa");
  //     asd.docs.forEach((element) {
  //       print(element.id);
  //       print(element.id);
  //       print(element.id);
  //       print(element.id);
  //     });
  //     print("aaaaaaaaaaa");
  //     print(asd);
  //     print(documentNames);
  //     print(querySnapshot.docs);
  //     return [];
  //   } catch (e) {
  //     print("Error: $e");
  //     return [];
  //   }
  // }

  //   emit(GettingData());
  //   List<EleaveModel> data = [];
  //
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection(AppConstants.eLeaveStaffCollection)
  //         .get();
  //     print(querySnapshot.docs);
  //     for (var element in querySnapshot.docs) {
  //       await FirebaseFirestore.instance
  //           .collection(AppConstants.eLeaveStaffCollection)
  //           .doc(element.id)
  //           .get()
  //           .then((value) => data.add(EleaveModel.fromJson(value.data()!)));
  //     }
  //     emit(GetDataSuccessful());
  //     return data;
  //   } on FirebaseException {
  //     emit(GetDataError());
  //     rethrow;
  //   }
  // }

  Future<List<EleaveModel>> getEleaveStaff() async {
    emit(GettingData());
    List<EleaveModel> data = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.eLeaveStaffCollection)
          .get();

      for (var staffDoc in querySnapshot.docs) {
        final eleaveRecordSnapshot = await staffDoc.reference
            .collection(AppConstants.eLeaveRecordCollection)
            .get();
        eleaveRecordSnapshot.docs.forEach((doc) {
          if (doc.exists &&
              (DateTime.parse(doc.id).day == DateTime.now().day)) {
            data.add(EleaveModel.fromJson(doc.data()));
            return;
          }
        });
      }
      emit(GetDataSuccessful());
      return data;
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<List<UserModel>> getAllStaff(context) async {
    emit(GettingData());
    List<UserModel> data = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.allStaffCollection)
          .get();
      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(AppConstants.allStaffCollection)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(UserModel.fromJson(documentSnapshot.data()!));
        }
      }
      emit(GetDataSuccessful());
      return data;
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<Map<String, DateTime>> getLatestStaffAttendance(context) async {
    emit(GettingData());
    Map<String, DateTime> data = {};

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.attendanceStaffCollection)
          .get();

      for (var element in querySnapshot.docs) {
        data[element.id] = await FirebaseFirestore.instance
            .collection(AppConstants.attendanceStaffCollection)
            .doc(element.id)
            .get()
            .then((value) => DateTime.parse(
                value.data()![AppConstants.lastAttend].toString()));
      }
      emit(GetDataSuccessful());
      return data;
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<List<AttendanceModel>> getUserAttendanceHistory(uid, context) async {
    emit(GettingData());

    List<Object> data = [];

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.attendanceStaffCollection)
          .doc(uid)
          .collection(AppConstants.attendanceRecordCollection)
          .get();
      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(AppConstants.attendanceStaffCollection)
            .doc(uid)
            .collection(AppConstants.attendanceRecordCollection)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(AttendanceModel.fromJson(documentSnapshot.data()!));
        }
      }
      emit(GetDataSuccessful());
      return data.cast<AttendanceModel>().reversed.toList();
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<bool> recordEleaveRequest(EleaveModel eleaveModel, context) async {
    emit(GettingData());
    try {
      String userName = await LocalDataCubit.get(context)
          .getSharedMap(AppConstants.savedUser)
          .then((value) => value['name']);
      await FirebaseFirestore.instance
          .collection(AppConstants.eLeaveStaffCollection)
          .doc(userName)
          .collection(AppConstants.eLeaveRecordCollection)
          .doc(eleaveModel.dateTime)
          .set(eleaveModel.toJson());

      emit(GetDataSuccessful());
      return true;
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      emit(GetDataError());
      return false;
    }
  }

  Future<List<EleaveModel>> getUserEleaveHistory(uid) async {
    emit(GettingData());

    List<Object> data = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.eLeaveStaffCollection)
          .doc(uid)
          .collection(AppConstants.eLeaveRecordCollection)
          .get();

      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(AppConstants.eLeaveStaffCollection)
            .doc(uid)
            .collection(AppConstants.eLeaveRecordCollection)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(EleaveModel.fromJson(documentSnapshot.data()!));
        }
      }

      emit(GetDataSuccessful());
      return data.cast<EleaveModel>().reversed.toList();
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }
}
