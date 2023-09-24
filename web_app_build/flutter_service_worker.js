'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "7bb9b2042ff2cba6f4418671bd751d8c",
"assets/AssetManifest.json": "12224c86e241a1af24da4201937cc4ce",
"assets/assets/images/0.png": "5ddb67ba1f8453af20055d8ecf75d3f9",
"assets/assets/images/1.png": "3c3fe68ba3e833279796c1d55b53ad3d",
"assets/assets/images/10.png": "9917089b135369c27082835f24854492",
"assets/assets/images/11.png": "8cbb59f2ce743ee1ccd2d7f1d6898d28",
"assets/assets/images/12.png": "89a54407698da86bf78045bd566a44e2",
"assets/assets/images/13.png": "332f78f97899b8eb70fd1162cd9183dc",
"assets/assets/images/14.png": "942f50fb69f43c77e640be2590574bea",
"assets/assets/images/15.png": "787e181148f2629b684c5c8072914e50",
"assets/assets/images/16.png": "863c94b51ccccc23e1e61ce74f008858",
"assets/assets/images/17.png": "8cc69b6b5213096c641bcfb8be5d9b51",
"assets/assets/images/18.png": "68e1dafc7b780c2054395fe4b73b7f50",
"assets/assets/images/19.png": "ada7798f9616701f63f38108f1a25109",
"assets/assets/images/2.png": "172ad4b672c7f0a46c02b52e28627215",
"assets/assets/images/20.png": "998d1027f0e39afdaf99bfe73ef7205b",
"assets/assets/images/21.png": "9af469a74fa00d4689f8efa9b2dddf56",
"assets/assets/images/22.png": "1c3c15ea6941a948af81526ae7375c14",
"assets/assets/images/23.png": "80a139ddff8a68714e028dfad8b3b177",
"assets/assets/images/24.png": "5a00a63e84aa261f88c256cd15d6d57e",
"assets/assets/images/25.png": "9a0ddccd0820bfeb066ecc2ddb38cd06",
"assets/assets/images/26.png": "89df4b0a127308255ed566ce3b8671dd",
"assets/assets/images/27.png": "8305f9688f5b00ace80b7507cd172f3b",
"assets/assets/images/28.png": "84b67916193638e4d4d003d4990f23bf",
"assets/assets/images/29.png": "44211a4e4ff771f6f06fbeb711b83761",
"assets/assets/images/3.png": "0049c22ff3a46fefb19a054ea6476525",
"assets/assets/images/30.png": "2e987dd4f25dbf7b1e976b133a4178d5",
"assets/assets/images/31.png": "f94c71299246870c06131c39965a14c2",
"assets/assets/images/32.png": "fb98b1e132c274b487e3fbc1af6a2165",
"assets/assets/images/33.png": "ab2d4c98c77b2fbf320bc6079f4b663c",
"assets/assets/images/34.png": "368b7bec8d499485d4f46c4270c49187",
"assets/assets/images/35.png": "d7b759c98e18d7167ac6629756bd6ffc",
"assets/assets/images/36.png": "fbefb87a5b612d6992271247bdffa82a",
"assets/assets/images/37.png": "cf591acb3e16977e525ca8e4e5973a83",
"assets/assets/images/38.png": "9df7d63b1960adef0a531751367e8ffb",
"assets/assets/images/39.png": "7ae658e6f4dd784f3db90f72ecae8696",
"assets/assets/images/4.png": "c00668a2986a132806f415b473f6abf5",
"assets/assets/images/40.png": "859554112a8148d134a0a24029a37f51",
"assets/assets/images/41.png": "97538c43c0b76c4df566e7c7b5951bed",
"assets/assets/images/42.png": "d31d99f9af3c72d368ce7ca7709f1e10",
"assets/assets/images/43.png": "8a2b8d0ac20f01d7e14fc4eaf4c5e705",
"assets/assets/images/44.png": "bfa9bc41895a017cdc6fe7ad25f55d3c",
"assets/assets/images/45.png": "f243982722b64444a3535bc274644487",
"assets/assets/images/46.png": "de5a556fccdf8b4b0b394545518c9c8d",
"assets/assets/images/47.png": "8cd1a2573efb4b668993e36aa4888114",
"assets/assets/images/48.png": "807debfed04a1161ca1239300c04e120",
"assets/assets/images/49.png": "716b99a5700e8d03a78e33c3d2736d23",
"assets/assets/images/5.png": "241159df6a4a0ea13316a299a60ba787",
"assets/assets/images/50.png": "000920c3251bd74dc24f2b95c45c6966",
"assets/assets/images/51.png": "dd564bd511e2ba98ac1ebc4fcbc1c784",
"assets/assets/images/52.png": "e216843d21de694d494ef3a8f526a65b",
"assets/assets/images/53.png": "1b0d236d8d3dc861675d5b90f9ac770e",
"assets/assets/images/54.png": "10c0ed4625fbad9547a7a4a22f01cb68",
"assets/assets/images/55.png": "f1ce6562eca9a72615615d6ff079a45b",
"assets/assets/images/56.png": "8f342898be132af78b52295e854fd3ec",
"assets/assets/images/57.png": "b8dc06d72afa1d4421f2aa34c87bd91b",
"assets/assets/images/58.png": "1852e667c01988230d939c22d4ce8929",
"assets/assets/images/59.png": "4a6c7dd2aca5dd2cab1b2122a588d010",
"assets/assets/images/6.png": "a5a44e3930d34ef8df458b7df714f755",
"assets/assets/images/7.png": "5f62cb0d926ffd2e2044808117477645",
"assets/assets/images/8.png": "9838d7a8f644becd086860d7d5b9d5a5",
"assets/assets/images/9.png": "4a5df57a7db4b33d16fcae3926ec3131",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "32fce58e2acb9c420eab0fe7b828b761",
"assets/NOTICES": "b332f89be89e6c68fb23db3f724ebb46",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "7ea0b43941834ea379bf84b0f4ffc560",
"/": "7ea0b43941834ea379bf84b0f4ffc560",
"main.dart.js": "abd590e03a42cafd2ac4ac283718c5c9",
"manifest.json": "0b59a8e99c3c96c7407817584e4ca7dc",
"version.json": "0fde8d60adece815b25dfc51650e7111"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
