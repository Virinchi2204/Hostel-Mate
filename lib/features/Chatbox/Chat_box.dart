import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jahnavi/auth/auth_controller.dart';

class MyChat extends StatefulWidget {
  const MyChat({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyChatState createState() => _MyChatState();
}

class HelperFunction {
  // keys
  // these are used to decide if user is logged in or not
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  // saving the data to shared preferences
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  // getting the data from sf
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(
        userLoggedInKey); //this return true if user in shared prferences and false otherwise
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(
        userNameKey); //this return true if user in shared prferences and false otherwise
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(
        userEmailKey); //this return true if user in shared prferences and false otherwise
  }
}

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
    // in the database ; user email, user full name, list of groups the user is active in

    //reference for our collection
    // we create a collection users in firebase
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");

  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");

    //saving user data
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid)..set({
    "fullName": fullName,
    "email": email,
    "groups": [],
    "profilePic": "",
    "uid": uid,
    });
    }

    //getting snapshot os userdata
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
    }

    //get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
    }

    //creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupdocumentReference = await groupCollection.add({
    "groupName": groupName,
    "groupIcon": "",
    "admin": "${id}_$userName",
    //"admin": userName, // creator of group
    "members": [],
    "groupId": "",
    "recentMessage": "",
    "recentMessageSender": "",
    //"userName": userName,
    });
    //update the members
    await groupdocumentReference.update({
    "members": FieldValue.arrayUnion(["${uid}_$userName"]),
    "groupId": groupdocumentReference.id,
    });
    //updating group names in user info
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
    "groups":
    FieldValue.arrayUnion(["${groupdocumentReference.id}_$groupName"])
    });
    }

    //getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
    }

    // getting group admin
  getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
    }

    // get group members
  getGroupMembers(groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot;
    }

    // search groups
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
    }

    // checks if user in group
  Future<bool> isUserJoined(
    String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
    return true;
    } else {
    return false;
    }
    }

    // toggling the group join or exit
  Future toggleGroupJoin(
    String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
    await userDocumentReference.update({
    "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
    });
    await groupDocumentReference.update({
    "members": FieldValue.arrayRemove(["${uid}_$userName"])
    });
    } else {
    await userDocumentReference.update({
    "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
    });
    await groupDocumentReference.update({
    "members": FieldValue.arrayUnion(["${uid}_$userName"])
    });
    }
    }

    // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
    "recentMessage": chatMessageData['message'],
    "recentMessageSender": chatMessageData['sender'],
    "recentMessageTime": chatMessageData['time'].toString(),
    });
    }
    }
    const TextInputDecoration = InputDecoration(
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ));

void nextScreen(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }

void nextScreenReplace(context, page) {
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => page));
    }

void showSnackBar(context, color, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
    message,
    style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 5),
    action: SnackBarAction(
    label: "OK",
    onPressed: () {},
    textColor: Colors.white,
    ),
    ));
    }

    String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
    }

    String getId(String res) {
    return res.substring(
    0, res.indexOf("_")); // id before underscore and name after underscore
    }

class GroupInfo extends StatefulWidget {
    final String groupId;
    final String groupName;
    final String adminName;
    GroupInfo(
    {Key? key,
    required this.groupId,
    required this.groupName,
    required this.adminName})
        : super(key: key);
    @override
    State<GroupInfo> createState() => _GroupInfoState();
    }

class _GroupInfoState extends State<GroupInfo> {
    @override
    Stream? members;
    void initState() {
    getMembers();
    super.initState();
    }

