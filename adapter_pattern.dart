import 'dart:convert';

class PostApi1 {
  String getYoutubePosts() {
    return '''
    [
      {
        "title": "ChatGPT vs Deepseek",
        "description": "Who's the better Large Language Model"
      },
      {
        "title": "Why Google Search sucks now",
        "description": "Have to add reddit at the end for better results"
      },
    ]
    ''';
  }
}

class PostApi2 {
  String getRedditPost() {
    return '''
      [
        {
          "header": "Elon Mush sucks",
          "bio": "Elon is a man child"
        },
        {
          "header": "Anime_irl",
          "bio": "Anime_IRL"
        },
      ]
    ''';
  }
}

abstract class IPostAPI {
  List<Post> getPosts();
}

class Post {
  final String title;
  final String bio;
  Post({required this.title, required this.bio});
}

class APIAdapter1 implements IPostAPI {
  final api1 = PostApi1();
  @override
  List<Post> getPosts() {
    final data = jsonDecode(api1.getYoutubePosts()) as List;

    return data
        .map((e) => Post(title: e['title'], bio: e['description']))
        .toList();
  }
}

class APIAdapter2 implements IPostAPI {
  final api = PostApi2();

  @override
  List<Post> getPosts() {
    final data = api.getRedditPost() as List;

    return data
        .map(
          (e) => Post(
            title: e['header'],
            bio: e['bio'],
          ),
        )
        .toList();
  }
}

class PostApi implements IPostAPI {
  APIAdapter1 api1 = APIAdapter1();
  APIAdapter2 api2 = APIAdapter2();
  @override
  List<Post> getPosts() {
    return api1.getPosts() + api2.getPosts();
  }
}
