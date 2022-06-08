# pic_19
Portal Informasi Covid-19

Anggota :
Anggota 1 : Louis Margatan    	- C14190196
Anggota 2 : Iverson Krysthio		- C14190189
Anggota 3 : George Kim Anderson    - C14190201

Judul : 
Portal Informasi COVID19 (judul sementara)

Pembagian Halaman : 
Louis	 : home, rss feed, splash screen, setting.
Iverson : search hospitals and show hospital details.
George : home, rss feed, splash screen, setting.

List link API yang digunakan :
covid19.mathdro.id/api (status covid di seluruh dunia contoh: alive, dead, recovered)
Covid19-api.iversonkrysthio.repl.co (jumlah ketersediaan ruang ICU/tempat tidur pasien covid)
covid19.go.id/dokumentasi-api (RSS Feed - berita seputar kesehatan dan lain lain)

Kebutuhan Widget Per Halaman (masih belum fix) :
Splash screen : elevatedbutton.
Home : DropDownButton, listview builder, AlertDialog.
RSS Feed : card, listview builder, 
Settings : textfield,  elevatedButton.
Search hospitals : DropDownButton, listview builder, badges.
Show hospital details : listview builder.

Widget umum yang akan digunakan :
List View builder, Container, row, column, Expanded, Dropdown, Elevated Button, icon, progress indicator, bottom navigation, skeleton loading / shimmer loading, badges, dan widget pendukung lainnya.
