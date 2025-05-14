import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poe Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

// Model cho từng tin nhắn
class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

// Model cho một phiên chat
class ChatSession {
  final String id;
  final List<ChatMessage> messages;
  ChatSession({required this.id, required this.messages});
}

// Widget hiển thị bubble cho mỗi tin nhắn
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bgColor    = message.isUser ? Colors.blue : Colors.grey.shade200;
    final textColor  = message.isUser ? Colors.white : Colors.black;
    final align      = message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius     = message.isUser
        ? BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
    )
        : BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}

// HomeScreen: danh sách các session + ô nhập để tạo session mới
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatSession> _sessions = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // Tạo session mới
    final session = ChatSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      messages: [ChatMessage(text: text, isUser: true)],
    );

    setState(() {
      _sessions.insert(0, session);
    });
    _controller.clear();

    // Mở NewChatScreen với session vừa tạo
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewChatScreen(session: session),
      ),
    );
  }

  void _openSession(ChatSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewChatScreen(session: session),
      ),
    );
  }

  void _deleteSession(int index) {
    setState(() {
      _sessions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poe Chat'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Danh sách session
          Expanded(
            child: ListView.builder(
              itemCount: _sessions.length,
              itemBuilder: (ctx, i) {
                final sess = _sessions[i];
                return ListTile(
                  title: Text(
                    sess.messages.first.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('Phiên chat ${i + 1}'),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'open') {
                        _openSession(sess);
                      } else if (value == 'delete') {
                        _deleteSession(i);
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'open', child: Text('Mở')),
                      PopupMenuItem(value: 'delete', child: Text('Xóa')),
                    ],
                  ),
                );
              },
            ),
          ),

          // Ô nhập + nút gửi
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// NewChatScreen: hiển thị và tiếp tục một phiên chat
class NewChatScreen extends StatefulWidget {
  final ChatSession session;
  NewChatScreen({required this.session});

  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  late List<ChatMessage> _messages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages = widget.session.messages;
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phiên ${widget.session.id}'),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Chat history
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) => ChatBubble(message: _messages[i]),
            ),
          ),

          // Ô nhập + nút gửi
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
