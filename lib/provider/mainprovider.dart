import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Models/Favoritemodel.dart';
import '../Models/Ordermodel.dart';
import '../Models/appointmentModel.dart';
import '../Models/categorymodel.dart';
import '../Models/itemModel.dart';
import '../Models/mainCategoryModel.dart';
import '../Models/notificationmodel.dart';
import '../Models/problemmodel.dart';
import '../Models/reviewmodel.dart';
import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import 'loginProvider.dart';

class MainProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Reference ref = FirebaseStorage.instance.ref("Images");


  TextEditingController mainNamecontroller = TextEditingController();
  File? mainfileImage;
  String mainimageUrl = "";
  List<mainCategorymodel> mainCategorylist = [];

  List<Categorymodel> categoryList = [];

  Future<void> addMainCategory(
      String from, String selectid, BuildContext context) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String, Object> addMainMap = HashMap();
    addMainMap["NAME"] = mainNamecontroller.text;
    addMainMap["TIME"] = DateTime.now();
    addMainMap["ADDED_BY"] = "";
    // if (from == "NEW") {
    addMainMap["MAIN_CATEGORY_ID"] = id;

    // }

    if (mainfileImage != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();

      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(mainfileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          addMainMap["PHOTO"] = value;
          // categorymap["id photo"] = photoId;
          //  editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      addMainMap['PHOTO'] = mainimageUrl;
      // editMap['IMAGE_URL']imageUrl;
    }

    // if (from == "NEW") {
    db.collection("MAIN_CATEGORY").doc(id).set(addMainMap);
    // getCategory();
    finish(context);
    // }
    // else {
    //   db.collection("CATEGORY").doc(selectid).update(addMap);
    // }

    notifyListeners();
  }

  void mainSetImage(File imagee) {
    mainfileImage = imagee;

    notifyListeners();
  }

  Future getMainImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // setImage(File(pickedImage.path));
      mainCropImage(pickedImage.path);
      // print("hjkl"+pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future getMainImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // print("dfghjk"+pickedImage.path);
      mainCropImage(pickedImage.path);
      // setImage(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  Future<void> mainCropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      mainfileImage = File(croppedFile.path);
      notifyListeners();
    }
  }

  void getMainCategory() {
    db.collection("MAIN_CATEGORY").get().then((value) {
      if (value.docs.isNotEmpty) {
        mainCategorylist.clear();
        for (var value in value.docs) {
          mainCategorylist.add(mainCategorymodel(
              value.get("PHOTO"), value.get("NAME"), value.id));
          notifyListeners();
          // print(Categorylist.length.toString()+"xyz");
          // print(Categorylist.length.toString()+"xyz");
        }
      }
    });
  }

  void clearMaincategory() {
    mainNamecontroller.clear();
    mainfileImage = null;
    mainimageUrl = "";
  }

  // ============================================

  TextEditingController namecontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  File? fileImage;
  String imageUrl = "";
  List<Categorymodel> Categorylist = [];

  String productSelectedCategoryID = "";

  Future<void> addCategory(
      String from, String selectid, BuildContext context) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String, Object> addMap = HashMap();
    addMap["NAME"] = namecontroller.text;
    addMap["MAIN_CATEGORY"] = categorycontroller.text;
    addMap["MAIN_CATEGORY_ID"] = productSelectedCategoryID;
    addMap["TIME"] = DateTime.now();
    addMap["ADDED_BY"] = "";
    if (from == "NEW") {
      addMap["CATEGORY_ID"] = id;
    }

    if (fileImage != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();

      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(fileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          addMap["PHOTO"] = value;
          // categorymap["id photo"] = photoId;
          //  editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      addMap['PHOTO'] = imageUrl;
      // editMap['IMAGE_URL']imageUrl;
    }

    if (from == "NEW") {
      db.collection("CATEGORY").doc(id).set(addMap);
      getCategory();
    } else {
      db.collection("CATEGORY").doc(selectid).update(addMap);
    }

    notifyListeners();
  }

  void setImage(File imagee) {
    fileImage = imagee;

    notifyListeners();
  }

  Future getImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // setImage(File(pickedImage.path));
      cropImage(pickedImage.path);
      // print("hjkl"+pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future getImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // print("dfghjk"+pickedImage.path);
      cropImage(pickedImage.path);
      // setImage(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileImage = File(croppedFile.path);
      notifyListeners();
    }
  }

  void getCategory() {
    db.collection("CATEGORY").get().then((value) {
      if (value.docs.isNotEmpty) {
        Categorylist.clear();
        for (var value in value.docs) {
          Categorylist.add(Categorymodel(value.get("PHOTO"), value.get("NAME"),
              value.id, value.get("MAIN_CATEGORY_ID")));
          notifyListeners();
          // print(Categorylist.length.toString()+"xyz");
          // print(Categorylist.length.toString()+"xyz");
        }
      }
    });
  }

  void editcategory(String Cid) {
    db.collection("CATEGORY").doc(Cid).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map1 = value.data() as Map;
        categorycontroller.text = map1["MAIN_CATEGORY"].toString();
        categorycontroller.text = map1["MAIN_CATEGORY_ID"].toString();
        namecontroller.text = map1["NAME"].toString();
        imageUrl = map1["PHOTO"].toString();
        fileImage = null;

        notifyListeners();
      }
    });
  }

  void deletecategory(selectedid, BuildContext context) {
    db.collection("CATEGORY").doc(selectedid).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Deleted successfully"),
      backgroundColor: maincolor,
    ));
    getCategory();
    notifyListeners();
  }

  void clearcategory() {
    namecontroller.clear();
    fileImage = null;
    imageUrl = "";
  }

  List<String> Carosuelimg = [
    "assets/decoration.png",
    "assets/stage.png",
    "assets/stage2.png",
  ];
  int indextab = 0;

  int Activeindex = 0;

  void activeIndex(int index) {
    Activeindex = index;
    notifyListeners();
  }

  void tabIndex(int value) {
    indextab = value;
    notifyListeners();
    print(indextab);
  }

