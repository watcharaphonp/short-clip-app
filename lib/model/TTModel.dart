class TTStoryModel {
  var name;
  var message;
  var tag;
  var like;
  var sound;
  var comment;
  var share;
  var videoPath;
  var profile;
  var musicImg;
  var isFavourite = false;

  TTStoryModel(this.name, this.message, this.tag, this.sound, this.like, this.comment, this.share, this.videoPath, this.profile, this.musicImg);
}

class TTAccountModel {
  var post;
  var like;
  var user;

  TTAccountModel(this.post, this.like, this.user);
}

class TTSearchModel {
  List<String> imageList;
  var message;
  var view;

  TTSearchModel(this.message, this.view, this.imageList);
}

class TTNotificationModel {
  var userImg;
  var msg;
  var duration;

  TTNotificationModel(this.msg, this.duration, this.userImg);
}

class TTFollowingModel {
  var userImg;
  var name;
  var isSelected = false;

  TTFollowingModel(this.userImg, this.name);
}

class TTSongModel {
  var img;
  var name;
  var value;
  var isSelected = false;

  TTSongModel(this.img, this.name, this.value);
}