    getMembers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((value) {
    setState(() {
    members = value;
    });
    });
    }

    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Theme.of(context).primaryColor,
    title: const Text("Group Info"),
    actions: [
    IconButton(
    onPressed: () {
    showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
    return AlertDialog(
    title: Text("EXIT"),
    content: Text("Are you sure you want to exit the group?"),
    actions: [
    IconButton(
    onPressed: () {
    Navigator.pop(context);
    },
    icon: const Icon(
    Icons.cancel,
    color: Colors.red,
    )),
    IconButton(
    onPressed: () async {
    DatabaseService(
    uid: FirebaseAuth
        .instance.currentUser!.uid)
        .toggleGroupJoin(
    widget.groupId,
    getName(widget.adminName),
    widget.groupName)
        .whenComplete(() {
    nextScreenReplace(context, const MyChat());
    });
    },
    icon: const Icon(
    Icons.done,
    color: Colors.green,
    ))
    ],
    );
    });
    },
    icon: Icon(Icons.exit_to_app),
    )
    ],
    ),
    body: Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(children: [
    Container(
    padding: const EdgeInsets.all(30),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Theme.of(context).primaryColor.withOpacity(0.2)),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    CircleAvatar(
    radius: 30,
    backgroundColor: Theme.of(context).primaryColor,
    child: Text(
    widget.groupName.substring(0, 1).toUpperCase(),
    style: const TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    ),
    ),
    ),
    const SizedBox(
    width: 20,
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Group: ${widget.groupName}",
    style: const TextStyle(fontWeight: FontWeight.w500)),
    const SizedBox(
    height: 5,
    ),
    Text("Admin : ${getName(widget.adminName)}")
    ],
    )
    ],
    ),
    ),
    memberList()
    ]),
    ),
    );
    }

    memberList() {
    return StreamBuilder(
    stream: members,
    builder: (context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
    if (snapshot.data['members'] != null) {
    if (snapshot.data['members'].length != 0) {
    return ListView.builder(
    itemCount: snapshot.data['members'].length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
    return Container(
    padding: const EdgeInsets.symmetric(
    horizontal: 5, vertical: 10),
    child: ListTile(
    leading: CircleAvatar(
    radius: 30,
    backgroundColor: Theme.of(context).primaryColor,
    child: Text(
    getName(snapshot.data['members'][index])
        .substring(0, 1)
        .toUpperCase(),
    style: const TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.bold),
    ),
    ),
    title: Text(getName(snapshot.data['members'][index])),
    subtitle: Text(getId(snapshot.data['members'][index])),
    ),
    );
    },
    );
    } else {
    return const Center(
    child: Text("NO MEMBERS"),
    );
    }
    } else {
    return const Center(
    child: Text("NO MEMBERS"),
    );
    }
    } else {
    return Center(
    child: CircularProgressIndicator(
    color: Theme.of(context).primaryColor,
    ),
    );
    }
    });
    }
    }

class SearchPage extends StatefulWidget {
    const SearchPage({super.key});

    @override
    State<SearchPage> createState() => _SearchPageState();
    }

    class ChatPage extends StatefulWidget {
    final String groupId;
    final String groupName;
    final String userName;
    ChatPage(
    {Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName})
        : super(key: key);
    @override
    State<ChatPage> createState() => _ChatPageState();
    }

class _ChatPageState extends State<ChatPage> {
    Stream<QuerySnapshot>? chats;
    String admin = "";
    TextEditingController messageController = TextEditingController();

    @override
    void initState() {
    getChatandAdmin();
    super.initState();
    }

    getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((value) {
    setState(() {
    chats = value;
    });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((value) {
    setState(() {
    admin = value;
    });
    });
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    centerTitle: true,
    elevation: 0,
    title: Text(widget.groupName),
    backgroundColor: Theme.of(context).primaryColor,
    actions: [
    IconButton(
    onPressed: () {
    nextScreen(
    context,
    GroupInfo(
    groupId: widget.groupId,
    groupName: widget.groupName,
    adminName: admin,
    ));
    },
    icon: const Icon(Icons.info))
    ],
    ),
    body: Stack(
    children: <Widget>[
    chatMessages(),
    Container(
    alignment: Alignment.bottomCenter,
    width: MediaQuery.of(context).size.width,
    child: Container(
    padding:
    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    width: MediaQuery.of(context).size.width,
    color: Colors.grey[700],
    child: Row(children: [
    Expanded(
    child: TextFormField(
    controller: messageController,
    style: TextStyle(color: Colors.white),
    decoration: const InputDecoration(
    hintText: "Send a message..",
    hintStyle:
    TextStyle(color: Colors.white, fontSize: 16),
    border: InputBorder.none,
    ))),
    const SizedBox(
    width: 12,
    ),
    GestureDetector(
    onTap: () {
    sendMessage();
    },
    child: Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
    color: Theme.of(context).primaryColor,
    borderRadius: BorderRadius.circular(30),
    ),
    child: const Center(
    child: Icon(
    Icons.send,
    color: Colors.white,
    )),
    ),
    )
    ]),
    ))
    ],
    ),
    );
    }

    chatMessages() {
    return StreamBuilder(
    stream: chats,
    builder: (context, AsyncSnapshot snapshot) {
    return snapshot.hasData
    ? ListView.builder(
    itemCount: snapshot.data.docs.length,
    itemBuilder: (context, index) {
    return MessageTile(
    message: snapshot.data.docs[index]['message'],
    sender: snapshot.data.docs[index]['sender'],
    sentByMe: widget.userName ==
    snapshot.data.docs[index]['sender']);
    },
    )
        : Container();
    },
    );
    }

    sendMessage() {
    if (messageController.text.isNotEmpty) {
    Map<String, dynamic> chatMessageMap = {
    "message": messageController.text,
    "sender": widget.userName,
    "time": DateTime.now().millisecondsSinceEpoch,
    };

    DatabaseService().sendMessage(widget.groupId, chatMessageMap);
    setState(() {
    messageController.clear();
    });
    }
    }
    }

class _SearchPageState extends State<SearchPage> {
    TextEditingController searchController = TextEditingController();
    bool isLoading = false;
    QuerySnapshot? searchSnapshot;
    bool hasUserSearched = false;
    String userName = "";
    bool isJoined = false;
    User? user;

    void initState() {
    super.initState();
    getCurrentUserIdandName();
    }

    getCurrentUserIdandName() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
    setState(() {
    userName = value!;
    });
    });
    user = FirebaseAuth.instance.currentUser;
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).primaryColor,
    title: const Text(
    "Search",
    style: TextStyle(
    fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    ),
    body: Column(
    children: [
    Container(
    color: Theme.of(context).primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
    children: [
    Expanded(
    child: TextField(
    controller: searchController,
    style: const TextStyle(color: Colors.white),
    decoration: const InputDecoration(
    border: InputBorder.none,
    hintText: "Search Groups",
    hintStyle:
    TextStyle(color: Colors.white, fontSize: 16),
    ))),
    GestureDetector(
    onTap: () {
    initiateSearchMethod();
    },
    child: Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(40),
    ),
    child: const Icon(
    Icons.search,
    color: Colors.white,
    ),
    ),
    )
    ],
    ),
    ),
    isLoading
    ? Center(
    child: CircularProgressIndicator(
    color: Theme.of(context).primaryColor),
    )
        : groupList(),
    ],
    ));
    }

    initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
    setState(() {
    isLoading = true;
    });
    await DatabaseService()
        .searchByName(searchController.text)
        .then((snapshot) {
    setState(() {
    searchSnapshot = snapshot;
    isLoading = false;
    hasUserSearched = true;
    });
    });
    }
    }

    groupList() {
    return hasUserSearched
    ? ListView.builder(
    shrinkWrap: true,
    itemCount: searchSnapshot!.docs.length,
    itemBuilder: (context, index) {
    return groupTile(
    userName,
    searchSnapshot!.docs[index]['groupId'],
    searchSnapshot!.docs[index]['groupName'],
    searchSnapshot!.docs[index]['admin'],
    );
    },
    ) : Container();
    }

    joinedOrNot(
    String userName, String groupId, String groupName, String admin) async {
    await DatabaseService(uid: user!.uid)
        .isUserJoined(groupName, groupId, userName)
        .then((value) {
    setState(() {
    isJoined = value;
    });
    });
    }

    Widget groupTile(
    String userName, String groupId, String groupName, String admin) {
    // function to check if user already exists in group
    joinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    leading: CircleAvatar(
    radius: 30,
    backgroundColor: Theme.of(context).primaryColor,
    child: Text(
    groupName.substring(0, 1).toUpperCase(),
    style: const TextStyle(color: Colors.white),
    ),
    ),
    title:
    Text(groupName, style: const TextStyle(fontWeight: FontWeight.w600)),
    subtitle: Text("Admin: ${getName(admin)}"),
    trailing: InkWell(
    onTap: () async {
    await DatabaseService(uid: user!.uid)
        .toggleGroupJoin(groupId, userName, groupName);
    if (isJoined) {
    setState(() {
    isJoined = !isJoined;
    });
    // somehow not showing snack bar. 3: 30 around in the
    showSnackBar(
    context, Colors.green, "Successfully joined the group");
    Future.delayed(const Duration(seconds: 2), () {
    nextScreen(
    context,
    ChatPage(
    groupId: groupId,
    groupName: groupName,
    userName: userName));
    });
    } else {
    setState(() {
    isJoined = !isJoined;
    showSnackBar(context, Colors.red, "Left the group $groupName");
    });
    }
    },
    child: isJoined
    ? Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.black,
    border: Border.all(color: Colors.white, width: 1),
    ),
    padding:
    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: const Text(
    "Joined",
    style: TextStyle(color: Colors.white),
    ),
    )
        : Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Theme.of(context).primaryColor,
    border: Border.all(color: Colors.white, width: 1),
    ),
    padding:
    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: const Text(
    "Join",
    style: TextStyle(color: Colors.white),
    ),
    ),
    ),
    );
    }
    }