// this is over add category

  String productSelectedItemID = " ";
  String productSelectedItemid = " ";

  TextEditingController itemNameController = TextEditingController();
  File? itemFileImage;
  String itemImageUrl = "";
  TextEditingController itemRateController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController itemsController = TextEditingController();

  List<itemModel> itemList = [];

  Future<void> addItem(
      String from, String selectid, BuildContext context) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String, Object> addItemMap = HashMap();
    addItemMap["NAME"] = itemNameController.text;
    addItemMap["RATE"] = itemRateController.text;
    addItemMap["CATEGORY"] = itemController.text;
    addItemMap["MAIN_CATEGORY"] = itemsController.text;

    addItemMap["TIME"] = DateTime.now();
    addItemMap["ADDED_BY"] = "";
    if (from == "NEW") {
      addItemMap["CATEGORY_ID"] = productSelectedItemID;
      addItemMap["ITEM_ID"] = id;
      addItemMap["MAIN_CATEGORY_ID"] = productSelectedItemid;
      notifyListeners();
    } else if (from == "EDIT") {
      addItemMap["ITEM_ID"] = productSelectedItemID;
    }

    if (itemFileImage != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();

      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(itemFileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          addItemMap["PHOTO"] = value;
          // categorymap["id photo"] = photoId;
          //  editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
      print("true");
    } else {
      addItemMap['PHOTO'] = itemImageUrl;
      // editMap['IMAGE_URL']imageUrl;
    }
    if (from == "NEW") {
      db.collection("ITEM").doc(id).set(addItemMap);
      notifyListeners();
      finish(context);
    } else {
      db.collection("ITEM").doc(selectid).update(addItemMap);
    }
  }

  Future itemGetImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // setImage(File(pickedImage.path));
      itemCropImage(pickedImage.path);
      // print("hjkl"+pickedImage.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  Future itemGetImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      print("dfghjk" + pickedImage.path);
      itemCropImage(pickedImage.path);
      // setImage(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  Future<void> itemCropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      itemFileImage = File(croppedFile.path);
      notifyListeners();
    }
  }

  void getItem() {
    db.collection("ITEM").get().then((value) {
      if (value.docs.isNotEmpty) {
        itemList.clear();
        for (var value in value.docs) {
          itemList.add(itemModel(
              value.get("PHOTO"),
              value.get("NAME"),
              value.id,
              value.get("RATE"),
              value.get("MAIN_CATEGORY_ID"),
              value.get("CATEGORY_ID")));
          notifyListeners();
          // print(Categorylist.length.toString()+"xyz");
          // print(Categorylist.length.toString()+"xyz");
        }
        notifyListeners();
      }
      notifyListeners();
    });
  }

  void editItem(String Tid) {
    db.collection("ITEM").doc(Tid).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map2 = value.data() as Map;

        productSelectedItemID = map2["ITEM_ID"].toString();
        productSelectedItemid = map2["MAIN_CATEGORY_ID"].toString();
        itemsController.text = map2["MAIN_CATEGORY"].toString();
        itemNameController.text = map2["NAME"].toString();
        itemRateController.text = map2["RATE"].toString();
        itemImageUrl = map2["PHOTO"].toString();

        notifyListeners();
      }
    });
  }

  void deleteItem(selectid, BuildContext context) {
    db.collection("ITEM").doc(selectid).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Deleted successfully"),
      backgroundColor: maincolor,
    ));
    getCategory();
    notifyListeners();
  }

  void clearItem() {
    itemNameController.clear();
    itemRateController.clear();
    itemFileImage = null;
    itemImageUrl = "";
  }

  // this is over add item

  TextEditingController userNameController = TextEditingController();
  TextEditingController userAddresController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();

  Future<void> AddUsers(String From, String profileid) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> customermap = HashMap();
    customermap["NAME"] = userNameController.text.toString();
    customermap["ADDRESS"] = userAddresController.text.toString();
    customermap["PHONE"] = userPhoneController.text.toString();
    // customermap["ADDED_TIME"] = DateTime.now();
    // customermap["ADDED_BY"] = "";

    HashMap<String, Object> usermap = HashMap();

    usermap["NAME"] = userNameController.text.toString();
    usermap["TYPE"] = "USER";
    usermap["PHONE"] = "+91${userPhoneController.text}";
    if (From == "NEW") {
      usermap["USER_ID"] = id;
      customermap["CUSTOMER_ID"] = id;
    }

    if (profilimage != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();

      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(profilimage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          customermap["PHOTO"] = value;
          // categorymap["id photo"] = photoId;
          //  editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }
    if (From == "NEW") {
      db.collection("USER").doc(id).set(usermap);
    } else {
      print(profileid + "djhhfhfh");
      db.collection("CUSTOMERS").doc(profileid).update(customermap);

      db.collection("USER").doc(profileid).update(usermap);
    }

    getUser();
  }

  String name = "";
  String id = "";
  String address = "";
  String phone = "";
  String photo = "";

  void getUser() {
    db.collection("CUSTOMERS").get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var value in value.docs) {
          Map<String, dynamic> map = value.data();
          id = value.id;
          name = map["NAME"].toString();
          phone = map["PHONE"].toString();
          address = map["ADDRESS"].toString();
          photo = map["PHOTO"] ?? "";

          userNameController.text = name;
          userPhoneController.text = phone;
          userAddresController.text = address;
          // usersList.add(usersModel(
          //     value.get("Name"), value.get("Addres"), value.id,
          //     value.get("Phone")));
          notifyListeners();
        }
        notifyListeners();
      }
      notifyListeners();
    });
  }

  File? profilimage;
  String profilimageurl = "";

  Future profilImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // setImage(File(pickedImage.path));
      profilcropImage(pickedImage.path);
      // print("hjkl"+pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future profilImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // print("dfghjk"+pickedImage.path);f
      profilcropImage(pickedImage.path);
      // setImage(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  Future<void> profilcropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      profilimage = File(croppedFile.path);
      notifyListeners();
    }
  }

  void clearUsers() {
    userNameController.clear();
    userAddresController.clear();
    userPhoneController.clear();
  }

