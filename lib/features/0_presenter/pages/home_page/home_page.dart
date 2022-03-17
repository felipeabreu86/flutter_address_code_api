import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/core/utils/constants.dart';
import 'package:flutter_address_code_api/features/0_presenter/bloc/address_code_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  final _addressCodeBloc = Modular.get<AddressCodeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address Code',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _addressCodeBloc.add(
                  AddressCodeSearch(
                    AddressCodeRequestParams(_textController.text),
                  ),
                );
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            BlocBuilder<AddressCodeBloc, AddressCodeState>(
              bloc: _addressCodeBloc,
              builder: (context, state) {
                if (state is AddressCodeLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state is AddressCodeError) {
                  return Column(
                    children: [
                      const Icon(Icons.error_outline),
                      Text(state.errorMessage),
                    ],
                  );
                } else if (state is AddressCodeDone) {
                  return Text(state.formatedAddress);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
