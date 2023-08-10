import 'package:fic4_flutter_auth_bloc/bloc/product/create_product/create_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/profile/profile_bloc.dart';
import 'package:fic4_flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    context.read<ProfileBloc>().add(GetProfilEvent());
    context.read<GetAllProductBloc>().add(DoGetAllProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home - Profile'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthLocalStorage().removeToken();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              icon: Icon(Icons.login_outlined))
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfilLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfilLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.profile.name ?? ''),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(state.profile.email ?? ''),
                ],
              );
            }
            return const Text('No Data');
          }),
          Expanded(child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
              builder: (contex, state) {
            if (state is GetAllProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetAllProductLoaded) {
              return ListView.builder(itemBuilder: ((context, index) {
                final product = state.listProduct[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${product.price}'),
                    ),
                    title: Text(product.title ?? '-'),
                    subtitle: Text(product.description ?? '-'),
                  ),
                );
              }));
            }
            return const Text('No Data');
          }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Product'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: titleController,
                      ),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(labelText: 'Description'),
                        controller: descriptionController,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Price'),
                        controller: priceController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final productModel = ProductModel(
                            title: titleController.text,
                            price: int.parse(priceController.text),
                            description: descriptionController.text);
                        context.read<CreateProductBloc>().add(
                            DoCreateProductEvent(productModel: productModel));
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
