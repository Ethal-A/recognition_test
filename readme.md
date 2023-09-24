# Recognition Test
The following web application created in flutter is inspired by Joshua Foer's Moonwalking with Einstein: The Art and Science of Remembering Everything. The web application is an attempt at creating a very basic recognition test in which the user is flashed with images in short intervals and then must successfully recognise the images that was flashed at them.
1. Users configure the number of images to flash and the time (in milliseconds) that each image will be displayed.
2. Users then have a series of randomly shuffled images flashed at them one at a time.
3. Users then must then select one of two images at a time: one which was flashed and one which was not.
4. Users then receive a score of how many images they correctly recognised.

Please note that this is not a formal test nor is it intended to be. This is simply a small project for fun hence even the styling of the web application was kept to a bare minimum.

## Running Beyond the Web
The application can be built and run as a desktop and mobile application, however, the application was specifically designed and tested only for the web.

## Images
All images were randomly generated using a Python project titled [ranimage](https://pypi.org/project/randimage/).