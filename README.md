# Weather App

<img src="https://github.com/carloshenrique-dev/weather_app/blob/master/.github/images/preview.png?raw=true" alt="Weather App Preview" width=50% height=50%>

## How to run

You only need to have the flutter in the last version in your pc :)

After that you need to clone this repo and open in vscode or android studio

Run the pub get command: 

```
    flutter pub get   
```

And now it's done, open an .dart file of the project and press F5.


## Packages and reasons

Dependencies: 

- cached_network_image
- flutter_riverpod
- freezed_annotation
- http
- json_annotation
- rive

I used riverpod for the state management because we don't need to knonw and control a lot of
states and every states in this simple app, so I decided to use because of this and because of the most simple way to control the states.

I used the cached network image package to help me to cache images, freezed to help with code generation, and json annotation do change get the correct key of the returned json and parse it in the correct way in freezed. I decided to use rive to implement a simple animation and make the app with more "life". And http to help me to retrieve the data from the [OpenWeatherMap API](https://openweathermap.org/api).


Dev dependencies:

- mocktail

I decided to use mocktail to implement tests in the most simple way with sound null safety

## Features

- [x] Current weather of the search
- [x] 5-day weather forecast
- [x] Search by city

## With more time...

I would like to implement:
 - Geolocation to make the app more indenpendent
 - Some kind of notifications
 - Maybe a feature like get the weather and the forecast in background based in the location