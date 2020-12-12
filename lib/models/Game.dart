// export const GameSchema = new Schema(
//     {
//         title: {
//             type: String,
//             required: true,
//             unique: true
//         },
//         image: {
//             type: String,
//             required: true,
//         },
//         cards: [CardSchema],
//         boards: [BoardSchema]
//     },
//     {
//         timestamps: true,
//     }
// );

class Game {
  String _title;
  String _image;

  Game(this._title, this._image);

  Game.fromMap(dynamic map) {
    this._title = map["title"];
    this._image = map["image"];
  }

  String get title => this._title;
  String get image => this._image;
}
