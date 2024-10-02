import 'package:flutter/material.dart';
import '../../../core/api_provider.dart';

class ExchangeRatePage extends StatefulWidget {
  const ExchangeRatePage({super.key});

  @override
  _ExchangeRatePageState createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  late Future<Map<String, dynamic>?> _exchangeRates;
  String baseCurrency = 'USD';  // Default base currency
  final List<String> symbols = ['USDEUR', 'USDGBP', 'USDJPY'];  // List of target currencies

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
  }

  void _fetchExchangeRates() {
    setState(() {
      _exchangeRates = ApiProvider().fetchLiveExchangeRates(
        baseCurrency: baseCurrency,
        symbols: symbols,  // Pass the list of target currencies
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _exchangeRates,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            final rates = snapshot.data!;

            return ListView.builder(
              itemCount: rates.length,
              itemBuilder: (context, index) {
                final currency = rates.keys.elementAt(index);
                final rate = rates[currency].toString();

                return ListTile(
                  title: Text(currency),
                  subtitle: Text('Rate: $rate'),
                );
              },
            );
          }
        },
      ),
    );
  }
}