// this is over registration and get profile

  TextEditingController orderNamecontroller = TextEditingController();
  TextEditingController orderTimecontroller = TextEditingController();
  TextEditingController orderDatecontroller = TextEditingController();
  TextEditingController ordertypecontroller = TextEditingController();
  TextEditingController orderGustcontroller = TextEditingController();
  TextEditingController orderAddresscontroller = TextEditingController();
  List<appointmentModel> appointmentList = [];
  List<orderdetails> orderList = [];

  Future<void> addOrder(
      String userid, List itemid, BuildContext context) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> orderMap = HashMap();
    // HashMap<String, Object> orderitemMap = HashMap();
    orderMap["NAME"] = orderNamecontroller.text.toString();
    orderMap["TIME"] = orderTimecontroller.text.toString();
    orderMap["DATE"] = orderDatecontroller.text.toString();
    orderMap["TYPE"] = ordertypecontroller.text.toString();
    orderMap["GUST"] = orderGustcontroller.text.toString();
    orderMap["ADDRESS"] = orderAddresscontroller.text.toString();
    orderMap["ORDER_ID"] = id;
    orderMap["STATUS"] = "Requested";
    orderMap["USER_ID"] = userid;
    orderMap["ITEM_ID"] = itemid;

    db.collection("ORDER_DETAILS").doc(id).set(orderMap);
    db
        .collection("FAVORITE")
        .where("USER_ID", isEqualTo: userid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          print("hajjajsjjs" + element.id);
          db.collection("FAVORITE").doc(element.id).delete();
          favoriteList.clear();
        }
      }
    });
    print("adminmnffffff" + fcmid);
    print("hshssh" + orderMap["NAME"].toString());

    callOnFcmApiSendPushNotifications(
      title: "order",
      body: orderMap["NAME"].toString() + "Your booking has been requested",
      fcmId: fcmid,
      // "fD9UmRu2SaeRewttQ_U97z:APA91bH4whcuTzU7PsnMsXDPrEloe_iOggAnXVY7ZdhgpS7rzJKTuQJtVBprzzIK5Im-TlUFO9IRL_7yancUW0XooLDk3ACqSV-QxyJ4N3xHuZXVgeW-l32sD-u22pIpCeaCc9Eum3WG",
      imageLink: "",
    );
    print("sxvsanxcv");

    notifyListeners();
  }

  List<String> itemid = [];
  void getallitems(String userid) {
    itemid.clear();
    db
        .collection("FAVORITE")
        .where("USER_ID", isEqualTo: userid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          itemid.add(element.get("ITEM_ID"));
          notifyListeners();
        }
      }
    });
  }
  // void getOrder() {
  //   db.collection("ORDER_DETAILS").get().then((value) {
  //     if (value.docs.isNotEmpty) {
  //       orderList.clear();
  //       for (var value in value.docs) {
  //         orderList.add(appointmentModel(
  //             value.get("NAME").toString(),
  //             value.get("TIME").toString(),
  //             value.get("DATE").toString(),
  //             value.get("TYPE").toString(),
  //             value.get("GUST").toString(),
  //             value.get("ADDRESS").toString(),
  //           value.id,
  //             value.get("STATUS").toString(),
  //
  //
  //         ));
  //         notifyListeners();
  //       }
  //     }
  //     notifyListeners();
  //   });
  // }
  // void getuserorder(String userId){
  //
  //   db.collection("ORDER_DETAILS").where("USER_ID",isEqualTo: userId).get().then((value) {
  //     if(value.docs.isNotEmpty){
  //       orderList.clear();
  //       for (var elements in value.docs) {}}
  //   });
  // }
  // void getadminorder() {
  //   List<String> itemidList=[];
  //   String name = '';
  //   String photo = '';
  //   String rate = '';
  //
  //   orderList.clear();
  //
  //   db.collection("ORDER_DETAILS").get().then((value) {
  //
  //     // print("bhbhhnjm ");
  //     if (value.docs.isNotEmpty) {
  //
  //       for (var elements in value.docs) {
  //         orderList.clear();
  //         Map<String, dynamic> ordermap = elements.data();
  //         // productid=ordermap["PRODUCT_ID"];
  //         for (var kk in ordermap["ITEM_ID"]) {
  //           itemidList.add(kk);
  //           notifyListeners();
  //
  //           print(itemidList.length.toString()+"ckjnv jjv");
  //         }
  //         db
  //             .collection("ITEM")
  //             .where("ITEM_ID", whereIn: itemidList)
  //             .get()
  //             .then((val) {
  //           itemidList.clear();
  //
  //           if (val.docs.isNotEmpty) {
  //             for (var elem in val.docs) {
  //               name = elem.get("NAME").toString();
  //               photo = elem.get("PHOTO").toString();
  //               rate = elem.get("RATE").toString();
  //
  //               orderList.add(orderdetails(
  //                   name,
  //                   photo,
  //                   rate,
  //                   ordermap["NAME"].toString(),
  //                   ordermap["TIME"].toString(),
  //                   ordermap["DATE"].toString(),
  //                   // DateFormat("hh:mm a").format(ordermap["TIME"].toDate()).toString(),
  //                   // DateFormat("dd-MM-yyyy").format(ordermap["DATE"].toDate()).toString(),
  //                   ordermap["TYPE"].toString(),
  //                   ordermap["GUST"],
  //                   ordermap["ADDRESS"].toString(),
  //                   ordermap["ORDER_ID"].toString(),
  //
  //                   ordermap["STATUS"].toString()));
  //               // filterorders = orders;
  //               notifyListeners();
  //               print(orderList.length.toString()+"ckvncvjhmnb");
  //
  //             }
  //           }
  //           notifyListeners();
  //
  //         });
  //
  //       }
  //     }
  //     notifyListeners();
  //     });
  //
  //   }

  void getuserorderdetils(String userId) {
    List<String> itemIdList = [];
    String name = '';
    String photo = '';
    String rate = '';

    db
        .collection("ORDER_DETAILS")
        .where("USER_ID", isEqualTo: userId)
        .get()
        .then((value) {
      print("hnjm bhbh");
      if (value.docs.isNotEmpty) {
        orderList.clear();
        for (var elements in value.docs) {
          Map<String, dynamic> ordermap = elements.data();
          // productid=ordermap["PRODUCT_ID"];
          for (var kk in ordermap["ITEM_ID"]) {
            // print(kk.toString() + "gkkg");
            // print(kk.toString() + "cmmc");
            itemIdList.add(kk);
            notifyListeners();
          }
          print("gfvhewvkjwehfvhe" + itemIdList.toString());
          db
              .collection("ITEM")
              .where("ITEM_ID", whereIn: itemIdList)
              .get()
              .then((val) {
            if (val.docs.isNotEmpty) {
              for (var elem in val.docs) {
                print("jhvbjnvbnvf" + name.toString());

                photo = elem.get("PHOTO").toString();
                name = elem.get("NAME").toString();
                rate = elem.get("RATE").toString();
              }
              orderList.add(orderdetails(
                  name,
                  photo,
                  rate,
                  ordermap["NAME"].toString(),
                  ordermap["TIME"].toString(),
                  ordermap["DATE"].toString(),
                  // DateFormat("hh:mm a").format(ordermap["TIME"].toDate()).toString(),
                  // DateFormat("dd-MM-yyyy").format(ordermap["DATE"].toDate()).toString(),
                  ordermap["TYPE"].toString(),
                  ordermap["GUST"],
                  ordermap["ADDRESS"].toString(),
                  ordermap["ORDER_ID"].toString(),
                  ordermap["STATUS"].toString()));
              notifyListeners();
            }
          });

          notifyListeners();
        }
      }
    });
  }

  void getadminorderdetils() {
    List<String> itemIdList = [];
    String name = '';
    String photo = '';
    String rate = '';
    orderList.clear();

    db.collection("ORDER_DETAILS").get().then((value) {
      print("hnjm bhbh");
      if (value.docs.isNotEmpty) {
        for (var elements in value.docs) {
          Map<String, dynamic> ordermap = elements.data();
          // productid=ordermap["PRODUCT_ID"];
          for (var kk in ordermap["ITEM_ID"]) {
            itemIdList.add(kk);
            notifyListeners();
          }
          // print("gfvhewvkjwehfvhe"+itemIdList.toString());
          db
              .collection("ITEM")
              .where("ITEM_ID", whereIn: itemIdList)
              .get()
              .then((val) {
            if (val.docs.isNotEmpty) {
              for (var elem in val.docs) {
                // print("jhvbjnvbnvf"+name.toString()+itemid.toString());

                photo = elem.get("PHOTO").toString();
                name = elem.get("NAME").toString();
                rate = elem.get("RATE").toString();
              }
              orderList.add(orderdetails(
                  name,
                  photo,
                  rate,
                  ordermap["NAME"].toString(),
                  ordermap["TIME"].toString(),
                  ordermap["DATE"].toString(),
                  // DateFormat("hh:mm a").format(ordermap["TIME"].toDate()).toString(),
                  // DateFormat("dd-MM-yyyy").format(ordermap["DATE"].toDate()).toString(),
                  ordermap["TYPE"].toString(),
                  ordermap["GUST"],
                  ordermap["ADDRESS"].toString(),
                  ordermap["ORDER_ID"].toString(),
                  ordermap["STATUS"].toString()));
              notifyListeners();
            }
          });
          notifyListeners();
        }
      }
    });
  }

  void clearorder() {
    orderNamecontroller.clear();
    orderTimecontroller.clear();
    orderDatecontroller.clear();
    ordertypecontroller.clear();
    orderGustcontroller.clear();
    orderAddresscontroller.clear();
  }

  void acceptStatusUpdate(String id) {
    HashMap<String, Object> Acceptmap = HashMap();
    Acceptmap["STATUS"] = "Accepted";
    Acceptmap["ACCEPTED_TIME"] = DateTime.now();

    db.collection("ORDER_DETAILS").doc(id).update(Acceptmap);

    // print("mnfffjknjnjnfff"+fcmid);
    print("hshssh" + Acceptmap["NAME"].toString());

    callOnFcmApiSendPushNotifications(
      title: "your order is accepted",
      body: Acceptmap["NAME"].toString() + "REQUESTED",
      fcmId: fcmid,
      imageLink: "",
    );

    print("sxvsanxcv");

    notifyListeners();
  }

  void rejectStatusUpdate(String id) {
    HashMap<String, Object> RejectMap = HashMap();
    RejectMap["STATUS"] = "Rejected";
    RejectMap["REJECTED_TIME"] = DateTime.now();
    db.collection("ORDER_DETAILS").doc(id).update(RejectMap);

    print("hnnuinuinuinhui" + fcmid);
    print("hshssh" + RejectMap["NAME"].toString());

    callOnFcmApiSendPushNotifications(
      title: "add order",
      body: RejectMap["NAME"].toString() + "REQUESTED",
      fcmId: fcmid,
      imageLink: "",
    );
    print("sxvsanxcv");

    notifyListeners();
    notifyListeners();
  }

