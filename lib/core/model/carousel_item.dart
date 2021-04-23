import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CarouselItem extends Equatable {
  final String headLine;
  final String description;
  CarouselItem({
    @required this.headLine,
    @required this.description,
  });

  @override
  List<Object> get props => [headLine, description];
}

List<CarouselItem> carouselItems = [
  CarouselItem(
      headLine: '"Hundred" Doesn\'t Mean 100',
      description:
          'The word "hundred" is actually derived from the Old Norse word "hundrath," which actually means 120, not 100. More specifically, "hundrath," in Old Norse, means "long hundred," which equals 120, due to the duodecimal system. But good luck trying to argue that your 100 dollars bill is worth 20 percent more than it is.'),
  CarouselItem(
      headLine: 'There Is Only One Even Prime Number',
      description:
          'The number 2 is also the smallest and first prime number (since every other even number is divisible by two).'),
  CarouselItem(
      headLine: 'The Square Root of Two Is Called "Pythagoras\' Constant."',
      description:
          'This all has to do with that Greek mathematician Pythagoras, and there is a fascinating history behind his famous theorem that they definitely did not teach you in high school—that Babylonian mathematicians discovered his famous theory 1,000 years before he did!'),
  CarouselItem(
      headLine:
          'Zero Is the Only Number That Can\'t Be Represented In Roman Numerals',
      description:
          'There are a total of zero zeros in Roman numerals. While the ancient Greeks were aware of zero as a concept, they didn\'t consider zero to be a number at all. For example, Aristotle decided zero wasn\'t a number because you couldn\'t divide by zero. Instead of a Roman numeral, the Latin word "nulla" would have been used to represent the concept of zero. The reason no numeral existed for zero is because there was no need for a numeral to represent it.'),
  CarouselItem(
      headLine: 'Different Cultures Discovered Zero at Different Times',
      description:
          'The idea of zero as a number was invented throughout the world at different times in history. Despite this scattered adoption, it\'s generally accepted that the Indian astronomer and mathematician Brahmagupta brought up the concept of zero for the first time, around 600 A.D. Besides this, Brahmagupta contributed a lot to mathematics and astronomy, and is known for explaining how to find the cube and cube-root of an integer and also gave rules facilitating the computation of squares and square roots. '),
  CarouselItem(
      headLine: 'Roman Numerals Were Invented as a Means of Trading',
      description:
          'The form of record-keeping was used as a means for Romans to easily price different goods and services, and were widely used throughout the Roman Empire for everyday processes. After the fall of the Roman Empire, Roman numerals still continued to be used throughout Europe. This stopped, however, around the 1600s. Roman numerals are represented by seven different letters: I, V, X, L, C, D, and M.'),
  CarouselItem(
      headLine: 'Zero Is An Even Number',
      description:
          'Mathematically, an even number is one that can be divided by two and still create a whole number. Zero meets the criteria for this because if you halve zero, you get zero. But if you\'re confused, you\'re not alone: Research from the 1990s, out of Cambridge University, actually revealed that people are 10 percent slower at deciding whether zero is even or not than they are if, say, two is.'),
];
//  CarouselItem(headLine: '', description: ''),
// Continue 8 => https://bestlifeonline.com/number-facts/
