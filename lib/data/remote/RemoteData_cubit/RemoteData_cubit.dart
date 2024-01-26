import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/utils/managers/app_constants.dart';
import '../../../domain/Models/UserModel.dart';
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
          .collection(AppConstants.usersCollection)
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

  //Firebase Login with current user data

  Future<void> userLogin(String mail, String pwd, context) async {
    emit(GettingData());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd)
          .then(
              (value) => LocalDataCubit.get(context).updateSharedUser(context));
      showToast("Successful Login", Colors.blue, context);
      emit(GetDataSuccessful());
      NaviCubit.get(context).navigateToHome(context);
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
          .collection(AppConstants.usersCollection)
          .doc(userModel.userID)
          .set(userModel.toJson());
      NaviCubit.get(context).navigateToHome(context);
      emit(GetDataSuccessful());
    } catch (error) {
      showToast("Error in RegisterMethod $error", Colors.red, context);
      emit(GetDataError());
    }
  }

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

  Future<List<EleaveModel>> getEleaveStaff() async {
    emit(GettingData());
    List<EleaveModel> data = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.eLeaveStaffCollection)
          .get();

      for (var element in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection(AppConstants.eLeaveStaffCollection)
            .doc(element.id)
            .collection(AppConstants.eLeaveRecordCollection)
            .get()
            .then((value) =>
                data.add(EleaveModel.fromJson(value.docs.last.data())));
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

  Future<List<String>> getLatestStaffAttendance(context) async {
    emit(GettingData());
    List<String> data = [];

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.attendanceStaffCollection)
          .get();

      for (var element in querySnapshot.docs) {
        data.add(await FirebaseFirestore.instance
            .collection(AppConstants.attendanceStaffCollection)
            .doc(element.id)
            .get()
            .then(
                (value) => value.data()![AppConstants.lastAttend].toString()));
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
