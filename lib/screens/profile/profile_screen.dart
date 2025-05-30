import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.blue.shade800],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/default_avatar.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user?.name ?? 'User Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'Quick Actions',
                    [
                      _buildActionTile(
                        icon: Icons.mood,
                        title: 'Mood Tracker',
                        onTap: () => Navigator.pushNamed(context, '/mood-tracker'),
                      ),
                      _buildActionTile(
                        icon: Icons.music_note,
                        title: 'Meditation Music',
                        onTap: () => _launchMusicPlayer(),
                      ),
                      _buildActionTile(
                        icon: Icons.share,
                        title: 'Share with Friends',
                        onTap: () => _shareApp(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    'Account Settings',
                    [
                      _buildActionTile(
                        icon: Icons.person,
                        title: 'Edit Profile',
                        onTap: () => Navigator.pushNamed(context, '/edit-profile'),
                      ),
                      _buildActionTile(
                        icon: Icons.notifications,
                        title: 'Notifications',
                        onTap: () => Navigator.pushNamed(context, '/notifications'),
                      ),
                      _buildActionTile(
                        icon: Icons.privacy_tip,
                        title: 'Privacy Settings',
                        onTap: () => Navigator.pushNamed(context, '/privacy'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    'Support',
                    [
                      _buildActionTile(
                        icon: Icons.help,
                        title: 'Help Center',
                        onTap: () => Navigator.pushNamed(context, '/help'),
                      ),
                      _buildActionTile(
                        icon: Icons.feedback,
                        title: 'Send Feedback',
                        onTap: () => _sendFeedback(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                      icon: Icon(Icons.logout),
                      label: Text('Logout'),
                      onPressed: () {
                        context.read<AuthProvider>().logout();
                        Navigator.pushReplacementNamed(context, '/welcome');
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _shareApp() {
    Share.share('Check out this amazing Mental Health Care app!');
  }

  void _launchMusicPlayer() async {
    // Implement music player launch
  }

  void _sendFeedback(BuildContext context) {
    // In your ProfileScreen widget, update the background image
    FlexibleSpaceBar(
      background: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/user_profile.jpg',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
    // Implement feedback dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Send Feedback'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Tell us what you think...',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement feedback submission
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Thank you for your feedback!')),
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}