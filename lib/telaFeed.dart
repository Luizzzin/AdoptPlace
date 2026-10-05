import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adopt_place/cao.dart';
import 'package:adopt_place/cardCao.dart';
class TelaFeed extends StatefulWidget {
	const TelaFeed({super.key});
	@override
	TelaFeedState createState() => TelaFeedState();
}
class TelaFeedState extends State<TelaFeed> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: Container(
					constraints: const BoxConstraints.expand(),
					color: Color(0xFFFFFFFF),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Expanded(
								child: IntrinsicHeight(
									child: Container(
										color: Color(0xFF68ACF4),
										width: double.infinity,
										height: double.infinity,
										child: SingleChildScrollView(
											padding: const EdgeInsets.only( top: 63),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 20),
															width: double.infinity,
															child: Column(
																children: [
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Row(
																				children: [
																					Container(
																						width: 144.97,
                                            height: 96.65,
																						child: Image.asset('assets/logo.png'),
																					),
																				]
																			),
																		),
																	),
																]
															),
														),
													),
													Container(
														margin: const EdgeInsets.only( bottom: 7, left: 32),
														child: Text(
															"Bem-vindo ! 👋",
															style: TextStyle(
																color: Color(0xFFFFFFFF),
																fontSize: 32,
																fontWeight: FontWeight.bold,
															),
														),
													),
													Container(
														margin: const EdgeInsets.only( bottom: 21, left: 32),
														width: 300,
														child: Text(
															"Encontre um melhor amigo e também produtos para cuidados Pet",
															style: TextStyle(
																color: Color(0xFFFFFFFF),
																fontSize: 15,
																fontWeight: FontWeight.bold,
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 7),
															width: double.infinity,
															child: Column(
																children: [
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Row(
																				children: [
																					Container(
																						margin: const EdgeInsets.only( right: 37),
																						width: 80,
																						height: 80,
																						child:Image.asset('assets/feedDefault/dogIcon.png'),
																					),
																					Container(
																						width: 80,
																						height: 80,
																						child: Image.asset('assets/feedDefault/pawIcon.png')
																						
																					),
																				]
																			),
																		),
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 20),
															width: double.infinity,
															child: Column(
																children: [
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Row(
																				children: [
																					Container(
																						margin: const EdgeInsets.only( right: 72),
																						child: Text(
																							"Pets",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 14,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					),
																					Text(
																						"Produtos",
																						style: TextStyle(
																							color: Color(0xFFFFFFFF),
																							fontSize: 14,
																							fontWeight: FontWeight.bold,
																						),
																					),
																				]
																			),
																		),
																	),
																]
															),
														),
													),
													Container(
														margin: const EdgeInsets.only( bottom: 48, left: 36),
														child: Text(
															"Feed de pets a espera de um dono:",
															style: TextStyle(
																color: Color(0xFFFFFFFF),
																fontSize: 14,
																fontWeight: FontWeight.bold,
															),
														),
													),
                            Container(
                            margin: const EdgeInsets.only(bottom: 12, left: 36),
                            child: Text(
                              "Feed de pets a espera de um dono:",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance.collection('caes').snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    'Erro: ${snapshot.error}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(color: Colors.white),
                                );
                              }
                              final docs = snapshot.data?.docs ?? [];
                              if (docs.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    'Nenhum cão cadastrado.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                                child: Column(
                                  children: docs.map((d) => CardCao(cao: Cao.fromDoc(d))).toList(),
                                ),
                              );
                            },
                          ),
												],
											)
										),
									),
								),
							),
              
						],
					),
				),
			),
		);
	}
}