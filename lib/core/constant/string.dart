// App
const String appTitle = 'Urban Word';

// Networking and APIs
const String baseUrl =
    'https://mashape-community-urban-dictionary.p.rapidapi.com/define';

const String paramName = 'term';

const Map<String, String> headers = {
  'X-RapidAPI-Key': '4a65465d6cmsh0a10c05c7dd9960p1dc200jsnee2d5a8a515c',
  'X-RapidAPI-Hos': 'mashape-community-urban-dictionary.p.rapidapi.com',
};

// Routes
const String initRoute = '/init';
const String skeletonRoute = '/skeleton';
const String notFoundRoute = '/not-found';
