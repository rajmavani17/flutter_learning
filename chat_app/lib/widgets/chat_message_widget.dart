// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/widgets/message_bubble_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatMessageWidget extends StatelessWidget {
//   ChatMessageWidget({
//     super.key,
//     this.otherUser,
//   });

//   UserModel? otherUser;

//   void checkData() async {
//     final data = FirebaseFirestore.instance
//         .collection('chat')
//         .where('recevier',
//             isEqualTo: otherUser == null ? 'ALLGROUPCHAT' : otherUser!.uid)
//         .orderBy(
//           'created-at',
//           descending: true,
//         )
//         .snapshots();
//     print(data);
//   }

//   @override
//   Widget build(BuildContext context) {
// print(otherUser);
// checkData();
// final user = FirebaseAuth.instance.currentUser!;

// return StreamBuilder(
//   stream: FirebaseFirestore.instance
//       .collection('chat')
//       .where('recevier',whereIn: [otherUser == null ? 'ALLGROUPCHAT' : otherUser!.uid])
//       .orderBy(
//         'created-at',
//         descending: true,
//       )
//       .snapshots(),
//   builder: (context, chatSnapshot) {
//     if (chatSnapshot.connectionState == ConnectionState.waiting) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
//       return Center(
//         child: Text('No messages found'),
//       );
//     }
//     if (chatSnapshot.hasError) {
//       return Center(
//         child:
//             Text('Something went wrong, please try again after some time'),
//       );
//     }
//     final messages = chatSnapshot.data!.docs;
//     return ListView.builder(
//       padding: EdgeInsets.only(
//         bottom: 40,
//         right: 15,
//         left: 15,
//       ),
//       reverse: true,
//       itemCount: messages.length,
//       itemBuilder: (context, index) {
//         final message = messages[index].data();
//         final nextMessage =
//             index + 1 < messages.length ? messages[index + 1].data() : null;
//         final currentUserId = message['sender-id'];
//         final nextUserId = nextMessage?['sender-id'];
//         final isSameUser = currentUserId == nextUserId;

//         if (isSameUser) {
//           return MessageBubble.next(
//             message: message['text'],
//             isMe: user.uid == currentUserId,
//           );
//         } else {
//           return MessageBubble.first(
//             userImage: message['user-image'],
//             username: message['username'],
//             message: message['text'],
//             isMe: user.uid == currentUserId,
//           );
//         }
//       },
//     );
//   },
// );
//   }
// }

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/message_bubble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    super.key,
    this.otherUser,
  });

  final UserModel? otherUser;

  Stream<List<QueryDocumentSnapshot>> getChatStream(String currentUserId) {
    final chatCollection = FirebaseFirestore.instance.collection('chat');

    // Query 1: Messages where current user is the sender and otherUser is the receiver
    final senderQuery = chatCollection
        .where('sender', isEqualTo: currentUserId)
        .where('receiver', isEqualTo: otherUser!.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);

    // Query 2: Messages where otherUser is the sender and current user is the receiver
    final receiverQuery = chatCollection
        .where('sender', isEqualTo: otherUser!.uid)
        .where('receiver', isEqualTo: currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);

    return Rx.combineLatest2(senderQuery, receiverQuery,
        (List<QueryDocumentSnapshot> a, List<QueryDocumentSnapshot> b) {
      return [...a, ...b]..sort((m1, m2) => (m2['createdAt'] as Timestamp)
          .compareTo(m1['createdAt'] as Timestamp));
    });

    
  }

  @override
  Widget build(BuildContext context) {
    if (otherUser == null) {
      final user = FirebaseAuth.instance.currentUser!;

      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where('receiver', isEqualTo: 'ALLGROUPCHAT')
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots(),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No messages found'),
            );
          }
          if (chatSnapshot.hasError) {
            return Center(
              child: Text(
                  'Something went wrong, please try again after some time'),
            );
          }
          final messages = chatSnapshot.data!.docs;
          return ListView.builder(
            padding: EdgeInsets.only(
              bottom: 40,
              right: 15,
              left: 15,
            ),
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index].data();
              final nextMessage = index + 1 < messages.length
                  ? messages[index + 1].data()
                  : null;
              final currentUserId = message['sender'];
              final nextUserId = nextMessage?['sender'];
              final isSameUser = currentUserId == nextUserId;

              if (isSameUser) {
                return MessageBubble.next(
                  message: message['text'],
                  isMe: user.uid == currentUserId,
                  time: message['createdAt'],
                );
              } else {
                return MessageBubble.first(
                  userImage: message['userImage'],
                  username: message['username'],
                  message: message['text'],
                  isMe: user.uid == currentUserId,
                  time: message['createdAt'],
                );
              }
            },
          );
        },
      );
    }

    final user = FirebaseAuth.instance.currentUser!;
    final chatStream = getChatStream(user.uid);

    return StreamBuilder<List<QueryDocumentSnapshot>>(
      stream: chatStream,
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!chatSnapshot.hasData || chatSnapshot.data!.isEmpty) {
          return Center(child: Text('No messages found'));
        }
        if (chatSnapshot.hasError) {
          return Center(child: Text('Something went wrong, please try again'));
        }

        final messages = chatSnapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.only(bottom: 40, right: 15, left: 15),
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index].data() as Map<String, dynamic>;
            final nextMessage = index + 1 < messages.length
                ? messages[index + 1].data() as Map<String, dynamic>?
                : null;
            final currentUserId = message['sender'];
            final nextUserId = nextMessage?['sender'];
            final isSameUser = currentUserId == nextUserId;

            if (isSameUser) {
              return MessageBubble.next(
                message: message['text'],
                isMe: user.uid == currentUserId,
                time: message['createdAt'],
              );
            } else {
              return MessageBubble.first(
                userImage: message['userImage'],
                username: message['username'],
                message: message['text'],
                time: message['createdAt'],
                isMe: user.uid == currentUserId,
              );
            }
          },
        );
      },
    );
  }
}
