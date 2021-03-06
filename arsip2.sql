
CREATE TABLE gender(
	id_gender char(1) NOT NULL,
	nama varchar(12) NOT NULL,
	PRIMARY KEY (id_gender)
    
);

CREATE TABLE permission(
	id_permission char(5) NOT NULL,
   	readfile boolean NOT NULL,
   	writefile boolean NOT NULL,
    PRIMARY KEY (id_permission)
);

CREATE TABLE jabatan(
	id_jabatan char(5) NOT NULL,
   	nama varchar(100) NOT NULL,
    PRIMARY KEY (id_jabatan)
);

CREATE TABLE jenis_arsip(
	id_jenisarsip char(5) NOT NULL,
	nama VARCHAR (100) NOT NULL,
	PRIMARY KEY (id_jenisarsip)
);

CREATE TABLE kode(
	id_kode char(9) NOT NULL,
	nama VARCHAR(200) NOT NULL,
	PRIMARY KEY (id_kode)
);

CREATE TABLE klasifikasi(
	id_klasifikasi char(10),
	id_kode char(9),
	id_jabatan char(5),
	id_permission char(5),
	PRIMARY KEY (id_klasifikasi),
	FOREIGN KEY (id_kode) REFERENCES kode(id_kode),
	FOREIGN KEY (id_jabatan) REFERENCES jabatan(id_jabatan),
	FOREIGN KEY (id_permission) REFERENCES permission(id_permission)
);


CREATE TABLE userlogin(
    id_user char(10) NOT NULL,
    password CHAR(60) NOT NULL,
    username CHAR(60) NOT NULL,
    email varchar(255) NOT NULL,
    tipe varchar(5) NOT NULL,
    PRIMARY KEY (id_user)
);

CREATE TABLE datapengguna(
	id_datapengguna char(10) NOT NULL,
    nip char(18) NOT NULL,
	nama varchar(255) NOT NULL,
	tgl_lahir date NOT NULL,
	foto_profil varchar(100) DEFAULT 'undefined',
	create_time datetime,
	update_time datetime,
	id_gender char(1),
	id_jabatan char(5),
    id_user char(10),
	PRIMARY KEY (id_datapengguna),
    FOREIGN KEY (id_jabatan) REFERENCES jabatan(id_jabatan),
    FOREIGN KEY (id_user) REFERENCES userlogin(id_user),
    FOREIGN KEY (id_gender) REFERENCES gender(id_gender)
);


/*Lampiran atau Surat*/
CREATE TABLE dokumen(
	id_dokumen char(20) NOT NULL,
	nama varchar(255) NOT NULL,
	ekstensi varchar(5),
	byte_file varchar(10),
	type_file VARCHAR(10),
	create_time datetime,
	update_time datetime,
	PRIMARY KEY (id_dokumen)
);

CREATE TABLE surat_masuk(
	id_suratmasuk char(20),
	id_dokumen CHAR(20),
	id_kode char(9),
	id_upload char(10),
	asal_surat varchar(254),
    /*klasifikasi*/ VARCHAR(254),
    isi_ringkas varchar(254),
    keterangan varchar(254),
	lokasi_arsip VARCHAR(100),
    tgl_penerimaan date,
    tgl_pembuatan date,
	create_time datetime,
	update_time datetime,
	PRIMARY KEY (id_suratmasuk),
	FOREIGN KEY (id_dokumen) REFERENCES dokumen(id_dokumen),
	FOREIGN KEY (id_kode) REFERENCES kode(id_kode),
	FOREIGN KEY (id_upload) REFERENCES datapengguna(id_datapengguna)
);

CREATE TABLE surat_keluar(
	id_suratkeluar char(20),
	id_dokumen CHAR(20),
	id_kode char(9),
	id_upload char(10),
	surat_dikirim varchar(254),
    /*klasifikasi VARCHAR(254),*/
    isi_ringkas varchar(254),
    keterangan varchar(254),
	lokasi_arsip VARCHAR(100),
    tgl_penerimaan date,
    tgl_pembuatan date,
	create_time datetime,
	update_time datetime,
	PRIMARY KEY (id_suratkeluar),
	FOREIGN KEY (id_dokumen) REFERENCES dokumen(id_dokumen),
	FOREIGN KEY (id_kode) REFERENCES kode(id_kode),
	FOREIGN KEY (id_upload) REFERENCES datapengguna(id_datapengguna)
);

