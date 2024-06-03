enum ImageType {
  lion,
  racoon,
  rabbit,
  monkey,
  panda,
  dog;

  static ImageType fromString(String type) {
    switch (type) {
      case 'lion':
        return ImageType.lion;
      case 'racoon':
        return ImageType.racoon;
      case 'rabbit':
        return ImageType.rabbit;
      case 'monkey':
        return ImageType.monkey;
      case 'panda':
        return ImageType.panda;
      case 'dog':
        return ImageType.dog;
      default:
        return ImageType.lion;
    }
  }

  get path {
    switch (this) {
      case ImageType.lion:
        return 'assets/images/lion.png';
      case ImageType.racoon:
        return 'assets/images/racoon.png';
      case ImageType.rabbit:
        return 'assets/images/rabbit.png';
      case ImageType.monkey:
        return 'assets/images/monkey.png';
      case ImageType.panda:
        return 'assets/images/panda.png';
      case ImageType.dog:
        return 'assets/images/dog.png';
      default:
        return 'assets/images/lion.png';
    }
  }
}
