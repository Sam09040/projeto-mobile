//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutable, unrelated_type_equality_checks, avoid_print, library_private_types_in_public_api, unnecessary_const

import 'dart:async';
import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp([Key? key]) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<List<String>> matriz = [
    ['15', '06', '04', '02'],
    ['01', '11', '10', '07'],
    ['09', '03', '05', '08'],
    ['12', '14', '13', '']
  ];
  List<List<String>> completo = [
    ['01', '02', '03', '04'],
    ['05', '06', '07', '08'],
    ['09', '10', '11', '12'],
    ['13', '14', '15', '']
  ];
  List<List<String>> inicial = [
    ['15', '06', '04', '02'],
    ['01', '11', '10', '07'],
    ['09', '03', '05', '08'],
    ['12', '14', '13', '']
  ];

  int intSegundo = 0;
  int intMin = 0;
  int intHora = 0;
  String segundo = '00';
  String minuto = '00';
  String hora = '00';
  String time = '00:00';

  void startTimer() {
    const oneSec = const Duration(seconds: 01);
    // ignore: unnecessary_new
    new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (intSegundo == '50000' || calc == 16) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            intSegundo++;
            segundo = intSegundo.toString();
            if (intSegundo < 10) {
              segundo = '0$intSegundo';
            }
            time = '$minuto:$segundo';
          });
        }
        if (intSegundo == 60) {
          setState(() {
            intSegundo = 0;
            segundo = intSegundo.toString();
            intMin++;
            minuto = intMin.toString();
            if (intMin < 10) {
              minuto = '0$intMin';
            }
            time = '$minuto:$segundo';
          });
        }
        if (intMin == 60) {
          setState(() {
            intMin = 0;
            minuto = intMin.toString();
            intHora++;
            hora = intHora.toString();
            if (intHora < 10) {
              hora = '0$intHora';
            }
            time = '$hora:$minuto:$segundo';
          });
        }
      },
    );
  }

  int linha = -1;
  int coluna = -1;
  String mat = 'X,Y';
  int calc = 0;
  int cont = 0;

  void moveKey(var tecla) {
    if (cont == 0) {
      startTimer();
    }
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (matriz[i][j] == tecla) {
          setState(() {
            linha = i;
            coluna = j;
            cont++;
          });
          break;
        }
      }
    }
    void calcular() {
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          if (matriz[i][j] == completo[i][j]) {
            setState(() {
              calc++;
            });
          } else {
            setState(() {
              calc = 0;
            });
          }
        }
        if (calc == 16) {
          setState(() {
            showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Vitória!'),
                    content: Text('Deseja continuar jogando?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                            matriz.shuffle();
                            mat = '0,0';
                            cont = 0;
                            intSegundo = 0;
                            intMin = 0;
                            intHora = 0;
                            time = '00:00';
                          });
                        },
                        child: Text('Sim'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            exit(0);
                          });
                        },
                        child: Text('Não'),
                      )
                    ],
                  );
                });
          });
        }
      }
    }

    setState(() {
      if (linha - 1 >= 0) {
        if (matriz[linha - 1][coluna] == '') {
          matriz[linha - 1][coluna] = tecla;
          matriz[linha][coluna] = '';
          calcular();
        }
      }

      if (linha + 1 <= 3) {
        if (matriz[linha + 1][coluna] == '') {
          matriz[linha + 1][coluna] = tecla;
          matriz[linha][coluna] = '';
          calcular();
        }
      }

      if (coluna - 1 >= 0) {
        if (matriz[linha][coluna - 1] == '') {
          matriz[linha][coluna - 1] = tecla;
          matriz[linha][coluna] = '';
          calcular();
        }
      }

      if (coluna + 1 <= 3) {
        if (matriz[linha][coluna + 1] == '') {
          matriz[linha][coluna + 1] = tecla;
          matriz[linha][coluna] = '';
          calcular();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Puzzle')),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Jogadas: ',
                    style: TextStyle(fontSize: 52),
                  ),
                  Text(
                    cont.toString(),
                    style: TextStyle(fontSize: 52),
                  ),
                  Text(
                    '      Tempo: ',
                    style: TextStyle(fontSize: 52),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 52),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => moveKey(matriz[0][0]),
                      child: Text(
                        matriz[0][0],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[0][1]),
                      child: Text(
                        matriz[0][1],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[0][2]),
                      child: Text(
                        matriz[0][2],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[0][3]),
                      child: Text(
                        matriz[0][3],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => moveKey(matriz[1][0]),
                      child: Text(
                        matriz[1][0],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[1][1]),
                      child: Text(
                        matriz[1][1],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[1][2]),
                      child: Text(
                        matriz[1][2],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[1][3]),
                      child: Text(
                        matriz[1][3],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => moveKey(matriz[2][0]),
                      child: Text(
                        matriz[2][0],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[2][1]),
                      child: Text(
                        matriz[2][1],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[2][2]),
                      child: Text(
                        matriz[2][2],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[2][3]),
                      child: Text(
                        matriz[2][3],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => moveKey(matriz[3][0]),
                      child: Text(
                        matriz[3][0],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[3][1]),
                      child: Text(
                        matriz[3][1],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[3][2]),
                      child: Text(
                        matriz[3][2],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[3][3]),
                      child: Text(
                        matriz[3][3],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
