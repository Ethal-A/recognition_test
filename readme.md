# Recognition Test
The following web application created in Flutter is inspired by Joshua Foer's Moonwalking with Einstein: The Art and Science of Remembering Everything. The web application is an attempt at creating a very basic recognition test in which the user is flashed with images in short intervals and then must successfully recognise the images that was flashed at them.
1. Users configure the number of images to flash and the time (in milliseconds) that each image will be displayed.
2. Users then have a series of randomly shuffled images flashed at them one at a time.
3. Users then must then select one of two images at a time: one which was flashed and one which was not.
4. Users then receive a score of how many images they correctly recognised.

Please note that this is not a formal test nor is it intended to be. This is simply a small project for fun hence even the styling of the web application was kept to a bare minimum.

## Running the Web Application
For the convenience of those who do not want to install Flutter, a copy of the web application build is provided in [web_app_build](web_app_build). To run the web application, simply start a http server in that folder. The following instructions assume you have access to a terminal (such as Git Bash) and have python installed:
1. Go to the folder in a terminal `cd path/to/web_app_build`.
2. Run the command `python -m http.server 8000` inside `web_app_build`.
3. Open up a web browser and type the following into the address bar: `http://localhost:8000`.
The above instructions were tested using a Git Bash terminal and PowerShell and were successful. However, when using a Command Prompt the images would not properly appear.

## Images of the Web Application
The below images show what the web application looks like.

### Configuration Page
![Configuration Page](/screenshots/Configuration%20Page.png)
### Flash Page
![Flash Page](/screenshots/Flash%20Page.png)
### Score Page
![Score Page](/screenshots/Score%20Page.png)
### Selection Page
![Selection Page](/screenshots/Selection%20Page.png)

## Running Beyond the Web
The application can be built and run as a desktop and mobile application, however, the application was specifically designed and tested only for the web.

## Images
All images were randomly generated using a Python project titled [ranimage](https://pypi.org/project/randimage/).