import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/components/water_intake_summary.dart';
import 'package:water_intake/components/water_tile.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:water_intake/models/water_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    await Provider.of<WaterData>(context, listen: false).getWater().then(
      (waters) => {
        if (waters.isNotEmpty)
          {
            setState(() {
              _isLoading = false;
            }),
          }
        else
          {
            setState(() {
              _isLoading = true;
            }),
          },
      },
    );
  }

  void saveWater() async {
    Provider.of<WaterData>(context, listen: false).addWater(
      WaterModel(
        amount: double.parse(amountController.text.toString()),
        dateTime: DateTime.now(),
        unit: 'ml',
      ),
    );

    if (!context.mounted) {
      return; // if the widget is not mounted
    }

    amountController.clear();
  }

  void addWater() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Water'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Text('Add water to your daily intake...'),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // save data to db
              saveWater();
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Water'),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.map))],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          onPressed: addWater,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            WaterIntakeSummary(startOfWeek: value.getStartOfWeek()),
            !_isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.waterDataList.length,
                    itemBuilder: (context, index) {
                      final waterModel = value.waterDataList[index];
                      return WaterTile(waterModel: waterModel);
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
