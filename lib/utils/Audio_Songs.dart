List<Map> Audio_Songs = [
  {
    'title': 'Deva Deva',
    'singers': ['Arijit Singh', 'Jonita Gandhi'],
    'movie': 'Bramhastra',
    'image':
        'https://www.gethucinema.com/wp-content/uploads/2022/08/MouniRoy-17.jpg',
    'path': 'assets/audio/devadeva.mp3',
  },
  {
    'title': 'Jogan Tera Mara',
    'singers': ['Tushar Joshi', 'Shreya Ghoshal'],
    'movie': 'Bramhastra',
    'image':
        'https://i.pinimg.com/564x/dd/2d/a3/dd2da38e14279b663d6301c625aa6a19.jpg',
    'path': 'assets/audio/jogan_tera_mara.mp3',
  },
  {
    'title': 'Kesariya',
    'singers': ['Arijit Singh'],
    'movie': 'Bramhastra',
    'image':
        'https://i.pinimg.com/564x/fa/c8/77/fac8778c207439c726bfb1f5a0b09f4f.jpg',
    'path': 'assets/audio/kesariya.mp3',
  },
  {
    'title': 'Raatan Lambiya',
    'singers': ['Jubin Nautiyal', 'Tanishk Bagchi', 'Asees Kaur'],
    'movie': 'Shershah',
    'image':
        'https://i.pinimg.com/564x/ce/dc/db/cedcdb4d134f6d8ae9fcb48dc2ff9cbb.jpg',
    'path': 'assets/audio/raatan_lambiya.mp3',
  },
  {
    'title': 'Shershah Mashup',
    'singers': [
      'Jubin Nautiyal',
      'Darshan Raval',
      'B Praak',
      'Palak Muchhal',
      'Jaani',
      'Asees Kaur',
      'Jasleen Royal',
      'DJ Chetas'
    ],
    'movie': 'Shershah',
    'image':
        'https://i.pinimg.com/564x/14/48/a5/1448a504af9b656df54bf5e6dc2e9c38.jpg',
    'path': 'assets/audio/shershahmashup.mp3',
  },
  {
    'title': 'Maine pi rakhi hai',
    'singers': ['Shreya Ghoshal', 'Divya Kumar'],
    'movie': 'Tu Joothi Mai Makkar',
    'image':
        'https://i.pinimg.com/564x/cf/98/7d/cf987d5df00aacfc885aae21aa438cf9.jpg',
    'path': 'assets/audio/maine_pi_rakhi_hai.mp3',
  },
  {
    'title': 'Pyar Hota Kai Bar Hai',
    'singers': ['Arijit Singh'],
    'movie': 'Tu Joothi Mai Makkar',
    'image':
        'https://i.pinimg.com/564x/c6/d7/5e/c6d75e42c1e0e14fb0313f2c08f76e67.jpg',
    'path': 'assets/audio/pyar_hota_kai_bar_hai.mp3',
  },
  {
    'title': 'Tere Pyar Main',
    'singers': ['Arijit Singh', ' Nikhita Gandhi'],
    'movie': 'Tu Joothi Mai Makkar',
    'image':
        'https://i.pinimg.com/564x/89/12/63/8912631dcfdee9978bd0f1f9af2c3b9c.jpg',
    'path': 'assets/audio/tere_pyar_main.mp3',
  },
];

List<String> Movies =
    Audio_Songs.map((e) => e['movie'].toString()).toSet().toList();

Map Images_Movies = {
  'Tu Joothi Mai Makkar':
      'https://cdn.123telugu.com/content/wp-content/uploads/2023/03/tjmm-mm.jpg',
  'Shershah':
      'https://m.media-amazon.com/images/S/pv-target-images/94f844722fbb6c7b92e0cbd1a71297e949349c306c938ce7c9bc402366789313.jpg',
  'Bramhastra':
      'https://www.thestatesman.com/wp-content/uploads/2022/06/maxresdefault-1-1.jpg',
};

//deva deva  'https://c.saavncdn.com/129/Deva-Deva-From-Brahmastra-Tamil-Tamil-2022-20220810122105-500x500.jpg',
