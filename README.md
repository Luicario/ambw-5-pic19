
# **PIC - Portal Informasi Covid 19**

<p align="center" width="100%">
<img src="https://user-images.githubusercontent.com/74914280/176128504-aea49e04-3ca2-4652-a0d5-13f8bc4d2c2e.png" width=200>
</p>

## About
Portal Informasi Covid, yang dimana aplikasi menampilkan :
- Berita seputar kesehatan/covid19
- Status covid di seluruh dunia
- Fasilitas Vaksin di Indonesia
- Jumlah ketersediaan ruang ICU/tempat tidur pasien covid di seluruh rumah sakit di Indonesia



## Features

- Data Total deaths, Recovered, Confirmed case.
- Data Faskes - kamar pasien (khusus pasien covid19).
- Data Faskes vaksinasi.
- RSS Feed News.
- Show popup warning (with condition) case per day.


## Our Team
Kelompok 5 - AMBW
- [Louis Margatan](https://github.com/Luicario)
- [Iverson Krysthio](https://github.com/iberso)
- [George Kim](https://github.com/ge0rgekim)

## API Reference
- [covid19.iversonkrysthio.repl.co](https://covid19.iversonkrysthio.repl.co) (Temporary deployed)
- [covid19.go.id/dokumentasi-api](https://covid19.go.id/dokumentasi-api )
- [api.vaksinasi.id](https://api.vaksinasi.id)



## Widgets
Common widgets used by each page
- ListView
- Container
- Row and Column
- Expanded
- Dropdown
- Elevated Button
- Icon
- Progress Indicator
- Bottom navigation
- Skeleton loading
- Shimmer loading
- Badges
- Touch Ripple Effect
- widget pendukung lainnya.

**Additional Widgets Per Pages**

- **Hospitals :** Scaffold, icon Button, navigator,  icon, Text, Container, Row, Column, Expanded, sizedBox, FutureBuilder, size box, DropdownButtonHideUnderline, DropdownButton, Dropdown Menu Item, gesture detector, shimmer, badge, floating action button, Image, Centre, IgnorePointer, List View builder.

- **Hospital Details :** Scaffold, icon Button, Navigator, Text, Column, Row, Expanded, Container, size box, Future Builder, Centre, List View builder.

- **Vaccination :**
Scaffold, iconButton, Icon, Text, Image, Container, Row, Column, Expanded, sizedBox, ListView, FutureBuilder, DropdownButtonHideUnderline, DropdownButton, DropdownMenuItem, Shimmer, floating action button, textButton, ExpansionTile
	
- **Settings :**
Scaffold, text, navigator, Icon button, expanded, column, row, container, size box, slider, TextButton.

- **Splash Screen :**  Scaffold, Column, Row, Container, Expanded, Image, Builder, TextButton, Navigator.

- **Home Screen :**  Scaffold, IconButton, Icon, Text, Column, Row, Container, Expanded, SizedBox, List, ListView, Wrap, Image, Navigator, Touch Ripple Effect,  Scrollbar, SingleChildScrollView, FutureBuilder, Dropdownbutton2, Dropdown Menu Item, Shimmer, CachedNetworkImage,animated flip counter.

- **Settings :** IconButton, Icon, Text, Column, Row, Container, Expanded, SizedBox, SliderTheme, TextButton

- **RSS Feeds :** Scaffold, Navigator, IconButton, Icon, Text, Column, Row, Container, Expanded, List, SizedBox, FutureBuilder, ListView, Touch Ripple Effect, Positioned, ClipRRect,  CachedNetworkImage, Image, Shimmer. 

## Dependency
- [Shimmer](https://pub.dev/packages/shimmer)
- [Badges](https://pub.dev/packages/badges)
- [Dropdown Button](https://pub.dev/packages/dropdown_button2)
- [XML](https://pub.dev/packages/xml)
- [Money Formatter](https://pub.dev/packages/money_formatter)
- [Cached Network Image](https://pub.dev/packages/cached_network_image)
- [HTTP](https://pub.dev/packages/http)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Google Fonts](https://pub.dev/packages/google_fonts)
- [Url Launcher](https://pub.dev/packages/url_launcher)
- [Configurable Expansion Tile](https://pub.dev/packages/configurable_expansion_tile_null_safety)
- [Touch Ripple Effect](https://pub.dev/packages/touch_ripple_effect)
- [Animated Flip Counter](https://pub.dev/packages/animated_flip_counter)
- [Flutter Icon Launcher](https://pub.dev/packages/flutter_launcher_icons)
## Credit
All image assets used in our application are taken from
- [StorySet](https://storyset.com/)
- [Flaticon](https://www.flaticon.com/)
- [Freepik](https://www.freepik.com/)

## Reference
- [Flutter color hex : How to use hex colors in Flutter?](https://educity.app/flutter/how-to-use-hexadecimal-color-string-in-flutter)
- [Flutter disable bottom border on focus](https://www.codegrepper.com/code-examples/dart/flutter+disable+bottom+border+on+focus)
- [Leading property](https://api.flutter.dev/flutter/material/AppBar/leading.html)
- [Customizing the AppBar in Flutter: An overview with examples](https://blog.logrocket.com/flutter-appbar-tutorial/#:~:text=Customizing%20the%20AppBar-,What%20is%20the%20AppBar%20in%20Flutter%3F,other%20widgets%20within%20its%20layout)
- [Control & disable a dropdown button in flutter?](https://stackoverflow.com/questions/49693131/control-disable-a-dropdown-button-in-flutter)
- [Flutter – How to scroll ListView to top or bottom programmatically](https://coflutter.com/flutter-how-to-scroll-listview-to-top-or-bottom-programmatically/)
- [Flutter Tutorial - Parsing XML and JSON Data | Dart](https://www.youtube.com/watch?v=sTXboh2K2Dw)
- [How to remove the divider lines of an ExpansionTile when expanded in Flutter](https://stackoverflow.com/questions/62667990/how-to-remove-the-divider-lines-of-an-expansiontile-when-expanded-in-flutter)
- [ExpansionPanel (Flutter Widget of the Week)](https://www.youtube.com/watch?v=2aJZzRMziJc)
- [Flutter Tutorial - Slider [2021]](https://www.youtube.com/watch?v=vuw818gAlF8)
- [Flutter Tutorial - Add Custom Fonts & Google Fonts](https://www.youtube.com/watch?v=Gf-cyiWlmEI)
- [How to change the default font family in Flutter](https://stackoverflow.com/questions/64237031/how-to-change-the-default-font-family-in-flutter)
- [Flutter Tutorial - How to Change App Icon and App Name | The Right Way [2021] Android & iOS](https://www.youtube.com/watch?v=eMHbgIgJyUQ)

## Pembagian Kerja Per Halaman
- [Louis Margatan](https://github.com/Luicario) : settings, search, dan lokasi vaksinasi.
- [Iverson Krysthio](https://github.com/iberso) : search hospitals dan hospital detail.
- [George Kim](https://github.com/ge0rgekim) : splash screen, home screen, and rss feed.

## **TODO LIST**

No | Todo | PIC | Status
| :--- | :---: | :---: | :--:
1  | Splash Screen | George | ✅
2  | Home Screen | George | ✅
3 | Rss Feed | George | ✅
4 | Search Hospitals | Iverson | ✅
5 | Hospital Details | Iverson | ✅
6 | Search Vaccination | Louis | ✅
7 | Settings | Louis | ✅

**Status Icon**
No | Status | Icon |
| :---: | :--- | :---: |
1 | Done | ✅
2 | On-Going | 💻
3 | Not yet started | 🚧


