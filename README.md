# PBP Proyek Akhir Semester

### Nama-nama anggota kelompok 
```
1. Dave Matthew Peter Lumban Tobing - 2106700870
2. Davyn Reinhard Santoso - 2106751083
3. Debby Trinita - 2106701072
4. Fresty Tania Stearine - 2106750742
5. Monica Oktaviona - 2106701210
```

### Deskripsi aplikasi (nama aplikasi, fungsi aplikasi, dan peran/aktor pengguna aplikasi)
Do-nasi mobile adalah aplikasi yang memberikan ruang untuk saling berbagi dan menyalurkan makanan atau uang untuk masyarakat yang membutuhkan dalam rangka memerangi masalah kelaparan di dunia.

Perancangan aplikasi ini ditujukan untuk membantu masyarakat dalam skala Indonesia dan global sehingga kita dapat mengurangi angka kelaparan global secara bersama - sama. Nantinya, pengguna dapat mendaftarkan diri sebagai pemberi donasi dan penyalur donasi (sukarelawan). Pemberi donasi dapat menawarkan bantuan melalui aplikasi dan penyalur akan menerima bantuan tersebut untuk disalurkan kepada orang - orang yang membutuhkan.

Adapun peran/aktor dari pengguna aplikasi sebagai berikut.
- Donatur <br>
    Pengguna yang mendaftarkan dirinya sebagai donatur dapat memberikan donasi berupa makanan atau uang tunai. 
- Penyalur <br>
    Pengguna yang mendaftarkan dirinya sebagai penyalur dapat menambahkan donasi baru. Kemudian, donasi tersebut ditampilkan di halaman overview/dashboard

### Daftar fitur atau modul yang diimplementasikan beserta kontrak kinerja per anggota kelompok
1. Monica Oktaviona
   A) Homepage
      - Penjelasan pentingnya pangan dan visi G20 dalam meningkatkan ketahanan pangan
      - Penjelasan *introductory* web kami
      - Terdapat *interface* tombol *register* sebagai penyalur/organisas yang menyalurkan donasi pangan dan tombol *register* sebagai donatur
   B) Register penyalur/organisasi dan donatur
   C) Autentikasi Login dan Logout

2. Davyn Reinhard Santoso
   A) Page Harapan dari Penyalur
      Laman ini berisi harapan-harapan pembuka donasi untuk para donatur yang mendonasikan uang/makanan mereka 

3. Dave Matthew Peter Lumban Tobing
   A) Page Overview donasi
      - tampilan untuk penyalur: penyalur dapat melihat semua donasi yang tersedia
      - tampilan untuk pemberi: pemberi dapat melihat semua donasi yang telah ia berikan beserta dengan daftar penyalur dan jumlahnya
      
   B) Page donasi
       - ketika pemberi udah ngeklik salah satu saluran donasi yang dipilih, dia ke redirect ke sini buat nginput donasi dia

5. Fresty Tania Stearine
   A) Artikel 
      Berisi pertanyaan - pertanyaan dari pemberi dan jawaban - jawaban dari penyalur

6. Debby Trinita
   A) Q&A 
      Berisi artikel - artikel yang berkaitan dengan tingkat kelaparan dunia

#### Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester 
1. Integrasi aplikasi mobile dan web service dapat dilakukan dengan cara melakukan pengambilan data berformat JSON atau Javascript Object Notation di aplikasi mobile pada web service dengan menggunakan url `https://do-nasi.herokuapp.com/[page-name]/json/..../`

2. Proses fetch dapat dilakukan dengan menggunakan `Uri.parse` pada `Dart` terhadap link tadi, lalu mengambilnya menggunakan `get` dengan tipe `application/json`. Selanjutnya, data yang telah diambil tadi dapat di-decode menggunakan `jsonDecode()` yang nantinya akan di-convert melalui model yang telah dibuat dan ditampilkan secara asinkronus menggunakan widget `FutureBuilder`

3. Data - data JSON tadi dapat digunakan secara CRUD pada kedua media secara asinkronus