# PBP Proyek Akhir Semester

### Deployment
[![Build status](https://build.appcenter.ms/v0.1/apps/e246dd95-b40c-473e-95fe-86392d935a42/branches/master/badge)](https://appcenter.ms)<br>
App Center [download link here](http://y84x.mjt.lu/lnk/CAAAA5TDjj4AAAAAAAAAAAUDkr0AAAA6pnMAAAAAAAvpOQBjl1TdHlVgQ7uqQJykxO3y4HUwkAAL-7Q/1/lO-gmA4GHsH_XQ-_cLf7nA/aHR0cHM6Ly9pbnN0YWxsLmFwcGNlbnRlci5tcy9vcmdzL1BCUC1jbGltYS9hcHBzL2RvLW5hc2kvcmVsZWFzZXMvMjI_c291cmNlJiN4M0Q7ZW1haWwmdGlkJiN4M0Q7bHVfTnpub3hONA#x3D;email&tid=lu_NznoxN4)

### Nama-nama anggota kelompok 
```
1. Dave Matthew Peter Lumban Tobing - 2106700870
2. Davyn Reinhard Santoso - 2106751083
3. Debby Trinita - 2106701072
4. Fresty Tania Stearine - 2106750742
5. Monica Oktaviona - 2106701210
```

### Deskripsi Aplikasi
Do-nasi mobile adalah aplikasi yang memberikan ruang untuk saling berbagi dan menyalurkan makanan atau uang untuk masyarakat yang membutuhkan dalam rangka memerangi masalah kelaparan di dunia.

Perancangan aplikasi ini ditujukan untuk membantu masyarakat dalam skala Indonesia dan global sehingga kita dapat mengurangi angka kelaparan global secara bersama - sama. Nantinya, pengguna dapat mendaftarkan diri sebagai pemberi donasi dan penyalur donasi (sukarelawan). Pemberi donasi dapat menawarkan bantuan melalui aplikasi dan penyalur akan menerima bantuan tersebut untuk disalurkan kepada orang - orang yang membutuhkan.

Adapun peran/aktor dari pengguna aplikasi sebagai berikut.
- Donatur\
    Pengguna yang mendaftarkan dirinya sebagai donatur dapat memberikan donasi berupa makanan atau uang tunai. 
- Penyalur\
    Pengguna yang mendaftarkan dirinya sebagai penyalur dapat menambahkan donasi baru. Kemudian, donasi tersebut ditampilkan di halaman overview/dashboard

### Daftar Modul yang akan Diimplementasikan serta Kontrak Kerja Anggota Kelompok
1. Monica Oktaviona\
   A. **Homepage**
    - Penjelasan pentingnya pangan dan visi G20 dalam meningkatkan ketahanan pangan
    - Penjelasan *introductory* web kami
    - Terdapat *interface* tombol *register* sebagai penyalur/organisas yang menyalurkan donasi pangan dan tombol *register* sebagai donatur 

   B. **Register penyalur/organisasi dan donatur**\
   C. **Autentikasi Login dan Logout**

2. Davyn Reinhard Santoso\
   **Page Harapan dari Penyalur** \
   Laman ini berisi harapan-harapan pembuka donasi untuk para donatur yang mendonasikan uang/makanan mereka 

3. Dave Matthew Peter Lumban Tobing\
   A. **Page Overview donasi**
    - tampilan untuk penyalur: penyalur dapat melihat semua donasi yang tersedia
    - tampilan untuk pemberi: pemberi dapat melihat semua donasi yang telah ia berikan beserta dengan daftar penyalur dan jumlahnya
      
   B. **Page donasi** \
   ketika pemberi udah ngeklik salah satu saluran donasi yang dipilih, dia ke redirect ke sini buat nginput donasi dia

5. Fresty Tania Stearine\
   **Q&A** \
      Berisi pertanyaan - pertanyaan dari pemberi dan jawaban - jawaban dari penyalur

6. Debby Trinita\
   **Artikel** \
      Berisi artikel - artikel yang berkaitan dengan tingkat kelaparan dunia

### Alur Pengintegrasian dengan Web Service Proyek Tengah Semester 
1. Integrasi aplikasi mobile dan web service dapat dilakukan dengan cara melakukan pengambilan data berformat JSON atau Javascript Object Notation di aplikasi mobile pada web service dengan menggunakan url `https://do-nasi.herokuapp.com/[page-name]/json/..../`

2. Proses fetch dapat dilakukan dengan menggunakan `Uri.parse` pada `Dart` terhadap link tadi, lalu mengambilnya menggunakan `get` dengan tipe `application/json`. Selanjutnya, data yang telah diambil tadi dapat di-decode menggunakan `jsonDecode()` yang nantinya akan di-convert melalui model yang telah dibuat dan ditampilkan secara asinkronus menggunakan widget `FutureBuilder`

3. Data - data JSON tadi dapat digunakan secara CRUD pada kedua media secara asinkronus