// this is over order page

  TextEditingController reviewController = TextEditingController();
  List<reviewModel> reviewList = [];

  void addReviews(String userId, double rating, String userName) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> reviewMap = HashMap();
    reviewMap["REVIEW"] = reviewController.text.toString();
    reviewMap["RATING"] = rating;
    reviewMap["USER_ID"] = userId;
    reviewMap["USER_NAME"] = userName;
    reviewMap["TIME"] = DateTime.now();
    reviewMap["REVIEW_ID"] = id;
    db.collection("REVIEWS").doc(id).set(reviewMap);
    getReviews();
    getUserPhoto(userId, userName);
    notifyListeners();
  }

  void getReviews() {
    db.collection("REVIEWS").get().then((value) {
      if (value.docs.isNotEmpty) {
        reviewList.clear();
        for (var value in value.docs) {
          reviewList.add(reviewModel(
              value.get("REVIEW").toString(),
              value.get("RATING").toString(),
              value.id,
              value.get("USER_NAME").toString(),
              value.get("USER_ID").toString()));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  String loginphoto = "";
  String loginname = "";

  void getUserPhoto(String userId, String userName) {
    print("dbd");
    db
        .collection("CUSTOMERS")
        .where("USER_ID", isEqualTo: userId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        loginphoto = value.docs.last.get("PHOTO").toString();
        loginname = value.docs.last.get("NAME").toString();
        notifyListeners();
        print("dwg" + loginphoto);
      }
      notifyListeners();
    });
  }

  void deletereview(String selectid, String userid, BuildContext context) {
    db.collection("REVIEWS").doc(selectid).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Deleted successfully"),
      backgroundColor: maincolor,
    ));
    getReviews();
    notifyListeners();
  }

  void clearReview() {
    reviewController.clear();
  }

  String catPhoto = "";
  String catName = "";
  void getusercategory(String mcatId) {
    db
        .collection("CATEGORY")
        .where("MAIN_CATEGORY_ID", isEqualTo: mcatId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        categoryList.clear();
        for (var e in value.docs) {
          categoryList.add(Categorymodel(e.get("PHOTO").toString(),
              e.get("NAME").toString(), e.id, e.get("MAIN_CATEGORY_ID")));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  String itemPhoto = "";
  String itemName = "";
  String itemRate = "";
  void getuseritem(String catId) {
    db
        .collection("ITEM")
        .where("CATEGORY_ID", isEqualTo: catId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        itemList.clear();
        for (var e in value.docs) {
          itemList.add(itemModel(
              e.get("PHOTO").toString(),
              e.get("NAME").toString(),
              e.id,
              e.get("RATE").toString(),
              e.get("MAIN_CATEGORY_ID"),
              e.get("CATEGORY_ID")));
          notifyListeners();
        }
        notifyListeners();
      }
      notifyListeners();
    });
  }

  List<favoriteModels> favoriteList = [];

  void addFavorite(context, String userId, String itemId, String favPhoto,
      String favName, String faveRate) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> favoriteMap = HashMap();
    favoriteMap["USER_ID"] = userId;
    favoriteMap["ITEM_ID"] = itemId;
    favoriteMap["TIME"] = DateTime.now();
    favoriteMap["PHOTO"] = favPhoto;
    favoriteMap["NAME"] = favName;
    favoriteMap["RATE"] = faveRate;
    favoriteMap["FAVORITE_ID"] = id;

    db.collection("FAVORITE").doc(id).set(favoriteMap);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Add to Favorite",
        style: TextStyle(color: maincolor, fontStyle: FontStyle.italic),
      ),
      backgroundColor: Colors.white,
    ));

    getUserFavorite(userId);
    // getUserPhoto(userId, userName);
    notifyListeners();
  }

  void getUserFavorite(String userid) {
    db
        .collection("FAVORITE")
        .where("USER_ID", isEqualTo: userid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        favoriteList.clear();
        for (var value in value.docs) {
          favoriteList.add(favoriteModels(
              value.get("USER_ID").toString(),
              value.get("ITEM_ID").toString(),
              value.get("PHOTO").toString(),
              value.get("NAME").toString(),
              value.get("RATE").toString(),
              value.id));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  // void getAdminFavorite(String userid){
  //   db.collection("FAVORITE").get().then((value) {
  //     if (value.docs.isNotEmpty) {
  //       favoriteList.clear();
  //       for (var value in value.docs) {
  //         favoriteList.add(favoriteModels(
  //             value.get("USER_ID").toString(),
  //             value.get("ITEM_ID").toString(),
  //             value.get("PHOTO").toString(),
  //             value.get("NAME").toString(),
  //             value.get("RATE").toString(),
  //             value.id
  //
  //
  //
  //         ));
  //         notifyListeners();
  //       }
  //     }
  //     notifyListeners();
  //   });
  // }
  void removeFavorite(selectedid, BuildContext context, String userid) {
    db.collection("FAVORITE").doc(selectedid).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Remove in Favorite",
        style: TextStyle(color: maincolor, fontStyle: FontStyle.italic),
      ),
      backgroundColor: Colors.white,
    ));
    getUserFavorite(userid);
    notifyListeners();
  }

  // void deletefavouratelist( itemid, BuildContext context,) {
  //   db.collection("FAVORITE").doc(itemid).delete();
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     content: Text("Remove in Favorite",style: TextStyle(color:maincolor, fontStyle: FontStyle.italic),),
  //     backgroundColor: Colors.white,
  //   )
  //   );
  //   // getUserFavorite(userid);
  //   notifyListeners();
  // }
