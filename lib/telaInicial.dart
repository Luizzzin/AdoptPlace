import 'package:flutter/material.dart';
class TelaInicial extends StatefulWidget {
	const TelaInicial({super.key});
	@override
	TelaInicialState createState() => TelaInicialState();
}
class TelaInicialState extends State<TelaInicial> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: 
        Container(
          width: 402,
          height: 874,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
              children: [
                  Positioned(
                      left: 5,
                      top: 394,
                      child: Container(
                          width: 152,
                          height: 152,
                          child: Image.asset('assets/patinha.png'),
                      ),
                  ),
                  Positioned(
                      left: -1.83,
                      top: 394,
                      child: Container(
                          width: 179.31,
                          height: 174.86,
                          
                      ),
                  ),
                  Positioned(
                      left: 246,
                      top: 251,
                      child: Container(
                          width: 152,
                          height: 152,
                          child: Image.asset('assets/patinha.png'),
                      ),
                  ),
                  Positioned(
                      left: 239.17,
                      top: 251,
                      child: Container(
                          width: 179.31,
                          height: 174.86,
                          
                      ),
                  ),
                  Positioned(
                      left: 5,
                      top: 121,
                      child: Container(
                          width: 152,
                          height: 152,
                          child: Image.asset('assets/patinha.png'),
                      ),
                  ),
                  Positioned(
                      left: -1.83,
                      top: 121,
                      child: Container(
                          width: 179.31,
                          height: 174.86,
                          
                      ),
                  ),
                  
                  Positioned(
                      left: 121.86,
                      top: 50.19,
                      child: Container(
                          width: 172.45,
                          height: 96.57,
                          
                      ),
                  ),
                  Positioned(
                      left: 128.01,
                      top: 46.01,
                      child: Container(
                          width: 144.97,
                          height: 96.65,
                          child: Image.asset('assets/logo.png'),
                      ),
                  ),
                  
                  Positioned(
                      left: 53,
                      top: 135,
                      child: Container(
                          width: 269.50,
                          height: 366.82,
                          child: Image.asset('assets/dog.png'),
                      ),
                  ),
                  Positioned(
                      left: 17,
                      top: 515,
                      child: Container(
                          width: 369,
                          height: 315,
                          decoration: ShapeDecoration(
                              color: const Color(0xFFEE562F),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                              ),
                          ),
                      ),
                  ),
                  Positioned(
                      left: 55,
                      top: 746,
                      child: Container(
                          width: 291,
                          height: 57,
                          decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.50),
                              ),
                          ),
                      ),
                  ),
                  Positioned(
                      left: 130,
                      top: 754,
                      child: Text(
                          'Vamos lá!',
                          style: TextStyle(
                              color: const Color(0xFFEE562F),
                              fontSize: 32,
                              fontFamily: 'Red Hat Display',
                              fontWeight: FontWeight.w700,
                          ),
                      ),
                  ),
                  Positioned(
                      left: 33,
                      top: 548,
                      child: Text(
                          'Encontre Seu Novo Melhor Amigo',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: 'Red Hat Display',
                              fontWeight: FontWeight.w800,
                          ),
                      ),
                  ),
                  Positioned(
                      left: 30,
                      top: 590,
                      child: SizedBox(
                          width: 341,
                          height: 144,
                          child: Text(
                              'Milhares de cãezinhos estão à espera de um lar cheio de amor. Seja para adotar ou apoiar ONGs e protetores locais, você está no lugar certo. Um gesto simples pode mudar uma vida para sempre.\n',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                              ),
                          ),
                      ),
                  ),
              ],
          ),
        )
			),
		);
	}
}