class _MyChatState extends State<MyChat> {
    String userName = "";
    String email = "";
    //AuthService authService = AuthService();
    Stream? groups;
    bool _isLoading = false;
    String groupName = "";

    @override
    void initState() {
    super.initState();
    gettingUserData();
    }

    gettingUserData() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
    setState(() {
    email = value!;
    });
    });
    await HelperFunction.getUserNameFromSF().then((value) {
    setState(() {
    userName = value!;
    });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
    setState(() {
    groups = snapshot;
    });
    });
    }

    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    actions: [
    IconButton(
    onPressed: () {
    nextScreen(context, const SearchPage());
    },
    icon: const Icon(Icons.search))
    ],
    elevation: 0,
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(
    "Groups",
    style: TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
    ),
    ),
    body: groupList(),
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    popUpDialog(context);
    },
    elevation: 0,
    backgroundColor: Theme.of(context).primaryColor,
    child: const Icon(
    Icons.add,
    color: Colors.white,
    size: 30,
    ),
    ),
    );
    }

    popUpDialog(BuildContext context) {
    showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
    return StatefulBuilder(builder: ((context, setState) {
    return AlertDialog(
    title: const Text(
    "Create a group",
    textAlign: TextAlign.left,
    ),
    content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    _isLoading == true
    ? Center(
    child: CircularProgressIndicator(
    color: Theme.of(context).primaryColor),
    )
        : TextField(
    onChanged: (value) {
    setState(() {
    groupName = value;
    });
    },
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Theme.of(context).primaryColor),
    borderRadius: BorderRadius.circular(20)),
    errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(20)),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Theme.of(context).primaryColor),
    borderRadius: BorderRadius.circular(20))),
    ),
    ],
    ),
    actions: [
    ElevatedButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).primaryColor),
    child: const Text("CANCEL")),
    ElevatedButton(
    onPressed: () {
    if (groupName != "") {
    setState(() {
    _isLoading = true;
    });
    DatabaseService(
    uid: FirebaseAuth.instance.currentUser!.uid)
        .createGroup(userName,
    FirebaseAuth.instance.currentUser!.uid, groupName)
        .whenComplete(() {
    _isLoading = false;
    });
    Navigator.of(context).pop();
    showSnackBar(
    context, Colors.green, "Group created succesfully");
    }
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).primaryColor),
    child: const Text("CREATE")),
    ],
    );
    }));
    },
    );
    }

    groupList() {
    return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('groups')
        .doc()
        .snapshots(),
    builder: (context, AsyncSnapshot snapshot) {
    //make some checks
    if (snapshot.hasData) {
    if (snapshot.data['groups'] != null) {
    if (snapshot.data['groups'].length != 0) {
    //return group tile
    return ListView.builder(
    itemCount: snapshot.data['groups'].length,
    itemBuilder: (context, index) {
    // to display the most recently added group at the top
    int reverseIndex =
    snapshot.data['groups'].length - index - 1;
    return GroupTile(
    groupId: getId(snapshot.data['groups'][reverseIndex]),
    groupName: getName(snapshot.data['groups'][reverseIndex]),
    UserName: snapshot.data['fullName']);
    },
    );
    } else {
    return noGroupWidget();
    }
    } else {
    return noGroupWidget();
    }
    } else {
    return Center(
    child: CircularProgressIndicator(
    color: Theme.of(context).primaryColor),
    );
    }
    });
    }

    noGroupWidget() {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    GestureDetector(
    onTap: () {
    popUpDialog(context);
    },
    child: Icon(Icons.add_circle, color: Colors.grey[700], size: 75)),
    const SizedBox(
    height: 20,
    ),
    const Text(
    "You've not joined any group. tap on the add icon to create new group or search for existing groups at the top.",
    textAlign: TextAlign.center,
    )
    ],
    ),
    );
    }
    }