// void removeAllFavorite(itemid){
//     db.collection("FAVORITE").doc(itemid).delete();
// date picker
  TimeOfDay _time = TimeOfDay.now();
  DateTime _date = DateTime.now();
  DateTime scheduledTime = DateTime.now();
  DateTime scheduledDate = DateTime.now();
  String scheduledDayNode = "";
  var outputDateFormat = DateFormat('dd/MM/yyyy');
  var outputTimeFormat = DateFormat('hh:mm a');
  // TextEditingController dateController = TextEditingController();
  // TextEditingController timeController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _date = picked;
      scheduledDate = DateTime(_date.year, _date.month, _date.day);
      orderDatecontroller.text = outputDateFormat.format(scheduledDate);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null) {
      _time = picked;
      scheduledDayNode = _date.year.toString() +
          '/' +
          _date.month.toString() +
          '/' +
          _date.day.toString();
      scheduledTime = DateTime(
          _date.year, _date.month, _date.day, _time.hour, _time.minute);
      orderTimecontroller.text = outputTimeFormat.format(scheduledTime);
    }
  }

  TextEditingController problemcontroller = TextEditingController();
  List<problemmodel> problemlist = [];

  void addProblems(String userid, String username) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    HashMap<String, Object> problemMap = HashMap();
    problemMap["PROBLEMS"] = problemcontroller.text.toString();
    problemMap["ID"] = id;
    problemMap["USERID"] = userid;
    problemMap["USERNAME"] = username;

    db.collection("PROBLEMS").doc(id).set(problemMap);
    notifyListeners();
  }

  void getproblem() {
    db.collection("PROBLEMS").get().then((value) {
      if (value.docs.isNotEmpty) {
        problemlist.clear();
        for (var value in value.docs) {
          problemlist.add(problemmodel(
            value.get("USERNAME").toString(),
            value.get("PROBLEMS").toString(),
          ));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void clearProblems() {
    problemcontroller.clear();
  }

  List<String> adminFcmList = [];

  // getAdminFcmId(){
  //   db.collection("USER").where("TYPE",isEqualTo: "ADMIN").get().then((event) {
  //     if(event.docs.isNotEmpty){
  //       adminFcmList.clear();
  //       for(var element in event.docs){
  //         Map<dynamic, dynamic> notificationMap = element.data();
  //         adminFcmList.add(notificationMap["FCM_ID"]??"");
  //         notifyListeners();
  //
  //       }
  //     }
  //
  //     });
  //
  // }

  // Future<bool> callOnFcmApiSendPushNotifications(
  //     {required String title,
  //       required String body,
  //       required String fcmList,
  //       required String imageLink}) async {
  //
  //   print(fcmList.toString()+"jnjkmjnjn");
  //   print(fcmList.length.toString()+"viuififi");
  //
  //   Uri posturlGroup = Uri.parse('https://fcm.googleapis.com/fcm/notification');
  //
  //   final headersGroup = {
  //     'content-type': 'application/json',
  //     'Authorization':
  //     'key=AAAARv0MhFg:APA91bFHm5hJzP7K15v959LgSp57dPpCJq1T1KNE4QwO-BfEiXnYAM0-ad3LGjtKe_1xVK4HBB7yHouP2C7TWY6JYi-lsMp6RB_uB7Jn0nT_HRWn8kAfq-hVMTx-lSnsg4hG0GNaS00E',
  //     // '
  //     // key=YOUR_SERVER_KEY'
  //     'project_id': '304893166680'
  //   };
  //   final dataGroup = {
  //     "operation": "create",
  //     "notification_key_name": DateTime.now().toString(),
  //     "registration_ids": fcmList,
  //   };
  //   print("jffffffffffff");
  //   final response1 = await http.post(posturlGroup,
  //       body: json.encode(dataGroup),
  //       encoding: Encoding.getByName('utf-8'),
  //       headers: headersGroup);
  //   print("irrrrrrrrrrrr");
  //   final Map parsed = json.decode(response1.body);
  //   var notificaitonKey = parsed["notification_key"];
  //
  //   print("cbhhhhhhhhhhh");
  //   Uri postUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
  //   final data = {
  //     "to": notificaitonKey,
  //     "notification": {"title": title, "body": body, "image": imageLink},
  //     "data": {
  //       "type": '0rder',
  //       "id": '28',
  //       "click_action": 'FLUTTER_NOTIFICATION_CLICK',
  //     }
  //   };
  //   print("ittttttttteekej");
  //   final headers = {
  //     'content-type': 'application/json',
  //     'Authorization': 'key=AAAARv0MhFg:APA91bFHm5hJzP7K15v959LgSp57dPpCJq1T1KNE4QwO-BfEiXnYAM0-ad3LGjtKe_1xVK4HBB7yHouP2C7TWY6JYi-lsMp6RB_uB7Jn0nT_HRWn8kAfq-hVMTx-lSnsg4hG0GNaS00E',
  //
  //     // 'key=YOUR_SERVER_KEY'
  //   };
  //
  //   final response = await http.post(postUrl,
  //       body: json.encode(data),
  //       encoding: Encoding.getByName('utf-8'),
  //       headers: headers);
  //   print("${response.body} (response)");
  //
  //   if (response.statusCode == 200) {
  //     // on success do sth
  //     print('test ok push CFM');
  //     return true;
  //   } else {
  //     print(' CFM error');
  //     // on failure do sth
  //     return false;
  //   }
  //   }

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String title,
      required String body,
      required String fcmId,
      required String imageLink}) async {
    print(fcmId + "kmfmkfmkmk");

    Uri postUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final data = {
      "to": fcmId,
      // 'fnH1CCX-TluCgNxH2_538v:APA91bHpxAa-laX0GdJvpJIogijEysmDVA7OWV9IEo8MdvRjXFOSv06kY4NyBp-Ar4Q4i2auH3Pki2PJYJlhOlmaHl3XJnlQKmMhmJp98tgInuaH51ZbE_28X4hsOoe-nJU2JDjaqMDI',
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAARv0MhFg:APA91bFHm5hJzP7K15v959LgSp57dPpCJq1T1KNE4QwO-BfEiXnYAM0-ad3LGjtKe_1xVK4HBB7yHouP2C7TWY6JYi-lsMp6RB_uB7Jn0nT_HRWn8kAfq-hVMTx-lSnsg4hG0GNaS00E',
      // 'key=YOUR_SERVER_KEY'cx
      'project_id': '304893166680'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);
    print("${response.body}aaaaaaa");

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }

  // String fcmid='';
  //
  // void getFcm(){
  //   FirebaseMessaging.instance.getToken().then((fcmValue) {
  //
  //     fcmid=fcmValue.toString();
  //     print("yteuweyeywety"+fcmid.toString());
  //   });
  //   notifyListeners();
  // }

  String fcmid = '';

  getAdminFcmId() {
    print("ooaoaoaooa" + fcmid);
    print("kjkndvdknefvlknefv");
    db.collection("USER").where("TYPE", isEqualTo: "ADMIN").get().then((event) {
      if (event.docs.isNotEmpty) {
        print("jsjsjs");
        // fcmid='';
        for (var element in event.docs) {
          Map<dynamic, dynamic> notificationMap = element.data();
          fcmid = notificationMap["FCM_ID"] ?? "";
          notifyListeners();
        }
        print("smncbwndbc");
      }
    });
  }

  getUserFcmId() {
    print("ooaoajhvhgoaooa" + fcmid);
    print("hhhhhh");
    db.collection("USER").where("TYPE", isEqualTo: "USER").get().then((event) {
      if (event.docs.isNotEmpty) {
        print("jsjsjs");
        // fcmid='';
        for (var element in event.docs) {
          Map<dynamic, dynamic> notificationMap = element.data();
          fcmid = notificationMap["FCM_ID"] ?? "";
          notifyListeners();
        }
        print("bhvbhgb");
      }
    });
  }

  List<notificationdetails> notificationlist = [];

  void addNotification(String userid, String username, String title) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    HashMap<String, Object> NotificationMaps = HashMap();
    NotificationMaps["NOTIFICATION"] = title;
    NotificationMaps["NOTIFICATION_ID"] = id;
    NotificationMaps["USERID"] = userid;
    NotificationMaps["USERNAME"] = username;

    db.collection("NOTIFICATION").doc(id).set(NotificationMaps);
    notifyListeners();
  }

  void getNotification(String userid) {
    db
        .collection("FAVORITE")
        .where("USER_ID", isEqualTo: userid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        notificationlist.clear();
        for (var value in value.docs) {
          notificationlist.add(notificationdetails(
            value.get("NOTIFICATION").toString(),
            value.get("NOTIFICATION_ID").toString(),
            value.get("USERID").toString(),
            value.get("USERNAME").toString(),
          ));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }
}