CREATE TABLE disposisi(
    id_disposisi char(20),
    id_dokumen char(20),
    id_kode char(9),
    id_upload char(10),
    no_agenda varchar (50),
    perihal varchar(254),
    dituju varchar(254),
    pengirim varchar(254),
    isi_disposisi varchar(500),
    tgl_penerimaan date,
    tgl_pembuatan date,
    create_time datetime,
    update_time datetime,
    PRIMARY KEY (id_disposisi),
	FOREIGN KEY (id_dokumen) REFERENCES dokumen(id_dokumen),
	FOREIGN KEY (id_kode) REFERENCES kode(id_kode),
	FOREIGN KEY (id_upload) REFERENCES datapengguna(id_datapengguna)
);

/*----------------------ADMIN TABLES-------------------------------*/
CREATE TABLE admindata(
    id_admin char(10),
    nama VARCHAR(254),
    password VARCHAR(60)
)


CREATE TABLE log_tipe(
    id_logtipe char(5),
    nama VARCHAR(100),
    PRIMARY KEY (id_logtipe)
);

CREATE TABLE lupapass(
    id_lupapass char(10),
    kodeganti varchar(30),
    id_user char(10)
);

CREATE TABLE log_activity(
    id_log char(20),
    id_logtipe char(5),
    description varchar(254),
    PRIMARY KEY (id_log),
    FOREIGN KEY (id_logtipe) REFERENCES log_tipe(id_logtipe)
);

CREATE TABLE banakun(
    id_ban char (10),
    id_user char(10),
    start_date date,
    finish_date date,
    alasan varchar(255),
    PRIMARY KEY (id_ban),
    FOREIGN KEY (id_user) REFERENCES userlogin(id_user)
);


INSERT INTO gender VALUES ( 'M', 'Laki-laki'),
( 'F', 'Perempuan');

INSERT INTO jabatan VALUES ('JB000','SUPER ADMIN');

INSERT INTO userlogin VALUES ('USL0000000','$2y$10$q07PTe3qt8PIGXPlBRfrQ.wKXHH6fOllpx49ze33eVQCdpZv73QSa','admin','herlandrotoz@gmail.com');

INSERT INTO datapengguna VALUES ('ADM0000000','010203040506070809','Herlandro Tribiakto','1999-09-10','undefined','2020-02-10','2020-02-10','M','JB000','USL0000000');

INSERT INTO log_tipe VALUES
("LT001","New Account"),
("LT002","Delete Account"),
("LT003","Edit Account"),
("LT004","Change Password"),
("LT005","New Surat"),
("LT006","Edit Surat"),
("LT007","Delete Surat"),
("LT008","Upload Document"),
("LT009","Ban Account"),
("LT010","Unban Account"),
("LT011","Default Value");

INSERT INTO jabatan VALUES
    ('JB001','Kepala Desa'),
    ('JB002','Kepala Seksi Pemerintahan'),
    ('JB003','Kepala Seksi Kesejahteraan'),
    ('JB004','Kepala Seksi Pelayanan'),
    ('JB005','Kepala Urusan Tata Usaha'),
    ('JB006','Kepala Urusan Keuangan'),
    ('JB007','Kepala Urusan Perencanaan'),
    ('JB008','Dukuh'),
    ('JB009','Staf'),
    ('JB010','Ketua - BPD'),
    ('JB011','Wakil Ketua - BPD'),
    ('JB012','Sekretaris - BPD'),
    ('JB013','Ketua POKJA Pemerintahan - BPD'),
    ('JB014','Ketua POKJA Kemasyarakatan - BPD'),
    ('JB015','Ketua POKJA Pembangunan - BPD'),
    ('JB016','Anggota - BPD'),
    ('JB017','Rukun Tetangga (RT)'),
    ('JB018','Rukun Warga (RW)');

