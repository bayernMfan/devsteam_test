import 'package:devsteam_test/bloc/photo_bloc/photo_bloc.dart';
import 'package:devsteam_test/pages/photo_page.dart';
import 'package:devsteam_test/repo/API/photo_API.dart';
import 'package:devsteam_test/repo/model/photo-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeroHeader implements SliverPersistentHeaderDelegate {
  HeroHeader({
    this.minExtent,
    this.maxExtent,
  });

  double maxExtent;
  double minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/pablo-martinez-Ja7IFmlmKd8-unsplash.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 4.0,
          top: 4.0,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Photo Gallery',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();
}

class GalleryPage extends StatelessWidget {
  GalleryPage({Key key, this.authToken}) : super(key: key);
  final String authToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PhotoBloc(Photo()),
        child: ScrollView(
          authToken: authToken,
        ),
      ),
    );
  }
}

class ScrollView extends StatefulWidget {
  ScrollView({Key key, this.authToken}) : super(key: key);
  final String authToken;
  @override
  _ScrollViewState createState() => _ScrollViewState(authToken);
}

class _ScrollViewState extends State<ScrollView> {
  _ScrollViewState(this.token);
  final String token;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PhotoBloc>(context).add(GetPhoto(token));
    print("GetPhoto event with token " + token);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: HeroHeader(
                minExtent: 150.0,
                maxExtent: 300.0,
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250.0,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.55,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return BlocBuilder<PhotoBloc, PhotoState>(
                    builder: (context, state) {
                      if (state is PhotoIsLoading)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else if (state is PhotoLoaded)
                        return Padding(
                          padding: _edgeInsetsForIndex(index),
                          child: PhotoContainer(
                            photo: state.getPhotos[index],
                          ),
                        );
                      else if (state is PhotoNotLoaded)
                        return Text(
                          state.getMessage,
                          style: TextStyle(color: Colors.black),
                        );
                      return Container();
                    },
                  );
                },
                childCount:
                    10, //null по какой-то причине не работает, хотя в апи к этому полю это указано.
              ),
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsets _edgeInsetsForIndex(int index) {
    if (index % 2 == 0) {
      return EdgeInsets.only(top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
    } else {
      return EdgeInsets.only(top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
    }
  }
}

class PhotoContainer extends StatelessWidget {
  const PhotoContainer({Key key, this.photo}) : super(key: key);
  final PhotoModel photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      //alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                photo.url,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Author: ${photo.author}'),
                    Text('Description: ${photo.description}'),
                  ],
                ),
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoPage(photoURL: photo.url),
                  ),
                );
              },
              child: Container()),
        ],
      ),
    );
  }
}
