-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 16 Jul 2022 pada 12.50
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `klinik_312010205`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `berobat`
--

CREATE TABLE `berobat` (
  `id_berobat` int(11) NOT NULL,
  `id_pasien` int(5) DEFAULT NULL,
  `id_dokter` int(5) DEFAULT NULL,
  `tgl_berobat` date DEFAULT NULL,
  `keluhan_pasien` varchar(200) DEFAULT NULL,
  `hasil_diagnosa` varchar(200) DEFAULT NULL,
  `penatalaksanaan` enum('Rawat Jalan','Rawat Inap','Rujuk','isolasi','lainnya') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `berobat`
--

INSERT INTO `berobat` (`id_berobat`, `id_pasien`, `id_dokter`, `tgl_berobat`, `keluhan_pasien`, `hasil_diagnosa`, `penatalaksanaan`) VALUES
(141, 111, 121, '2022-01-12', 'Mual', 'Magh', 'Rawat Inap'),
(142, 112, 122, '2022-03-13', 'Saraf tegang', 'Jantung', 'Rawat Inap'),
(143, 113, 123, '2022-03-13', 'Sakit kepala', 'Migrain', 'Rawat Jalan'),
(144, 114, 124, '2022-03-19', 'Batuk pusing', 'Masuk angin', 'isolasi'),
(145, 115, 125, '2022-06-13', 'Batuk Pusing', 'Masuk angin', 'Rawat Jalan');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `berobat1`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `berobat1` (
`id_berobat` int(11)
,`id_dokter` int(5)
,`nama_pasien` varchar(40)
,`tgl_berobat` date
,`keluhan_pasien` varchar(200)
,`hasil_diagnosa` varchar(200)
,`penatalaksanaan` enum('Rawat Jalan','Rawat Inap','Rujuk','isolasi','lainnya')
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `berobat2`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `berobat2` (
`id_berobat` int(11)
,`nama_pasien` varchar(40)
,`nama_dokter` varchar(50)
,`tgl_berobat` date
,`keluhan_pasien` varchar(200)
,`hasil_diagnosa` varchar(200)
,`penatalaksanaan` enum('Rawat Jalan','Rawat Inap','Rujuk','isolasi','lainnya')
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` int(5) NOT NULL,
  `nama_dokter` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `dokter`
--

INSERT INTO `dokter` (`id_dokter`, `nama_dokter`) VALUES
(121, 'Ratna'),
(122, 'Dewi'),
(123, 'Haryanto'),
(124, 'Sudiro'),
(125, 'Dewi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_obat`
--

CREATE TABLE `log_obat` (
  `id_log` int(5) NOT NULL,
  `id_obat` int(5) NOT NULL,
  `obat_lama` varchar(64) NOT NULL,
  `obat_baru` varchar(64) NOT NULL,
  `waktu` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `log_obat`
--

INSERT INTO `log_obat` (`id_log`, `id_obat`, `obat_lama`, `obat_baru`, `waktu`) VALUES
(1, 135, 'Komik', 'Parachetamol', '2022-07-13'),
(2, 135, 'Parachetamol', 'Komik', '2022-07-16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id_obat` int(5) NOT NULL,
  `nama_obat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `obat`
--

INSERT INTO `obat` (`id_obat`, `nama_obat`) VALUES
(131, 'Mixagrib'),
(132, 'Parachetamol'),
(133, 'Insana'),
(134, 'Ambroxol'),
(135, 'Komik');

--
-- Trigger `obat`
--
DELIMITER $$
CREATE TRIGGER `update_obat` AFTER UPDATE ON `obat` FOR EACH ROW INSERT INTO log_obat
SET id_obat=OLD.id_obat,
obat_lama=old.nama_obat,
obat_baru=new.nama_obat,
waktu = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasien`
--

CREATE TABLE `pasien` (
  `id_pasien` int(5) NOT NULL,
  `nama_pasien` varchar(40) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `umur` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pasien`
--

INSERT INTO `pasien` (`id_pasien`, `nama_pasien`, `jenis_kelamin`, `umur`) VALUES
(111, 'Ratna', 'P', 20),
(112, 'Nani', 'L', 25),
(113, 'Rivan', 'L', 24),
(114, 'Ani', 'P', 22),
(115, 'Zaki', 'L', 19),
(116, 'Nani', 'P', 22);

-- --------------------------------------------------------

--
-- Struktur dari tabel `resep_obat`
--

CREATE TABLE `resep_obat` (
  `id_resep` int(11) NOT NULL,
  `id_berobat` int(11) DEFAULT NULL,
  `id_obat` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `resep_obat`
--

INSERT INTO `resep_obat` (`id_resep`, `id_berobat`, `id_obat`) VALUES
(151, 141, 131),
(152, 142, 132),
(153, 143, 133),
(154, 144, 134),
(155, 145, 135);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(5) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `nama_lengkap` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `nama_lengkap`) VALUES
(557, 'Irfanda', 'e80a0819f2594a3660b470030372672c', 'Irfanda Nur Arifin'),
(558, 'admin2', '827ccb0eea8a706c4c34a16891f84e7b', 'Nanda Amar'),
(559, 'admin3', '827ccb0eea8a706c4c34a16891f84e7b', 'Reza Handika'),
(560, 'admin4', '827ccb0eea8a706c4c34a16891f84e7b', 'Amarullah');

-- --------------------------------------------------------

--
-- Struktur untuk view `berobat1`
--
DROP TABLE IF EXISTS `berobat1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `berobat1`  AS SELECT `berobat`.`id_berobat` AS `id_berobat`, `berobat`.`id_dokter` AS `id_dokter`, `pasien`.`nama_pasien` AS `nama_pasien`, `berobat`.`tgl_berobat` AS `tgl_berobat`, `berobat`.`keluhan_pasien` AS `keluhan_pasien`, `berobat`.`hasil_diagnosa` AS `hasil_diagnosa`, `berobat`.`penatalaksanaan` AS `penatalaksanaan` FROM (`berobat` join `pasien` on(`berobat`.`id_pasien` = `pasien`.`id_pasien`))  ;

-- --------------------------------------------------------

--
-- Struktur untuk view `berobat2`
--
DROP TABLE IF EXISTS `berobat2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `berobat2`  AS SELECT `berobat1`.`id_berobat` AS `id_berobat`, `berobat1`.`nama_pasien` AS `nama_pasien`, `dokter`.`nama_dokter` AS `nama_dokter`, `berobat1`.`tgl_berobat` AS `tgl_berobat`, `berobat1`.`keluhan_pasien` AS `keluhan_pasien`, `berobat1`.`hasil_diagnosa` AS `hasil_diagnosa`, `berobat1`.`penatalaksanaan` AS `penatalaksanaan` FROM (`berobat1` join `dokter` on(`berobat1`.`id_dokter` = `dokter`.`id_dokter`))  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `berobat`
--
ALTER TABLE `berobat`
  ADD PRIMARY KEY (`id_berobat`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Indeks untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`);

--
-- Indeks untuk tabel `log_obat`
--
ALTER TABLE `log_obat`
  ADD PRIMARY KEY (`id_log`);

--
-- Indeks untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`);

--
-- Indeks untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id_pasien`);

--
-- Indeks untuk tabel `resep_obat`
--
ALTER TABLE `resep_obat`
  ADD PRIMARY KEY (`id_resep`),
  ADD KEY `id_berobat` (`id_berobat`),
  ADD KEY `id_obat` (`id_obat`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `berobat`
--
ALTER TABLE `berobat`
  MODIFY `id_berobat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=336;

--
-- AUTO_INCREMENT untuk tabel `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_dokter` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT untuk tabel `log_obat`
--
ALTER TABLE `log_obat`
  MODIFY `id_log` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `obat`
--
ALTER TABLE `obat`
  MODIFY `id_obat` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226;

--
-- AUTO_INCREMENT untuk tabel `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id_pasien` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT untuk tabel `resep_obat`
--
ALTER TABLE `resep_obat`
  MODIFY `id_resep` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=446;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=561;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `berobat`
--
ALTER TABLE `berobat`
  ADD CONSTRAINT `id_dokter` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`),
  ADD CONSTRAINT `id_pasien` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`);

--
-- Ketidakleluasaan untuk tabel `resep_obat`
--
ALTER TABLE `resep_obat`
  ADD CONSTRAINT `id_berobat` FOREIGN KEY (`id_berobat`) REFERENCES `berobat` (`id_berobat`),
  ADD CONSTRAINT `id_obat` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
