# crypto_trading_app

This is a Flutter-based Crypto Trading App that allows users to view live crypto asset prices,
calculate fiat equivalents for cryptocurrencies, and perform crypto-to-fiat conversions.

The app uses GetX for state management and relies on exchangerate.host for fiat exchange rates 
and CoinAPI for cryptocurrency data.

The project follows a clean architecture approach.

# Features

**Crypto Conversion**: 
Users can input a cryptocurrency amount and get the equivalent value in USD.

**Fiat-to-Crypto Conversion**:
Users can input a fiat amount (USD) and see the corresponding value in a selected cryptocurrency.

**Swap Functionality**: Toggle between crypto-to-fiat and fiat-to-crypto inputs.

**Real-Time Exchange Rates**: Fetches live exchange rates from exchangerate.host.

**Login/Logout**: Basic login functionality to restrict access to certain features.

# Installation

1.Clone the repository:

git clone https://github.com/your-username/crypto-trading-app.git
cd crypto-trading-app

2.Install the dependencies:

flutter pub get

# Environment Setup
This project uses .env file to store API keys for security purposes.
You need to create a .env file in the root directory of the project and add the necessary API keys.

**Exchange Rate Host API Key**

1.Visit exchangerate.host.
Create an account and generate your API key (access key).
Copy the API key.
CoinAPI Key
Visit CoinAPI.io to sign up and obtain your API key.
Copy the API key.
Creating .env File

Create a .env file in the root of your project:
touch .env

2.Add the following environment variables to the .env file, 
replacing the placeholders with your actual API keys:

EXCHANGE_RATE_API_KEY=your_exchangerate_host_key
COIN_API_KEY=your_coinapi_key

# Run the App
Once the environment variables are set up:
flutter run

Start the development server:
flutter run -d <device-id>