INSERT INTO kode VALUES
    ('140.0.0.0','PEMERINTAHAN DESA / KELURAHAN'),
    ('141.0.0.0','Pamong Desa, Meliputi: Pencalonan, Pemilihan, Meninggal, Pengangkatan, Pemberhenian.'),
    ('142.0.0.0','Penghasilan Pamong Desa'),
    ('143.0.0.0','Kekayaan Desa'),
    ('144.0.0.0','Dewan Tingkat Desa, Dewan Marga, Rembug Desa'),
    ('145.0.0.0','Administrasi Desa'),
    ('146.0.0.0','Kewilayahan'),
    ('146.1.0.0','Pembentukan Desa/Kelurahan'),
    ('146.2.0.0','Pemekaran Desa/Kelurahan'),
    ('146.3.0.0','Perubahan Batas Wilayah / Perluasan Desa / Kelurahan'),
    ('146.4.0.0','Perubahan Nama Desa / Kelurahan'),
    ('146.5.0.0','Kerjasama Antar Desa / Kelurahan'),
    ('147.0.0.0','Lembaga-lembaga Tingkat Desa'),
    ('148.0.0.0','Perangkat Kelurahan'),
    ('148.1.0.0','Kepala Kelurahan'),
    ('148.2.0.0','Sekretaris Kelurahan'),
    ('148.3.0.0','Staf Kelurahan'),
    ('149.0.0.0','Dewan Kelurahan'),
    ('149.1.0.0','Rukun Tetangga'),
    ('149.2.0.0','Rukun Warga'),
    ('149.3.0.0','Rukun Kampung'),
    ('150.0.0.0','Legislatif MPR/DPR/DPD'),
    ('151.0.0.0','Keanggotaan MPR'),
    ('151.1.0.0','Pencalonan'),
    ('151.2.0.0','Pemberhentian'),
    ('151.3.0.0','Recall'),
    ('151.4.0.0','Pelanggaran'),
    ('152.0.0.0','Persidangan'),
    ('153.0.0.0','Kesejahteraan'),
    ('153.1.0.0','Keuangan'),
    ('153.2.0.0','Penghargaan'),
    ('154.0.0.0','Hak'),
    ('155.0.0.0','Keanggotaan DPR Pencalonan Pengangkatan'),
    ('156.0.0.0','Persidangan Sidang Pleno Dengan Pendapat / Rapat Komisi Reces'),
    ('157.0.0.0','Kesejahteraan'),
    ('157.1.0.0','Keuangan'),
    ('157.2.0.0','Penghargaan'),
    ('158.0.0.0','Jawaban Pemerintah'),
    ('159.0.0.0','Hak'),
    ('160.0.0.0','DPRD PROVINSI '),
    ('161.0.0.0','Keanggotaan'),
    ('161.1.0.0','Pencalonan'),
    ('161.2.0.0','Pengangkatan'),
    ('161.3.0.0','Pemberhentian'),
    ('161.4.0.0','Recall'),
    ('161.5.0.0','Meninggal'),
    ('161.6.0.0','Pelanggaran'),
    ('162.0.0.0','Persidangan'),
    ('162.1.0.0','Reses'),
    ('163.0.0.0','Kesejahteraan'),
    ('163.1.0.0','Keuangan'),
    ('163.2.0.0','Penghargaan'),
    ('164.0.0.0','Hak'),
    ('165.0.0.0','Sekretaris DPRD Provinsi'),
    ('170.0.0.0','DPRD KABUPATEN'),
    ('171.0.0.0','Keanggotaan'),
    ('171.1.0.0','Pencalonan'),
    ('171.2.0.0','Pengangkatan'),
    ('171.3.0.0','Pemberhentian'),
    ('171.4.0.0','Recall'),
    ('171.5.0.0','Pelanggaran'),
    ('172.0.0.0','Persidangan'),
    ('173.0.0.0','Kesejahteraan'),
    ('173.1.0.0','Keuangan'),
    ('173.2.0.0','Penghargaan'),
    ('174.0.0.0','Hak'),
    ('175.0.0.0','Sekretaris DPRD Kabupaten / Kota'),
    ('180.0.0.0','HUKUM'),
    ('180.1.0.0','Konstitusi'),
    ('180.1.1.0','Dasar Negara'),
    ('180.1.2.0','Undang – Undang Dasar'),
    ('180.2.0.0','GBHN'),
    ('180.3.0.0','Amnesti, Abolisi, dan Grasi'),
    ('181.0.0.0','Perdata'),
    ('181.1.0.0','Tanah'),
    ('181.2.0.0','Rumah'),
    ('181.3.0.0','Utang / Piutang'),
    ('181.3.1.0','Gadai'),
    ('181.3.2.0','Hipotik'),
    ('181.4.0.0','Notariat'),
    ('182.0.0.0','Pidana'),
    ('182.1.0.0','Penyidik Pegawai Negeri Sipil (PPNS)'),
    ('183.0.0.0','Peradilan'),
    ('183.1.0.0','Bantuan Hukum'),
    ('184.0.0.0','Hukum International'),
    ('185.0.0.0','Imigrasi'),
    ('185.1.0.0','Visa'),
    ('185.2.0.0','Paspor'),
    ('185.3.0.0','Exit'),
    ('185.4.0.0','Reentry'),
    ('185.5.0.0','Lintas Batas / Batas antar Negara'),
    ('186.0.0.0','Kepenjaraan'),
    ('187.0.0.0','Kejaksaan'),
    ('188.0.0.0','Peraturan Perundang-undangan'),
    ('188.1.0.0','TAP MPR'),
    ('188.2.0.0','Undang-undang'),
    ('188.3.0.0','Peraturan'),
    ('188.3.1.0','Peraturan Pemerintah'),
    ('188.3.2.0','Peraturan Menteri'),
    ('188.3.3.0','Peraturan Lembaga Non Departemen'),
    ('188.3.4.0','Peraturan Daerah'),
    ('188.3.4.1','Peraturan'),
    ('188.3.4.2','Peraturan Kabupaten / Kota'),
    ('188.4.0.0','Keputusan'),
    ('188.4.1.0','Presiden'),
    ('188.4.2.0','Menteri'),
    ('188.4.3.0','Lembaga Non Departemen'),
    ('188.4.4.0','Gubernur'),
    ('188.4.5.0','Bupati / Walikota'),
    ('188.5.0.0','Instruksi'),
    ('188.5.1.0','Presiden'),
    ('188.5.2.0','Menteri'),
    ('188.5.3.0','Lembaga Non Departemen'),
    ('188.5.4.0','Gubernur'),
    ('188.5.5.0','Bupati / Walikota'),
    ('189.0.0.0','Hukum Adat'),
    ('189.1.0.0','Tokoh Adat / Masyarakat'),
    ('190.0.0.0','HUBUNGAN LUAR NEGERI'),
    ('191.0.0.0','Perwakilan Asing'),
    ('192.0.0.0','Tamu Negara'),
    ('193.0.0.0','Kerjasama dengan Negara Asing'),
    ('193.1.0.0','Asean'),
    ('193.2.0.0','Bamtuan Luar Negeri / Hibah'),
    ('194.0.0.0','Perwakilan RI DI Luar Negeri / Hibah'),
    ('195.0.0.0',' PBB'),
    ('196.0.0.0','Laporan Luar Negeri'),
    ('197.0.0.0','Hutang Luar Negeri PHLN / LOAN'),
    ('200.0.0.0','POLITIK'),
    ('201.0.0.0','Kebijaksanaan Umum'),
    ('202.0.0.0','Orde Baru'),
    ('203.0.0.0','Reformasi'),
    ('210.0.0.0','KEPARTAIAN'),
    ('211.0.0.0','Lambang Partai'),
    ('212.0.0.0','Kartu Tanda Anggota'),
    ('213.0.0.0','Bantuan Keuangan Parpol'),
    ('220.0.0.0','ORGANISASI KEMASYARAKATAN'),
    ('221.0.0.0','Berdasarkan Perjuangan'),
    ('221.1.0.0','Perintis Kemerdekaan'),
    ('221.2.0.0','Angkatan 45'),
    ('221.3.0.0','Veteran'),
    ('222.0.0.0','Berdasarkan Kekaryaan'),
    ('222.1.0.0','PEPBAPKI'),
    ('222.2.0.0','Wredatama'),
    ('223.0.0.0','Berdasarkan Kerohanian'),
    ('224.0.0.0','Lembaga Adat'),
    ('225.0.0.0','Lembaga Swadaya Masyarakat'),
    ('230.0.0.0','ORGANISASI PROFESI DAN FUNGSIONAL'),
    ('231.0.0.0','Ikatan Dokter Indonesia'),
    ('232.0.0.0','Persatuan Guru Republik Indonesia'),
    ('233.0.0.0','PERSATUAN SARJANA HUKUM INDONESIA'),
    ('234.0.0.0','Persatuan Advokat Indonesia'),
    ('235.0.0.0','Lembaga Bantuan Hukum'),
    ('236.0.0.0','Korps Pegawai Republik Indonesia'),
    ('237.0.0.0','Persatuan Wartawan Indonesia'),
    ('238.0.0.0','Ikatan Cendekiawan Muslim Indonesia (ICMII)'),
    ('239.0.0.0','Organisasi Profesi dan Fungsional lainnya'),
    ('240.0.0.0','ORGANISASI PEMUDA'),
    ('241.0.0.0','Komite Nasional Pemuda Indonesia'),
    ('242.0.0.0','Organisasi Mahasiswa'),
    ('243.0.0.0','Organisasi Pelajar'),
    ('244.0.0.0','Gerakan Pemuda Ansor'),
    ('245.0.0.0','Gerakan Pemuda Islam Indonesia'),
    ('246.0.0.0','Gerakan Pemuda Marhaenis'),
    ('250.0.0.0','ORGANISASI BURUH, TANI, NELAYAN DAN ANGKUTAN'),
    ('251.0.0.0','Federasi Buruh Seluruh Indonesia'),
    ('252.0.0.0','Organisasi Buruh International'),
    ('253.0.0.0','Himpunan Kerukunan Tani Indonesia'),
    ('254.0.0.0','Himpunan Nelayan Seluruh Indonesia'),
    ('255.0.0.0','Keluarga Supir Proposional Seluruh Indoneisa (SPSI)'),
    ('260.0.0.0','ORGANISASI WANITA'),
    ('261.0.0.0','Dharma Wanita'),
    ('262.0.0.0','Persatuan Wanita Indonesia'),
    ('263.0.0.0','Pemberdayaan Perempuan (Wanita)'),
    ('264.0.0.0','Kongres Wanita'),
    ('270.0.0.0','PEMILIHAN UMUM'),
    ('271.0.0.0','Pencalonan'),
    ('272.0.0.0','Nomor Urut Partai / Tanda Gambar '),
    ('273.0.0.0','Kampanye'),
    ('274.0.0.0','Petugas Pemilu'),
    ('275.0.0.0','Pemilih / Daftar Pemilh'),
    ('276.0.0.0','Sarana'),
    ('276.1.0.0','TPS'),
    ('276.2.0.0','Kendaraan'),
    ('276.3.0.0','Surat Suara'),
    ('276.4.0.0','Kotak Suara'),
    ('276.5.0.0','Dana'),
    ('277.0.0.0','Pemungutan Suara / Penghitungan Suara'),
    ('278.0.0.0','Penetapan Hasil Pemilu'),
    ('279.0.0.0','Penetapan Perolehan Jumlah Kursi Dan Calon Terpilih'),
    ('280.0.0.0','Pengucapan Sumpah Janji MPR, DPR, DPD'),
    ('300.0.0.0','KEAMANAN / KETERTIBAN'),
    ('301.0.0.0','Keamanan'),
    ('302.0.0.0','Ketertiban'),
    ('310.0.0.0','PERTAHANAN'),
    ('311.0.0.0','Darat'),
    ('312.0.0.0','Laut'),
    ('313.0.0.0','Udara'),
    ('314.0.0.0','Perbatasan'),
    ('320.0.0.0','KEMILITERAN'),
    ('321.0.0.0','Latihan Militer'),
    ('322.0.0.0','Wajib Militer'),
    ('323.0.0.0','Operasi Militer'),
    ('324.0.0.0','Kekayaan TNI Pejabat Sipil dari TNI'),
    ('324.1.0.0','TMMD'),
    ('330.0.0.0','KEAMANAN'),
    ('331.0.0.0','Kepolisian'),
    ('331.1.0.0','Polisi Pamong Praja'),
    ('331.2.0.0','Kamra'),
    ('331.3.0.0','Kamling'),
    ('331.4.0.0','Jaga Wana'),
    ('332.0.0.0','Huru – hara / Demonstrasi'),
    ('333.0.0.0','Senjata Api / Tajam'),
    ('334.0.0.0','Bahan Peledak'),
    ('335.0.0.0','Surat- surat kaleng'),
    ('336.0.0.0','Perjudian'),
    ('337.0.0.0','Pengaduan'),
    ('338.0.0.0','Himbauan / Larangan'),
    ('339.0.0.0','Terroris'),
    ('340.0.0.0','PERTAHANAN SIPIL'),
    ('341.0.0.0','Perlindungan Sipil'),
    ('350.0.0.0','KEJAHATAN'),
    ('351.0.0.0','Makar / Pemberontakan'),
    ('352.0.0.0','Pembunuhan'),
    ('353.0.0.0','Penganiayaan, Pencurian'),
    ('354.0.0.0','Subversi / Penyelundupan / Narkotika'),
    ('355.0.0.0','Pemalsuan'),
    ('356.0.0.0','Korupsi / Penyelewengan / Penyalahgunaan / Penyalahgunaan Jabatan'),
    ('357.0.0.0','Perkosaan / Perbuatan Cabul'),
    ('358.0.0.0','Kenakalan'),
    ('359.0.0.0','Kejahatan Lainnya'),
    ('360.0.0.0','BENCANA'),
    ('361.0.0.0','Gunung Berapi / Gempa'),
    ('362.0.0.0','Banjir / Tanah Longsor'),
    ('363.0.0.0','Angin Topan'),
    ('364.0.0.0','Kebakaran'),
    ('364.1.0.0','Pemadam Kebakaran'),
    ('365.0.0.0','Kekeringan'),
    ('366.0.0.0','Tsunami'),
    ('370.0.0.0','KECELAKAAN / SAR'),
    ('371.0.0.0','Darat'),
    ('372.0.0.0','Udara'),
    ('373.0.0.0','Laut'),
    ('374.0.0.0','Sungai / Danau');