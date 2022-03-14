import 'dart:convert';
import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required String cep,
    required String logradouro,
    required String complemento,
    required String bairro,
    required String localidade,
    required String uf,
    required String ibge,
    required String gia,
    required String ddd,
    required String siafi,
  }) : super(
          cep: cep,
          logradouro: logradouro,
          complemento: complemento,
          bairro: bairro,
          localidade: localidade,
          uf: uf,
          ibge: ibge,
          gia: gia,
          ddd: ddd,
          siafi: siafi,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep']?.toString() ?? '',
      logradouro: json['logradouro']?.toString() ?? '',
      complemento: json['complemento']?.toString() ?? '',
      bairro: json['bairro']?.toString() ?? '',
      localidade: json['localidade']?.toString() ?? '',
      uf: json['uf']?.toString() ?? '',
      ibge: json['ibge']?.toString() ?? '',
      gia: json['gia']?.toString() ?? '',
      ddd: json['ddd']?.toString() ?? '',
      siafi: json['siafi']?.toString() ?? '',
    );
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      cep: map['cep']?.toString() ?? '',
      logradouro: map['logradouro']?.toString() ?? '',
      complemento: map['complemento']?.toString() ?? '',
      bairro: map['bairro']?.toString() ?? '',
      localidade: map['localidade']?.toString() ?? '',
      uf: map['uf']?.toString() ?? '',
      ibge: map['ibge']?.toString() ?? '',
      gia: map['gia']?.toString() ?? '',
      ddd: map['ddd']?.toString() ?? '',
      siafi: map['siafi']?.toString() ?? '',
    );
  }

  AddressModel copyWith({
    String? cep,
    String? logradouro,
    String? complemento,
    String? bairro,
    String? localidade,
    String? uf,
    String? ibge,
    String? gia,
    String? ddd,
    String? siafi,
  }) {
    return AddressModel(
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      localidade: localidade ?? this.localidade,
      uf: uf ?? this.uf,
      ibge: ibge ?? this.ibge,
      gia: gia ?? this.gia,
      ddd: ddd ?? this.ddd,
      siafi: siafi ?? this.siafi,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'ibge': ibge,
      'gia': gia,
      'ddd': ddd,
      'siafi': siafi,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Address(cep: $cep, logradouro: $logradouro, complemento: $complemento, bairro: $bairro, localidade: $localidade, uf: $uf, ibge: $ibge, gia: $gia, ddd: $ddd, siafi: $siafi)';
  }
}
