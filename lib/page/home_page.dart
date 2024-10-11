import 'package:bandoan/components/my_decriptions_box.dart';
import 'package:bandoan/components/my_drawer.dart';
import 'package:bandoan/components/my_food_title.dart';
import 'package:bandoan/components/my_location.dart';
import 'package:bandoan/model/product.dart';
import 'package:bandoan/model/restaurant.dart';
import 'package:bandoan/page/food_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // Tab controller
  late TabController _tabController;
  bool _isLoading = true; // Biến trạng thái tải dữ liệu

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FoodCategory.values.length, vsync: this);
    _fetchMenu(); // Gọi phương thức fetch menu
  }

  Future<void> _fetchMenu() async {
    final restaurant = Provider.of<Restaurant>(context, listen: false);
    await restaurant.fetchMenuFromFirebase(); // Lấy dữ liệu từ Firebase
    setState(() {
      _isLoading = false; // Đánh dấu hoàn thành tải dữ liệu
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Food> _filterMenuCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return MyFoodTitle(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodDetail(food: food)),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 340,
            collapsedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: const Text('PVD Restaurant'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(10),
              expandedTitleScale: 1,
              centerTitle: true,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyLocation(),
                  const MyDecriptionsBox(),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            // Tiêu đề "Danh sách món ăn" nằm dưới phần mô tả
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Danh sách món ăn',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: FoodCategory.values.map((category) {
                return Tab(text: category.name);
              }).toList(),
            ),
            Expanded(
              child: _isLoading // Kiểm tra trạng thái tải dữ liệu
                  ? const Center(child: CircularProgressIndicator()) // Hiển thị Loading
                  : Consumer<Restaurant>(
                      builder: (context, restaurant, child) => TabBarView(
                        controller: _tabController,
                        children: getFoodInThisCategory(restaurant.menu),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
