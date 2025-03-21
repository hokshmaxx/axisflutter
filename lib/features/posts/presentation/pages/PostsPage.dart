import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../../domain/entities/post.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 30),
          constraints: BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Column(
            children: [
              // Title & Create Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Manage Posts",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  ElevatedButton(
                    onPressed: () => _showPostDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text("+ New Post", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Posts Table with Proper Fitting
              Expanded(
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PostLoaded) {
                      return _buildPostsTable(context, state.posts);
                    } else {
                      return Center(child: Text("Error loading posts"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Table that fits its container properly
  Widget _buildPostsTable(BuildContext context, List<Post> posts) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width, // Ensure it stretches
          ),
          child: DataTable(
            columnSpacing: 16,
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
            columns: const [
              DataColumn(label: Text("Title", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Content", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: posts.map((post) {
              return DataRow(cells: [
                DataCell(Text(post.title)),
                DataCell(Text(post.content, maxLines: 2, overflow: TextOverflow.ellipsis)),
                DataCell(Row(
                  children: [
                    _buildActionButton("✏️ Edit", Colors.blue[500]!, () => _showPostDialog(context, post: post)),
                    SizedBox(width: 10),
                    _buildActionButton("🗑 Delete", Colors.red[500]!, () => _confirmDelete(context, post.id)),
                  ],
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14)),
    );
  }

  void _showPostDialog(BuildContext context, {Post? post}) {
    TextEditingController titleController = TextEditingController(text: post?.title ?? "");
    TextEditingController contentController = TextEditingController(text: post?.content ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(post == null ? "New Post" : "Edit Post"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: "Content", border: OutlineInputBorder()),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("❌ Close")),
            ElevatedButton(
              onPressed: () {
                final postBloc = BlocProvider.of<PostBloc>(context);
                if (post == null) {
                  postBloc.add(CreatePost(titleController.text, contentController.text));
                } else {
                  postBloc.add(UpdatePost(post.id, titleController.text, contentController.text));
                }
                Navigator.pop(context);
              },
              child: Text("✅ Save"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Are you sure?"),
          content: Text("You won't be able to revert this!"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<PostBloc>(context).add(DeletePost(postId));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Yes, delete it!"),
            ),
          ],
        );
      },
    );
  }
}
