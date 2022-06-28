
# PIC - Portal Informasi Covid 19
![logo](https://user-images.githubusercontent.com/74914280/176128504-aea49e04-3ca2-4652-a0d5-13f8bc4d2c2e.png)

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
- widget pendukung lainnya.

**Additional Widgets Per Pages**

**Hospitals :** Scaffold, icon Button, navigator,  icon, Text, Container, Row, Column, Expanded, sizedBox, FutureBuilder, size box, DropdownButtonHideUnderline, DropdownButton, Dropdown Menu Item, gesture detector, shimmer, badge, floating action button, Image, Centre, IgnorePointer, List View builder.

**Hospital Details :** Scaffold, icon Button, Navigator, Text, Column, Row, Expanded, Container, size box, Future Builder, Centre, List View builder.

**Vaccination :**
Scaffold, iconButton, Icon, Text, Image, Container, Row, Column, Expanded, sizedBox, ListView, FutureBuilder, DropdownButtonHideUnderline, DropdownButton, DropdownMenuItem, Shimmer, floating action button, textButton, ExpansionTile
	
**Settings :**
Scaffold, text, navigator, Icon button, expanded, column, row, container, size box, slider, TextButton.

**Splash Screen :**  Scaffold, Column, Row, Container, Expanded, Image, Builder, TextButton, Navigator.

**Home Screen :**  Scaffold, IconButton, Icon, Text, Column, Row, Container, Expanded, SizedBox, List, ListView, Wrap, Image, Navigator, GestureDetector,  Scrollbar, SingleChildScrollView, FutureBuilder, Dropdownbutton2, Dropdown Menu Item, Shimmer, CachedNetworkImage.

**Settings :** IconButton, Icon, Text, Column, Row, Container, Expanded, SizedBox, SliderTheme, TextButton

**RSS Feeds :** Scaffold, Navigator, IconButton, Icon, Text, Column, Row, Container, Expanded, List, SizedBox, FutureBuilder, ListView, GestureDetector, Positioned, ClipRRect,  CachedNetworkImage, Image, Shimmer. 

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
