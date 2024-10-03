
**Crypto Trading App**

This application is a helpful tool for cryptocurrency enthusiasts and traders.

With this app, you can convert between cryptocurrencies and fiat currencies using real-time exchange rates. You can view the current crypto prices and calculate how much your crypto assets are worth in USD. This app is designed to make it easier to track and manage your crypto portfolio.

***

**-Homepage:**
Upon opening the app, users are greeted with a homepage displaying the latest prices of various cryptocurrencies. Users can see details such as the name, price, and icon of each crypto asset.

**-Trade Page:**
The trade page allows users to input a cryptocurrency amount and see its equivalent value in USD. You can also swap between fiat-to-crypto and crypto-to-fiat conversions.

**-Login and Authentication:**
Certain features, like trading, are accessible only to logged-in users. Users can log in or sign out using the built-in login feature.

**-Swap Functionality:**
The app has a simple swap button that toggles between entering a crypto amount or a fiat amount (USD) to make the conversion process seamless.

***

**Technical Stack:**
Flutter: For building the UI.
GetX: Used for state management and dependency injection.
Dio: HTTP client for making API requests.
GetStorage: For local storage (used for storing user login state).
Environment Variables: API keys and sensitive data are stored in .env for security.

***

**API:**
[ExchangeRate Host API](https://exchangerate.host/) - Provides live exchange rates for various fiat currencies.
[CoinAPI](https://customerportal.coinapi.io/apikeys) - Fetches real-time cryptocurrency data, including prices and market trends.

***

**Architecture:**
The app follows the MVVM (Model-View-ViewModel) pattern for a clean and modular codebase. The MVVM pattern separates the UI logic from the core business logic, making the app more maintainable, testable, and scalable.

Layers:

Model:

Contains the core business entities like CryptoAsset and DTOs (Data Transfer Objects) for API data.
Handles the logic of converting API responses into usable objects.

View:

Widgets that display the UI to the user, like HomePage, TradePage, and custom widgets such as StickyHeader and CryptoItem.
The UI reacts to changes in the ViewModel by observing reactive states provided by GetX.

ViewModel:

Contains the business logic and state of the application.
Uses GetX to manage state and notify views of any changes in the data.
For instance, the CryptoController and TradeController handle fetching data from services, and managing crypto conversion logic, and interaction between the model and the UI.

***

# Installation

1.Clone the repository:

git clone https://github.com/ekaterinabaygin/crypto-trading-app.git
cd crypto-trading-app

2.Install the dependencies:

flutter pub get

# Environment Setup
This project uses .env file to store API keys for security purposes.
You need to create a .env file in the root directory of the project and add the necessary API keys.

**Exchange Rate Host API Key**

1.a)Visit exchangerate.host.
Create an account and generate your API key (access key).
Copy the API key.

b)CoinAPI Key
Visit CoinAPI.io to sign up and obtain your API key.
Copy the API key.

Create a .env file in the root of your project:
touch .env

2.Add the following environment variables to the .env file, 
replacing the placeholders with your actual API keys:

EXCHANGE_RATE_API_KEY=your_exchangerate_host_key
COIN_API_KEY=your_coinapi_key