// WIDGETS
// group tile
class GroupTile extends StatefulWidget {
    final String UserName;
    final String groupId;
    final String groupName;
    GroupTile(
    {Key? key,
    required this.groupId,
    required this.groupName,
    required this.UserName})
        : super(key: key);
    @override
    State<GroupTile> createState() => _GroupTileState();
    }

class _GroupTileState extends State<GroupTile> {
    @override
    Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
    nextScreen(
    context,
    ChatPage(
    groupId: widget.groupId,
    groupName: widget.groupName,
    userName: widget.UserName));
    },
    child: Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    child: ListTile(
    leading: CircleAvatar(
    backgroundColor: Theme.of(context).primaryColor,
    radius: 30,
    child: Text(widget.groupName.substring(0, 1).toUpperCase(),
    textAlign: TextAlign.center,
    style: const TextStyle(
    color: Colors.white, fontWeight: FontWeight.w500)),
    ),
    title: Text(
    widget.groupName,
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
    "Join the conversation as ${widget.UserName}",
    style: const TextStyle(fontSize: 13),
    ),
    ),
    ),
    );
    }
    }

// message tile
class MessageTile extends StatefulWidget {
    final String message;
    final String sender;
    final bool sentByMe;
    MessageTile(
    {Key? key,
    required this.message,
    required this.sender,
    required this.sentByMe})
        : super(key: key);

    @override
    State<MessageTile> createState() => _MessageTileState();
    }

class _MessageTileState extends State<MessageTile> {
    @override
    Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.only(
    top: 4,
    bottom: 4,
    left: widget.sentByMe ? 0 : 24,
    right: widget.sentByMe ? 24 : 0),
    alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
    margin: widget.sentByMe
    ? const EdgeInsets.only(left: 30)
        : const EdgeInsets.only(right: 30),
    padding:
    const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
    decoration: BoxDecoration(
    borderRadius: widget.sentByMe
    ? const BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    )
        : const BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    bottomRight: Radius.circular(20),
    ),
    color: widget.sentByMe
    ? Theme.of(context).primaryColor
        : Colors.grey[700]),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    widget.sender.toUpperCase(),
    textAlign: TextAlign.center,
    style: const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: -0.5),
    ),
    const SizedBox(
    height: 8,
    ),
    Text(
    widget.message,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 16, color: Colors.white),
    ),
    ],
    ),
    ),
    );
    }
    }

// widgets