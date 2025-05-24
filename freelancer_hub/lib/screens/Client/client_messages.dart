import 'package:flutter/material.dart';
import '../layouts/dashboard_layout.dart';

class ClientMessages extends StatefulWidget {
  final int selectedIndex;

  const ClientMessages({
    super.key,
    this.selectedIndex = 3,
  });

  @override
  State<ClientMessages> createState() => _ClientMessagesState();
}

class _ClientMessagesState extends State<ClientMessages> {
  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'Sarah Johnson',
      'role': 'UI/UX Designer',
      'rating': '4.9',
      'lastMessage': 'Latest updates on the project...',
      'time': '2m ago',
      'unread': 2,
      'isOnline': true,
      'project': 'E-commerce Website',
    },
    {
      'name': 'Mike Chen',
      'role': 'Web Developer',
      'rating': '4.8',
      'lastMessage': 'I\'ve completed the frontend...',
      'time': '1h ago',
      'unread': 0,
      'isOnline': false,
      'project': 'Mobile App Development',
    },
    {
      'name': 'Alex Brown',
      'role': 'Mobile Developer',
      'rating': '4.7',
      'lastMessage': 'The app is ready for testing...',
      'time': '3h ago',
      'unread': 1,
      'isOnline': true,
      'project': 'iOS App Development',
    },
    {
      'name': 'Emma Wilson',
      'role': 'Graphic Designer',
      'rating': '4.9',
      'lastMessage': 'I\'ve sent the logo designs...',
      'time': '5h ago',
      'unread': 0,
      'isOnline': false,
      'project': 'Brand Identity Design',
    },
    {
      'name': 'David Lee',
      'role': 'Backend Developer',
      'rating': '4.8',
      'lastMessage': 'API integration is complete...',
      'time': '1d ago',
      'unread': 0,
      'isOnline': false,
      'project': 'Backend Development',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Messages',
      userRole: 'Client',
      userName: 'John Doe',
      initialSelectedIndex: widget.selectedIndex,
      content: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search messages...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final conversation = _conversations[index];
                return _buildMessageCard(conversation);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageCard(Map<String, dynamic> conversation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: const Color(0xFF2D2D2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Handle message tap
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar with Online Status
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF6C63FF).withOpacity(0.1),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF6C63FF),
                      size: 28,
                    ),
                  ),
                  if (conversation['isOnline'])
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2D2D2D),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Message Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          conversation['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          conversation['time'],
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          conversation['rating'],
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          conversation['role'],
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      conversation['project'],
                      style: TextStyle(
                        color: const Color(0xFF6C63FF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation['lastMessage'],
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conversation['unread'] > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              conversation['unread'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 