-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 26, 2024 at 06:37 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kinarasdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_all_product` ()   BEGIN
	SELECT p.product_id, p.product_img, p.product_name, p.brand, c.cat_name, p.price, p.product_desc
	FROM product p
	LEFT JOIN categories c ON p.cat_id = c.cat_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_product_cart` (IN `id` VARCHAR(5))   BEGIN
    SELECT 
        p.product_name, 
        p.brand, 
        p.price, 
        p.product_img, 
        b.bag_id, 
        p.product_id, 
        c.cat_name
    FROM 
        bag b
    JOIN 
        product p USING (product_id)
    JOIN 
        user u USING (user_id)
    JOIN 
        categories c ON p.cat_id = c.cat_id
    WHERE 
        b.user_id = id AND b.status='Unpaid';
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `count_cart` (`uid` VARCHAR(5)) RETURNS INT(11)  BEGIN
    DECLARE count INT;

    SELECT COUNT(bag_id) INTO count
    FROM bag
    WHERE user_id = uid AND status='Unpaid';

    RETURN count;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `count_products` () RETURNS INT(11)  BEGIN
	DECLARE jmlh INT;
	SELECT COUNT(product_id) INTO jmlh FROM product;
	RETURN jmlh;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `count_total_cart` (`user_id` VARCHAR(5)) RETURNS INT(11)  BEGIN
    DECLARE total INT DEFAULT 0;
    
    -- Menghitung total harga dari produk dalam keranjang berdasarkan user_id
    SELECT IFNULL(SUM(p.price), 0)
    INTO total
    FROM bag
    JOIN product p USING(product_id)
    WHERE bag.user_id = user_id AND bag.status='Unpaid';
    
    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_quantity` (`uid` VARCHAR(5), `pid` VARCHAR(5)) RETURNS INT(11)  BEGIN
    DECLARE qty INT;

    SELECT COUNT(bag_id)
    INTO qty
    FROM bag
    WHERE user_id = uid AND product_id = pid;

    RETURN qty;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` varchar(5) NOT NULL COMMENT 'unique code for each admin as identity',
  `admin_name` varchar(255) NOT NULL COMMENT 'admin full name',
  `admin_nickname` varchar(20) NOT NULL,
  `admin_pass` varchar(16) NOT NULL COMMENT 'admin pass key for login',
  `admin_img` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_name`, `admin_nickname`, `admin_pass`, `admin_img`) VALUES
('AD001', 'Eunique Lydia Stephany', 'Puni', 'puni000', 'upload/admin/uni.png'),
('AD002', 'Zefantio', 'Zefan', 'zefan000', 'upload/admin/fan.png'),
('AD003', 'Bima Pratama', 'Bima', 'bima000', 'upload/admin/bim.png'),
('AD004', 'Guruh Jodi Saputra', 'Jodi', 'jodi000', 'upload/admin/jo.png'),
('AD005', 'Zahran Nugraha', 'Zhaho', 'zahh000', 'upload/admin/zah.png');

--
-- Triggers `admin`
--
DELIMITER $$
CREATE TRIGGER `id_for_admin` BEFORE INSERT ON `admin` FOR EACH ROW BEGIN
    DECLARE new_id VARCHAR(5);
    DECLARE prefix VARCHAR(2) DEFAULT 'AD';
    DECLARE number_part INT;

    -- Mengambil nilai ID terakhir dan memisahkan bagian angka
    SELECT IFNULL(MAX(CAST(SUBSTRING(admin_id, 3, 3) AS UNSIGNED)), 0) + 1 INTO number_part
    FROM admin
    WHERE admin_id LIKE CONCAT(prefix, '%');

    -- Membuat ID baru
    SET new_id = CONCAT(prefix, LPAD(number_part, 3, '0'));

    -- Mengatur nilai admin_id baru
    SET NEW.admin_id = new_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bag`
--

CREATE TABLE `bag` (
  `bag_id` varchar(5) NOT NULL,
  `user_id` varchar(5) NOT NULL,
  `product_id` varchar(5) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'Unpaid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bag`
--

INSERT INTO `bag` (`bag_id`, `user_id`, `product_id`, `status`) VALUES
('BG016', 'UR004', 'PR006', 'Unpaid'),
('BG018', 'UR005', 'PR001', 'Unpaid'),
('BG019', 'UR005', 'PR005', 'Unpaid'),
('BG020', 'UR002', 'PR003', 'Unpaid'),
('BG021', 'UR002', 'PR090', 'Unpaid'),
('BG022', 'UR002', 'PR175', 'Unpaid');

--
-- Triggers `bag`
--
DELIMITER $$
CREATE TRIGGER `id_for_bag` BEFORE INSERT ON `bag` FOR EACH ROW BEGIN
    DECLARE new_id VARCHAR(5);
    DECLARE prefix VARCHAR(2) DEFAULT 'BG';
    DECLARE number_part INT;

    -- Mengambil nilai ID terakhir dan memisahkan bagian angka
    SELECT IFNULL(MAX(CAST(SUBSTRING(bag_id, 3, 3) AS UNSIGNED)), 0) + 1 INTO number_part
    FROM bag
    WHERE bag_id LIKE CONCAT(prefix, '%');

    -- Membuat ID baru
    SET new_id = CONCAT(prefix, LPAD(number_part, 3, '0'));

    -- Mengatur nilai ID baru
    SET NEW.bag_id = new_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cat_id` varchar(5) NOT NULL,
  `cat_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_name`, `description`) VALUES
('CT001', 'MAKEUP', 'beauty products that are purposed to increase your appearance instantly'),
('CT002', 'SKINCARE', 'beauty products to maintain and increase your beauty and healthy skin'),
('CT003', 'HAIRCARE', 'Beauty products for your hair'),
('CT004', 'BATH & BODY', 'Product for a better shower experience and taking care of your body\'s skin'),
('CT005', 'FRAGRANCE', 'leave a memorable smell and increase your mood of the day'),
('CT006', 'SANITARY', 'Taking care of your mouth, tongue, and teeth'),
('CT007', 'NAILSCARE', 'Beauty isn\'t beauty without cleanness'),
('CT008', 'ORALCARE', 'keep an eye on every detail of your body'),
('CT009', 'SHAVE & GROOM', 'smooth, soothe, and confidence'),
('CT010', 'GIFTSET', 'Other beauty products that you might need'),
('CT011', 'OTHER', 'ETC PRODUCT CAT');

--
-- Triggers `categories`
--
DELIMITER $$
CREATE TRIGGER `id_for_categories` BEFORE INSERT ON `categories` FOR EACH ROW BEGIN
    DECLARE new_id VARCHAR(5);
    DECLARE prefix VARCHAR(2) DEFAULT 'CT';
    DECLARE number_part INT;

    -- Mengambil nilai ID terakhir dan memisahkan bagian angka
    SELECT IFNULL(MAX(CAST(SUBSTRING(cat_id, 3, 3) AS UNSIGNED)), 0) + 1 INTO number_part
    FROM categories
    WHERE cat_id LIKE CONCAT(prefix, '%');

    -- Membuat ID baru
    SET new_id = CONCAT(prefix, LPAD(number_part, 3, '0'));

    -- Mengatur nilai cat_id baru
    SET NEW.cat_id = new_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` varchar(5) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `brand` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `cat_id` varchar(255) DEFAULT NULL,
  `product_img` varchar(100) DEFAULT NULL,
  `product_desc` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `brand`, `price`, `cat_id`, `product_img`, `product_desc`) VALUES
('PR001', 'Orange Flower Shining Color Shampoo', 'Dancoly', 159000.00, 'CT003', 'upload/product/dancoly-shampoo-large.jpg', 'Shampoo ini dirancang secara professional untuk rambut yang diwarnai agar menjaga warna rambut dan mencegah warna rambut cepat memudar. Selain itu, khasiat yang terdapat di shampoo ini juga dapat melindungi rambut dari kerusakan yang diakibatkan oleh sinar matahari dan rambut akan tampak lebih bercahaya setelahnya.'),
('PR002', 'Argan Repair Shampoo', 'Dancoly', 219000.00, 'CT003', 'upload/product/19188-large_default.jpg', '(300ML) Dancoly argan series adalah seri premium dari Dancoly yang menggunakan bahan argan oil yang diproduksi dari buah pohon argan yang berada dinpuncak tertinggi gunung atlas.\r\n\r\nShampoo ini mengandung ekstrak vitamin E, pelembab dan nutrisi khusus yang dapat menciptakan pelindung di permukaan rambut. Shampoo ini sangat cocok untuk rambut yang rusak, kering dan bercabang akibat seringnya terkena proses kimia (perm, bonding, bleach, etc).'),
('PR003', 'Conditioner Hair Fall', 'Wardah', 27000.00, 'CT003', 'upload/product/19027-large_default.jpg', 'Conditioner Hair Fall, untuk mencegah rambur rontok berkelanjutan.\r\n\r\nWardah Hairfall Treatment Conditioner mengandung bahan aktif natural yang bekerja multiaksi. Kombinasi Ginseng Extract, Rosemary Extract, dan Keratin bantu menutrisi untuk menjaga kekuatan dan memberikan perlindungan pada setiap helai rambut, sehingga rambut rontok karena patah berkurang. Menjaga kelembaban alami untuk menghindari rambut kering dan hasil akhir rambut yang terasa lembut, halus, ringan, dan tidak mudah lepek.'),
('PR004', 'Extraordinary Oil Pink Hair Serum', 'LOreal Paris', 120000.00, 'CT003', 'upload/product/16656-large_default.jpg', 'Extraordinary Oil dari LOreal Paris adalah serum perawatan rambut intensif. Rambut akan secara intensif ternutrisi, dan terlindungi, dan memberikan hasil rambut yang halus, lembut, tampak berkilau, tanpa memberikan hasil akhir yang lepek secara seketika.'),
('PR005', 'Organic Hair Growth Treatment Shampoo', 'Eucalie', 99000.00, 'CT003', 'upload/product/34762-large_default.jpg', 'Shampoo Organik yang lembut (Sulfate - Free) dengan Ph-balanced dan diformulasikan dengan bahan-bahan premium dari Organik Baobab Peptides, Sphingony, Rosemary, & Essential Oil untuk :\r\n• Merevitalisasi rambut\r\n• Menghaluskan rambut\r\n• Membantu mengurangi kerontokan rambut\r\n• Menutrisi rambut\r\n• Memperkuat akar rambut\r\n• Menjaga kesehatan rambut dan kulit kepala\r\n• Mengurangi gatal-gatal di kulit kepala\r\n\r\n• Cocok untuk semua jenis rambut\r\n• Ph-balanced\r\n• ECOCERT ORGANIC Approved Ingredients (Rosemary & Peppermint Oil)\r\n• Aroma : Rosemary mint\r\n\r\n\r\n• HALAL, BPOM Registered, Pregnancy Safe, Breastfeed Safe, Kids Safe, For Sensitive Skin, Hypoaller..'),
('PR006', 'Real Shea Protein Recharging Leave-in Treatment', 'Rated Green', 211000.00, 'CT003', 'upload/product/35057-large_default.jpg', 'Dengan formula khusus yang terbuat dari Shea butter organik cold pressed, oat protein dan kolagen, leave-in treatment intensif ini membantu menghaluskan dan melindungi rambut kusut serta rusak setelah pemakaian.\r\n\r\nPERAWATAN KERUSAKAN INTENSIF. Diperkaya dengan campuran kaya protein dari Shea Butter organik, Oat Protein, dan Kolagen yang digabungkan dengan cepat melembutkan dan melindungi rambut kering, keriting, dan rusak untuk memberikan hasil yang terlihat hanya dengan satu kali pemakaian.\r\n\r\nMENDAPATKAN PERAWATAN RAMBUT BERKUALITAS SALON. Dapatkan perawatan rambut berkualitas salon dengan mudah menggunakan perawatan cuci rambut ini. Hanya dalam tiga langkah sederhana—aplikasikan pada rambut basah, keringkan, dan gunakan alat pengeriting rambut atau catokan—Anda dapat mengubah rambut Anda menjadi tampilan bergaya profesional.'),
('PR007', 'Hair Energy Scentsations Hair Fragrance', 'Makarizo', 32000.00, 'CT003', 'upload/product/image-4-1598240211943.png', 'Rambut suka bau dan lepek sehabis makan sate di pinggir jalan? Terpapar matahari karena kerja lapangan seharian? Atau sehabis pakai helm dan terpapar asap kendaraan waktu berangkat kerja? Makarizo Hair Energy SCENTSATIONS hadir menjadi solusi untuk kamu yang ingin rambut TETAP WANGI dan BERKILAU! Dengan teknologi SCENTECH-F yang mampu MENETRALISIR BAU TIDAK SEDAP serta dilengkapi dengan VITAMIN dan UV-PROTECTION!'),
('PR008', 'Hair Energy Fibertherapy Hair & Scalp Creambath Aloe & Melon', 'Makarizo', 100000.00, 'CT003', 'upload/product/image-0-1598239769863.png', 'Rambut suka rontok parah? Makarizo Hair Energy Fibertherapy Hair & Scalp Creambath hadir dengan kombinasi Melon dengan kandungan Vitamin B, Aloe (Lidah Buaya) dan Omega 6 dari Minyak Nabati Passiflora yang dapat membantu MENGURANGI KERONTOKAN RAMBUT dan MEMPERKUAT AKAR RAMBUTMU! Diperkuat dengan adanya Asam Amino Keratin yang merupakan unsur vital dalam pembentukan keratin sebagai protein utama sehingga mendorong keterpaduan struktur rambut menjadi LEBIH BERKILAU, TETAP SEHAT, dan KUAT! Kamu bakal suka banget karena… #WanginyaEnakParah #GampangDipake #AffordableForAll #NaturalEkstrak Solusi tepat untuk kamu yang ingin memanjakan rambut, dan memperbaiki dari pusat akar sehingga batang rambut pun tampak hidup dan sehat kembali.'),
('PR009', 'Real Tamanu Cold Pressed Tamanu Oil Soothing Scalp Shampoo', 'Rated Green', 202000.00, 'CT003', 'upload/product/tamanu_138717.png', 'Sampo dengan kandungan 94% bahan alami yang membersihkan rambut dan kulit kepala dengan lembut.\r\n\r\nDiformulasikan dengan cold-pressed tamanu oil organik bersertifikasi ECOCERT dan witch hazel, dapat membantu menenangkan kulit kepala yang rentan kemerahan serta gatal.\r\n\r\nDiekstraksi dengan metode Cold-Press (tanpa panas) untuk memastikan tidak ada nutrisi yang terbuang selama proses, untuk memastikan seluruh nutrisinya diserap kulit kepala dan rambut. Dengan aroma lemon yang segar dan manis.'),
('PR010', 'Hair Energy Fibertherapy Conditioning Shampoo Aloe & Melon Bottle', 'Makarizo', 52000.00, 'CT003', 'upload/product/makarizo-187381.png', 'Rambut suka rontok parah? Makarizo Hair Energy Fibertherapy Conditioning Shampoo hadir dengan kombinasi Omega 6 dari Minyak Nabati Passiflora dan kandungan Vitamin B, Aloe (Lidah Buaya) dan Omega 6 dari Minyak Nabati Passiflora yang dapat membantu MENGURANGI KERONTOKAN RAMBUT dan MEMPERKUAT AKAR RAMBUTMU!\r\n\r\nDiperkuat dengan adanya Asam Amino Keratin yang merupakan unsur vital dalam pembentukan keratin sebagai protein utama sehingga mendorong keterpaduan struktur rambut menjadi LEBIH BERKILAU, TETAP SEHAT, dan KUAT! Kamu bakal suka banget karena… #WanginyaEnakParah #GampangDipake #AffordableForAll #NaturalEkstrak Solusi untuk membersihkan rambut dari residu produk perawatan rambut serta melembabkan hingga rambut mudah diatur!'),
('PR011', 'Salon Daily Professional Conditioner', 'Makarizo Professional', 155000.00, 'CT003', 'upload/product/makarizo-85371819.jpg', 'Diformulasikan khusus untuk penggunaan salon profesional. Mengandung minyak mineral untuk membantu menutrisi, melembutkan, dan merevitalisasi rambut. Memiliki kandungan deep conditioning agent yang dapat merevitalisasi semua jenis rambut bahkan yang rusak sekalipun. Wanginya yang ringan menjadikan rambut terasa segar sepanjang hari'),
('PR012', 'Vitamin Rambut Hair Treatment Jar New', 'Ellips', 109000.00, 'CT003', 'upload/product/ellip833e0-.png', 'Vitamin rambut yang diperkaya dengan Moroccan Oil, Jojoba Oil, Vitamin A,C,E , Pro Vit B-5 yang dapat merawat, menutrisi dan melindungi rambut yang rusak, kering dan bercabang akibat proses kimiawi (pengeritingan atau pelurusan rambut). Rambut menjadi tampak lebih sehat, lembut dan lebih mudah diatur. Tersedia dalam kemasan blister dan jar'),
('PR013', 'Hair Vitamin Moroccan Oil Smooth & Shiny Blister', 'Ellips', 17000.00, 'CT003', 'upload/product/elip263572.jpg', 'Vitamin rambut yang diperkaya dengan Moroccan Oil, Aloe Vera Oil, Vitamin A,C,E, Pro Vit B-5 yang dapat merawat rambut hingga terasa lebih lembut, menutrisi dan menjaga kelembaban rambut tanpa membuatnya jadi berminyak. Rambut semakin sehat, lembut dan bercahaya. Tersedia dalam kemasan blister dan jar.'),
('PR014', 'Lador Triplex 3 Natural Shampoo', 'La\'dor', 110000.00, 'CT003', 'upload/product/lalaldor28a.png', 'Shampoo ini mengandung bahan yang bagus dan menyehatkan untuk kulit kepala seperti blackcurrant , green tea callus , lavender oil , tea tree lead oil, turmeric extract, lemon oil,etc dan bahan2 berkualitas inilah yang membuat sampo ini dinamakan tripleX 3 . Pilihan yang tepat untuk kulit kepala kering dan sensitif\r\n\r\nHow To Use: Aplikasikan ke rambut lalu dibilas'),
('PR015', 'SOS Hair Powder', 'Dazzle Me', 38000.00, 'CT003', 'upload/product/dazzle_728292.jpg', 'Hair Powder to get rid of oily hair, instant soft fluffy and fragrant hair!\r\n\r\n- QUICK LEAVE-IN FORMULA\r\nLight powder, volumizes hair, easy to carry around, sponge-tip puff, easy to use anytime, no-wash formula, finished with soft fluffy hair.\r\n\r\n- BYE OILY HAIR\r\nMixture of Hollow Silica Powder and modified Corn Starch. The powder quickly blends with the oily scalp and becomes transparent, no white residue. Leaving your hair fresh with light fragrance.\r\n\r\n- NATURAL & SAFE\r\nNatural ingredients from plants, do not block pores, do not cause scalp sensitivity. Safe and gentle to use.\r\n\r\nMain Ingredients：Ceramide, Camellia Extract , Portulaca Oleracea Extract , Modified Corn Starch, Hollow Silica Powder\r\nNo Harm Claim 0% Alcohol, 0% Mineral Oil.'),
('PR016', 'Creamy Bubble Color Rose Tea', 'Liese', 144000.00, 'CT003', 'upload/product/lse_284982_haircolor_08.jpg', 'Liese Creamy Bubble Hair Color merupakan pewarna rambut bertekstur busa yang memungkinkan pewarnaan rambut secara mudah dan merata dengan formula busa yang tidak menetes, menjangkau area yang paling sulit dijangkau seperti akar dan bagian belakang kepala.\r\n\r\nRangkaian lengkapnya terinspirasi oleh tren warna rambut salon, dirancang dengan dasar warna abu-abu dan kebiruan untuk mengurangi warna kuningan yang tidak diinginkan, dan menghasilkan hasil akhir yang tipis dan lembut. Memberikan hasil warna yang luar biasa dari akar hingga ujung rambut, dan menghasilkan hasil akhir yang lembut dan halus dengan bahan pelindung rambut dan paket perawatan bilas.'),
('PR017', 'Creamy Bubble Color Dark Chocolate', 'Liese', 144000.00, 'CT003', 'upload/product/83938_liese.jpg', 'Liese Creamy Bubble Hair Color merupakan pewarna rambut bertekstur busa yang memungkinkan pewarnaan rambut secara mudah dan merata dengan formula busa yang tidak menetes, menjangkau area yang paling sulit dijangkau seperti akar dan bagian belakang kepala.\r\n\r\nRangkaian lengkapnya terinspirasi oleh tren warna rambut salon, dirancang dengan dasar warna abu-abu dan kebiruan untuk mengurangi warna kuningan yang tidak diinginkan, dan menghasilkan hasil akhir yang tipis dan lembut. Memberikan hasil warna yang luar biasa dari akar hingga ujung rambut, dan menghasilkan hasil akhir yang lembut dan halus dengan bahan pelindung rambut dan paket perawatan bilas.'),
('PR018', 'Creamy Bubble Color Chestnut Brown', 'Liese', 144000.00, 'CT003', 'upload/product/lse_bubble_haircolor_06.jpg', 'Liese Creamy Bubble Color Berry Pink (Pewarna Rambut Busa DIY dengan Warna Terinspirasi Salon + Termasuk Paket Perawatan) 108ml\r\n\r\nLiese Creamy Bubble Hair Color merupakan pewarna rambut bertekstur busa yang memungkinkan pewarnaan rambut secara mudah dan merata dengan formula busa yang tidak menetes, menjangkau area yang paling sulit dijangkau seperti akar dan bagian belakang kepala.'),
('PR019', 'Hyaluron Serum Shampoo Purifying & Hydrating', 'Dove', 72000.00, 'CT003', 'upload/product/Dove_drating_2882_450ml.png', 'Memperkenalkan Shampoo pertama untuk perawatan rambut yang mengandung serum Hyaluron - Advanced Skin Care Ingredient yang memberikanmu Advanced Damage Care untuk rambut lembut, sehat ternutrisi. Hyaluron yang merupakan kandungan penting dalam perawatan wajah berfungsi untuk memberikan dan mempertahankan kelembapan pada rambut.'),
('PR020', 'Deep Perfume Shampoo Baby Powder', 'Bouquet Garni Nard', 280000.00, 'CT003', 'upload/product/garniaa3-.png', 'Shampo dengan aroma baby powder yang tahan lama untuk memberikan kelembapan serta perawatan ekstra pada batang rambut. Shampo ini dapat meningkatkan elastisitas rambut, menjadikan rambut terlihat lebih halus dan berkilau.\r\n\r\n-Ekstrak Shikakai: Membersihkan kulit kepala dan batang rambut secara lembut\r\n\r\n-11 Jenis Asam Amino: Merevitalisasi kulit kepala\r\n\r\n-Protein Terhidrolisasi: Memberikan nutrisi dan vitalitas pada batang rambut'),
('PR021', 'Sampo Zaitun', 'Herborist', 26000.00, 'CT003', 'upload/product/35373-large_default.jpg', 'Sampo Zaitun sangat bermanfaat sebagai moisturizer alami bagi kulit kepala dan rambut. Menjadikan rambut lebih lembap, terlihat hitam berkilau dan sehat.\r\n\r\nSampo Zaitun juga bermanfaat untuk menutrisi lapisan kutikula rambut, menghilangkan ketombe, menambah volume rambut, mengurangi rambut rontok dan bercabang, membantu pertumbuhan rambut serta membuat terlihat lebih halus dan lembut.'),
('PR022', 'Total Damage Care Shampoo (450ml)', 'Pantene', 118000.00, 'CT003', 'upload/product/large-9691692846.png', 'Pantene Total Damage Care Shampoo:\r\n\r\nPro-V formula dengan Penangkal Kerusakan Keratin (mengacu pada bahan Trisodium Ethylenediamine Disuccinate)\r\n\r\nMeningkatkan kemampuan alami rambut untuk menjaga ikatan protein untuk mengatasi kerusakan rambut\r\n\r\nMembantu mencegah rambut bercabang di kemudian hari bahkan dalam 3 bulan (dengan pemakaian teratur)\r\n\r\nPerlindungan hingga 10x dari kerusakan (sistem pantene vs Shampoo non-Conditioner)\r\n\r\nMembantu terhindar dari 10 tanda kerusakan (10 tanda kerusakan adalah kusut, kusam, rapuh, bercabang, kerontokan karena rambut patah, kering, kasar, lemah, mengembang dan susah diatur)'),
('PR023', 'Pomelo Hair Tonic', 'Cocoon', 135000.00, 'CT003', 'upload/product/28d04481-69b8.png', 'Diformulasikan dengan Pomelo essential oil dari Vietnam, vitamin B5 dan Xylishine™ untuk membantu mengurangi rambut patah, melembapkan batang rambut, untuk rambut yang lembut dan kuat. Membantu menjaga kesehatan, menguatkan dan membantu merawat kesuburan rambut secara jangka panjang. Cocok untuk rambut yang mudah patah, rontok dan tipis. Dengan aroma alami yang segar dari Pomelo.'),
('PR024', 'Hair We Bloom Conditioner', 'Lavojoy', 69000.00, 'CT003', 'upload/product/292929_Hair_We.jpg', 'Kondisioner membantu menjaga kesegaran rambut dan meminimalisir minyak berlebih sepanjang hari.\r\n\r\nManfaat:\r\n1. Oil-Control\r\nDiperkaya dengan Zinc PCA, dan Tea Tree Oil untuk mengurangi minyak berlebih dan menjaga kesegaran rambut\r\n2. Nourishing\r\nDiperkaya dengan Camellia Seed Oil, Argan Oil, Squalane, dan Vitamin B5 untuk menutrisi rambut secara mendalam untuk hasil rambut yang halus dan bebas kusut.\r\n3. Fresh Fragrance\r\nKombinasi floral dan musk menciptakan aroma yang unik dan segar.\r\n\r\nHow To Use / Cara Pakai:\r\nTuangkan kondisioner dalam jumlah yang sesuai ke telapak tangan, lalu aplikasikan merata dari tengah hingga ujung rambut. Biarkan selama beberapa menit, bilas hingga bersih dengan air.'),
('PR025', 'Sundae Shower Hair Perfume - Ribbon Palace', 'Sundae Shower', 85000.00, 'CT003', 'upload/product/a4b2-0e0459409424-image.png', 'Tidak hanya sebagai penyegar dan pewangi untuk rambutmu, Sundae Hair Perfume juga merawat dan menjaga tekstur rambut agar tetap bercahaya, halus dan terlindung dari panas. Wangi tahan sampai 10 jam di dalam ruangan.\r\nRibbon Palace. Wangi elegan yang manis dan segar dengan sentuhkan dark cherry yang feminine.\r\nNote: Cherry, Violet, Amber.'),
('PR026', 'Delicate Embrace', 'Carl & Claire', 279000.00, 'CT005', 'upload/product/f913cebf_rimgd.png', '“𝙉𝙤𝙩𝙝𝙞𝙣𝙜 𝙘𝙖𝙡𝙢𝙨 𝙢𝙮 𝙝𝙚𝙖𝙧𝙩 𝙢𝙤𝙧𝙚 𝙩𝙝𝙖𝙣 𝙮𝙤𝙪𝙧 𝙙𝙚𝙡𝙞𝙘𝙖𝙩𝙚 𝙚𝙢𝙗𝙧𝙖𝙘𝙚.”\r\n\r\nSensual like the inside of a flower, Delicate Embrace opens with the alluring scents of Freesia, Citrus, and Pear. Like the familiar embrace that gently arouses you from sleep, notes of Lily of the Valley, Rose, and Musk illustrate warmth and intimacy.\r\n\r\n𝗦𝘂𝗶𝘁𝗮𝗯𝗹𝗲 𝗙𝗼𝗿\r\nAktivitas sehari-hari untuk perempuan dengan karakter feminine dan menyukai look yang elegan.'),
('PR027', 'Sunny Side Up', 'Itsy Nail', 45000.00, 'CT007', 'upload/product/nail1.jpg', ''),
('PR028', 'Piece Matching Nails Lacquer', 'Holika Holika', 55000.00, 'CT007', 'upload/product/nail2.png', 'Cat kuku yang sangat berpigmen dan tahan lama yang hadir dalam berbagai warna dan sentuhan akhir sesuai dengan kebutuhan Anda. Sikat dirancang secara ergonomis untuk bekerja dengan bentuk kuku dan juga lebar dan rata untuk meminimalkan jumlah goresan yang dibutuhkan.\r\n\r\nKeunggulan:\r\n1. Tahan lama\r\nLebih tahan dan merata dengan warna yang lebih terang dan glossy.\r\n2. Cepat Kering\r\nCepat kering membuat penggunaan pewarna kuku lebih mudah\r\n3. Variasi warna untuk berbagai skin tone kulit\r\nWarna yang trendi yang tampak cantik untuk tone warm dan cool untuk membuat berbagai gaya kuku.'),
('PR029', 'Magic Tool Nail Edge Buffer', 'Holika Holika', 20000.00, 'CT007', 'upload/product/nail3.png', 'Peralatan perawatan kuku yang digunakan untuk menggosok kuku. Digunakan untuk memperhalus bentuk kuku yang tidak rata setelah proses pengguntingan. Terdiri atas 2 sisi bagian kasar dan halus'),
('PR030', 'Magic Tool Nail Nippers', 'Holika Holika', 148000.00, 'CT007', 'upload/product/nail4.png', 'Alat pemotong dengan mata pisau yang tajam. Berfungsi untuk merapikan sisa-sisa kuku hingga ke sudut yang sulit dijangkau.'),
('PR031', 'Spot-On Manicure Graceful Mahogany', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail5.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR032', 'Spot-On Manicure Worthy in Beige', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail6.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR033', 'Spot-On Manicure Passionate Mint', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail7.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR034', 'Spot-On Manicure Grateful in Chocolate', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail8.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR035', 'Spot-On Manicure Madly Tenacious', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail9.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR036', 'Spot-On Manicure Calm in Navy Blue', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail10.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR037', 'Spot-On Manicure Honesty in Lime', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail11.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR038', 'Spot-On Manicure Imperfection', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail12.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR039', 'Spot-On Manicure Sweet Hustler', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail13.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR040', 'Spot-On Manicure Exceptionally Resilient', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail14.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR041', 'Spot-On Manicure Insanely Confident', 'Eze Nails', 99990.00, 'CT007', 'upload/product/nail16.png', 'Spot-On Manicure adalah kuku siap tempel dengan hasil seperti kuteks gel salon yang sangat mudah digunakan hanya dalam 10 menit saja dimanapun dan kapanpun! Dalam 1 box kuku terdapat 24-30 kuku pre-glued dalam 12 macam size sehingga pasti akan muat untuk ukuran kuku siapapun, juga dilengkapi dengan cuticle stick, alchohol pad, dan instruksi pemakaian lengkapnya. Rasakan inovasi kenyamanan dan keringanan kualitas premium kuku Eze Nails, yang tahan dalam 5-7 hari pemakaian.'),
('PR042', 'Vitamin Kuku | Booster Keratin+Calcium | Nail Vitamin | Cuticle Oil/Minyak Kuku', 'Tone', 17000.00, 'CT007', 'upload/product/nail17.png', 'Tone Vitamin Booster Keratin + Calcium dapat membantu menguatkan dan menumbuhkan kuku secara sehat dan alami. Kandungan kalsium merupakan salah satu mineral yang penting untuk kesehatan kuku agar lebih sehat, tidak mudah patah, kering atau rusak. Kandungan lain seperti keratin alami dan aloe vera, dapat mengembalikan kekuatan kuku serta membuatnya menjadi lebih lembap.\r\n\r\nJika digunakan teratur, vitamin oil ini dapat membantu melembutkan kutikula.'),
('PR043', 'Nail Polish Remover/ Penghapus Cat Kuku', 'Tone', 12900.00, 'CT007', 'upload/product/nail18.png', 'Tone Nail Polish Remover (Penghapus Cat Kuku)\r\nAman bagi kuku dan terdapat vitamin E. Tersedia 2 varian nail polish remover:\r\n\r\n- Acetone\r\n- Non Acetone\r\n\r\nKekuatan menghapus cat kuku sangat baik. Perbedaan antara \"Aceton\" dan \"Non Aceton\" adalah dari bahan yang digunakan. Keunggulan lain dari NPR Non Acetone adalah bisa digunakan untuk mengencerkan kutek yang sudah lama dan mengental.'),
('PR044', 'Kikir Kuku Glass', 'Tone', 17000.00, 'CT007', 'upload/product/nail19.png', 'Kikir Pengkilap Kuku\r\n\r\nKikir Kuku Kaca + Box\r\nNano Glass Nail Buffer with Box\r\nuntuk kuku mengkilap seketika\r\n\r\nMudah digunakan dan dibersihkan\r\nBahan kaca, kuat dan tahan lama.\r\nTermasuk tempat penyimpanannya agar setelah dipakai dapat disimpan kembali dan kebersihannya terjaga.'),
('PR045', 'Eze Nails 4-IN-1 Nail Shiner (4-in-1 Kikir Kuku Kaca Pengkilap Kuku)', 'Eze Nails', 59990.00, 'CT007', 'upload/product/nail20.png', 'Eze Nails 4-in-1 Nail Shiner\r\n(4-in-1 Kikir Kuku Kaca Pengkilap Kuku)\r\n\r\nWHAT’S INSIDE?\r\n1 Nail Shiner + 1 Plastic Case\r\n\r\nKEGUNAAN 4-in-1 Nail Shiner:\r\n\r\nShine Nails (MENGKILAPKAN KUKU)\r\nGosok permukaan kuku asli dengan permukaan Nail Shiner yang bergerigi, sampai semua permukaan mengkilap merata. Kuku tempel pun akan menempel dengan lebih rekat.\r\n\r\nShape Nails (MEMBENTUK KUKU)\r\nRatakan dan bentuk ujung kuku dengan permukaan Nail Shiner yang bergerigi sampai mendapat bentuk yang diinginkan.\r\n\r\nPush Cuticle (MENDORONG KUTIKULA)\r\nArahkan bagian ujung lancip Nail Shiner untuk mendorong kutikula dan membentuk sesuai yang diinginkan.'),
('PR046', 'Duo Function Bundle', 'Tone', 24900.00, 'CT007', 'upload/product/nail21.png', 'Aman bagi kuku dan terdapat vitamin E.. You will get 2 different function :\r\n- Acetone Nail Polish Remover / Penghapus Cat Kuku 60 ml\r\n- Non Acetone Nail Polish Remover / Penghapus Cat Kuku 60 ml\r\n\r\nKekuatan menghapus cat kuku sangat baik. Perbedaan antara \"Aceton\" dan \"Non Aceton\" adalah dari bahan yang digunakan. Keunggulan lain dari Non Acetone adalah bisa digunakan untuk mengencerkan kutek yang sudah lama dan mengental serta cocok untuk yang sensitif/memiliki alergi acetone.'),
('PR047', 'My Healthy Nails', 'Tone', 29900.00, 'CT007', 'upload/product/nail22.png', 'You will get 2 important things :\r\n- Nail Vitamin\r\n- Kikir Kuku Glass\r\n\r\nTone Vitamin Booster Keratin + Calcium dapat membantu menguatkan dan menumbuhkan kuku secara sehat dan alami. Kandungan kalsium merupakan salah satu mineral yang penting untuk kesehatan kuku agar lebih sehat, tidak mudah patah, kering atau rusak. Kandungan lain seperti keratin alami dan aloe vera, dapat mengembalikan kekuatan kuku serta membuatnya menjadi lebih lembap.'),
('PR048', 'The Key of Lasting', 'Tone', 37900.00, 'CT007', 'upload/product/nail23.png', 'You will get 3 important things :\r\n- Glossy 10x Shine Top Coat\r\n- Matte Top Coat\r\n- Base Coat '),
('PR049', 'We Dare You- Red Edition', 'Tone', 34900.00, 'CT007', 'upload/product/nail24.png', 'You will get 6 beautiful shades :\r\n- Lavanya Red\r\n- Tawny Red\r\n- Mulberry'),
('PR050', 'Jelly Jingle', 'Tone', 34900.00, 'CT007', 'upload/product/nail25.png', 'Jelly Jingle :\r\nSweet Kiss\r\nYummy Yoghurt \r\nPudding Judy '),
('PR051', 'Gillette Foamy Shave Cream Menthol', 'Gillete', 37000.00, 'CT009', 'upload/product/gillete-1489375.png', 'Gillette Foamy Menthol kaya akan krim busa untuk kenyamanan bercukur, dengan wangi menthol. Menyebar dengan mudah, setelah dibilas dengan air kulit terasa halus dan lembut dan telah dinikmati selama beberapa generasi.'),
('PR052', 'Glimpse of Color', 'Tone', 34900.00, 'CT007', 'upload/product/nail26.png', 'Glimpse of Color :\r\nCharcoal\r\nSnowy Mochi\r\nEbony'),
('PR054', 'Gillette Isi Ulang Mach 3 - Isi 4', 'Gillete', 161000.00, 'CT009', 'upload/product/gillete962207934.png', 'Produk ini merupakan sebuah produk isi ulang yang dapat digunakan untuk mengganti kepala pisau cukur Gillette Mach 3. Dalam satu bungkus penjualan produk ini terdapat 4 buah cartridges yang dapat digunakan untuk mengganti kepala pisau cukur Gillette Mach 3 ketika masa penggunaan pisa cukurnya telah habis.'),
('PR055', 'Venus Comfort Glide White Tea Razor 2s', 'Gillete', 107690.00, 'CT009', 'upload/product/venus4938192754.png', 'Alat cukur wanita Gillette Venus dirancang untuk memenuhi kebutuhan khusus tubuh wanita. Kepala alat cukur wanita Venus Comfortglide White Tea memiliki 3 mata pisau dan dilengkapi dengansabun pelembab yang melepaskan body butter (pelembab) dengan wangi white tea untuk hasil yang mulus dan tahan lama. Kepala pisau cukur fleksibel juga memudahkan anda mencukur karena alat cukur dapat mengikuti lekuk tubuh dengan muda. Isi ulang alat Venus cocok dengan pegangan alat cukur Venus (Kecuali Venus Hybrid).'),
('PR056', 'Natural Wax Honey', 'SUGARPOT', 95000.00, 'CT009', 'upload/product/wax35097075.png', 'Sugarpot Natural Wax Honey adalah penghilang bulu dengan bahan bahan alami seperti madu dan lemon extract. Mengangkat rambut hingga ke akar, sehingga pertumbuhan kembali relatif lama yaitu 3 hingga 4 minggu. Bulu tumbuh kembali halus dan tidak kasar. Kulit terasa halus dalam satu kali pemakaian.'),
('PR057', 'Powerstay Demi-Matte Cover Cushion', 'Make Over', 225000.00, 'CT001', 'upload/product/adws352525.png', '\r\n[NEW PACKAGING] Make Over Powerstay Demi-Matte Cover Cushion diformulasikan dengan kemampuan oil control yang telah melalui uji terbaru dan terbukti dapat memberikan ketahanan tampilan flawlessyang tidak cakeyhingga 24 jam*, sehingga sangat cocok untuk kulit berminyak. Cushion ini merupakan cushion compact dengan coverage medium-to-full, memberikan hasil demi-matte dan soft-focus yang terlihat seperti kulit sehat yang halus. Mengandung SPF 50/PA++++ yang memberikan proteksi ekstra ke kulit dari paparan berlebih sinar matahari. Dilengkapi dengan aplikator puff anti-bakterial yang tahan air, sehingga tidak menyerap produk dan memberikan coverage yang maksimal. Dermatologically Tested, Non-Comedogenic, Alcohol-free dan Hypoallergenic.Kini tersedia dalam 20 shades yang beragam, dipilih bedasarkan riset warna & undertone kulit ke lebih dari 1000 wanita multi-etnis Indonesia dari Sumatra hingga Papua, menggunakan Shade Matching Technology.'),
('PR058', 'Poreless Matte Air Cushion Foundation', 'Focallure', 99000.00, 'CT001', 'upload/product/dsff545633.jpg', 'Biarkan Focallure bersamamu sepanjang jalan cantikmu\r\n\r\n[Poreless] Coverage medium hingga penuh. Agar porimu tidak bisa muncul di manapun. Tidak hanya menyembunyikan pori, tapi juga menyembunyikan jerawat dan berbagai bintik kemerahan. Meratakan warna kulit, tidak caket, serta memberimu kulit yang halus dan tanpa cacat.\r\n\r\n[Super Soft] Cushion powder cream sangat halus dengan puff bedak yang sangat halus, mudah diaplikasikan, ringan di wajah, tidak lengket, memberimu pengalaman make up yang praktis dan nyaman.\r\n\r\n[Matte Effect] Untuk menciptakan efek make up matte, secara khusus ditambahkan formula yang dapat mengontrol minyak. Kontrol minyak maksimal, ditambah dengan fungsi tahan air, secara efektif memperpanjang waktu ketahanan make up.\r\n\r\n[Plant Extracts] Dengan penambahan Ekstrak Chrysanthellum Indicum, Ekstrak Aloe Barbadensis, Ekstrak Centella Asiatica, dan formula tanaman berkhasiat lainnya. Membantu melembabkan kulit, mengurangi radang jerawat, dan menekan stimulasi kulit yang akan menimbulkan jerawat, serta membuat kulit lebih dan lebih sehat lagi.'),
('PR059', 'Fit Me Matte and Poreless Liquid Foundation', 'Maybelline', 171900.00, 'CT001', 'upload/product/qre343432.jpeg', 'Foundation cair full coverage dengan hasil matte natural. Dapatkan make up flawless dengan menggunakan Maybelline Fit Me! Foundation yang dilengkapi dengan 16H Oil-Control yang mampu menahan minyak dan SPF 22 sebagai perlindungan ekstra. Foundation yang tahan lama hingga 16 jam dengan formula non-comedogenic yang tidak menyumbat pori dan penyebab jerawat. Foundation yang bagus untuk semua jenis kulit, Fit Me! Matte + Poreless juga cocok dijadikan foundation untuk kulit berminyak. Foundation Maybelline ini juga dapat digunakan untuk menyamarkan berbagai masalah kulit seperti noda di wajah, hiperpigmentasi, kulit bertekstur, dan pori-pori wajah. Gunakan Maybelline Fit Me! Matte + Poreless Foundation sebagai salah satu cara mengecilkan pori-pori wajah agar terlihat mulus. Shade Maybelline Fit Me! tersedia dalam 20 warna yang bisa meng-cover semua warna kulit wanita Indonesia.'),
('PR060', 'Radiant Silk Foundation SPF 50 PA+++', 'Luxcrime', 159000.00, 'CT001', 'upload/product/qe3242342.jpg', 'Claim:\r\n- With Anti Pollutant agent\r\n- Soothes redness & blemishes skin\r\n- Calming & Soothing\r\n- Suitable for sensitive skin\r\n- Dermatology tested\r\n- Vegan Product\r\n\r\nDescription:\r\nA weightless foundation with calming and soothing benefits to reduce skin redness and blemishes. Suitable for sensitive skin, this liquid foundation creates an airbrushed, silky skin appearance and a naturally radiant finish. Formulated with Glycerin to strengthen skin’s barrier, Centella Asiatica Extract to sooth the skin and Green Tea Extract to improve skin hydration. '),
('PR061', 'Bloomatte Stay Confident 2-in-1 Foundation', 'Barenbliss', 139000.00, 'CT001', 'upload/product/afda322234.png', '2-in-1 foundation yang ringan dan tahan lama hingga 16 jam dilengkapi balm concealer yang dapat menghasilkan tampilan flawless natural-matte, mengandung skin-loving ingredients, yang cocok untuk semua jenis kulit. Non-comedogenic.       \r\n\r\n1. DOUBLE LOCK TECH: Super Fit x MMF* Power-lock Tech\r\nTeknologi dari Jerman dalam memproses bahan baku untuk film-former secara kuat mengikat serbuk, membuat makeup lebih tahan lama dan dikombinasikan dengan Ultra-fine powder yang memberikan coverage tinggi hingga menyamarkan pori-pori, serta menghasilkan makeup yang tahan air dan tahan keringat.\r\n\r\n2. Miracle Bloom™ Essence\r\nDilengkapi dengan 5 tanaman Korea (Hibiscus, Magnolia, Chamomile, Centella, dan Calendula) sebagai antioksidan yang baik untuk menutrisi dan menjaga kesehatan kulit semua jenis kulit, termasuk kulit berjerawat.\r\n\r\n3. Rapeseed Oil\r\nMemberikan tampilan kulit yang halus dan membantu mengunci kelembapan.\r\n\r\n4. UV Protection\r\n SPF50+ PA+++, membantu melindungi kulit dari paparan sinar UV.'),
('PR062', 'YOU Simplicity Glowy CC Cushion', 'YOU Beauty', 110000.00, 'CT001', 'upload/product/qwqe34242.png', 'CC Cushion dengan kandungan Ekstrak Witch Hazel, 4D Hyaluronic Acid dan Ekstrak Peach Blossom yang kaya Antioksidan, membantu melembabkan, dan memberikan tampilan wajah lebih lembut dan berkilau natural.\r\n\r\n🍑 Natural Glow Complexion\r\n\r\nKulit glowing natural dengan kandungan 4D Hyaluronic Acid yang membantu menjaga kulit tetap terhidrasi dan lembap\r\n\r\n🍑 Lightweight & Buildable\r\n\r\nFormula nyaman dan ringan di kulit dengan daya cover medium yang tahan lama\r\n\r\n🍑 Pore Blurring Effect\r\n\r\nKandungan Ekstrak Witch Hazel yang membantu menyamarkan tampilan pori dan memberikan hasil kulit lembut'),
('PR063', 'Everyday BB Cream', 'Wardah', 53000.00, 'CT001', 'upload/product/we5352343.jpg', 'Everyday BB Cream merupakan krim wajah serbaguna yang bisa melembabkan dan punya coverage bahkan mengandung SPF untuk melindungi kulit dari sengatan matahari. produk yang lebih ringan dari foundation. Formula unik Water Break Technology melepaskan bulir-bulir air yang melembabkan dan memberikan kesegaran serta efek sejuk saat BB cream diaplikasikan pada wajah.\r\n\r\n\r\n\r\nDengan Water Break Technology, partikel-partikel air yang terlepas dari formulanya membuatnya terasa dingin, segar dan lembab ketika diapplikasikan. Mengandung Aloe Vera Extract & Bio-Hyaluronic Acid untuk menutrisi sekaligus melembabkan kulit. Witch Hazel extract dan Zinc Gluconate sebagai oil control mengatur produksi sebum sehingga bebas kilap lebih lama.'),
('PR064', 'Magic Cushion Moist Up Spf 50+/pa+++', 'Missha', 399000.00, 'CT001', 'upload/product/qe3242345.jpg', 'MAGIC CUSHION MOIST UP (LEBIH MELEMBABKAN!)\r\n\r\nTidak ada lagi kulit berminyak!\r\n\r\nKulit yang segar & bercahaya!\r\n\r\n01. Melembabkan dan Tahan Lama!\r\n\r\nMemberikan lebih banyak hidrasi dengan Botanical Fresh Water*\r\n\r\n* Vegetable Fresh Water : Air teh hijau, Air Daun Sage, air akar teratai.\r\n\r\n2. Kulit halus dan bercahaya!\r\n\r\nFormula segar membantu membuat kulit bercahaya tanpa cacat di kulit.\r\n\r\n3. Tanpa Kulit Kusam!\r\n\r\nMembantu kulit seimbang untuk kulit tampak sehat untuk waktu yang lama. Bantalan sponge cushion yang jauh lebih tahan lama!. Sifat Sponge di Cushion ini : 1. SOFT SPONGE : Anda dapat memakai base makeup di seluruh wajah Anda hanya dengan 1 ~ 2 x pengambilan.\r\n\r\n2. Easy Sponge : Anda tidak perlu membalikkan spons bahkan setelah sering digunakan\r\n\r\n3. Lasting Sponge : Spons tidak mudah habis, gunakan seperti Anda baru pertama kali memakainya! MAGIC CUSHION COVER LASTING : untuk hasil akhir kulit semi-matte, MAGIC CUSHION MOIST UP : hasil kulit bercahaya dengan hidrasi segar. Magic Cushion bersifat tahan lama dengan tekstur segar yang membantu membuat kulit bercahaya dengan jumlah kecil. Ambil Produk Secukupnya Dengan Menekan Puff Pada Produk. Tepuk Puff Secara Lembut Pada Wajah. Ulangi Proses Ini Untuk Mendapatkan Tingkat Coverage Yang Diinginkan, Gunakan Sesedikit Mungkin Produk Untuk Mempertahankan Tekstur Ringan Pada Wajah.\r\n\r\nSEE LESS'),
('PR065', 'M Perfect BB Cream SPF42 PA+++', 'Missha', 179000.00, 'CT001', 'upload/product/weq7858567.jpeg', 'Produk paling populer dan telah terjual lebih dari 30 juta produk!\r\n\r\n\r\n\r\nMenggabungkan kosmetik dengan perawatan kulit. Produk ini mampu memberikan coverage yang alami, memberikan perlindungan dari sinar matahari, membantu menutupi noda dan kerut halus pada wajah.\r\n\r\n\r\n\r\nCocok untuk semua jenis kulit dan dapat digunakan sebagai dasar makeup atau foundation.\r\n\r\n\r\n\r\nCara Penggunaan :\r\n\r\n\r\n\r\nPompa Keluar Jumlah Krim Yang Diinginkan (Seukuran Kacang), Dan Oleskan Secara Halus Di Kulit Dengan Menggunakan Metode Yang Disukai (Jari, Spons Aplikator, Sikat)'),
('PR066', 'Powerskin Radiant Tinted Moisturizer', 'Make Over', 159000.00, 'CT001', 'upload/product/etw646365.png', 'Powerskin Radiant Tinted Moisturizer dengan Color Balance Technology yang memberikan kelembapan tahan lama pada kulit dehidrasi, dengan coverage yang natural dan hasil yang dewy, memberikan tampilan kulit yang tampak sehat dan makeup natural untuk sehari-hari. Dilengkapi dengan SPF 30 melindungi kulit dari sinar UV sehari hari.'),
('PR067', 'A tint of You - SYCA Natural Glow Weightless Tinted Moisturizer', 'SYCA', 159000.00, 'CT001', 'upload/product/ewtw858678.png', 'A tint of You - SYCA Natural Glow Weightless Tinted Moisturizer\r\n\r\nNet : 35 gram\r\n\r\nTelah ter uji dermatologi\r\nNon komedogenik\r\n\r\nSeperti kulit Anda pada hari-hari terbaiknya!\r\n\r\nApa itu : Produk ini menghidrasi dan memberikan tampilan semi-satin yang sehat dengan formula ringan untuk merangkul pancaran kulit alami kita.\r\n\r\ntersedia dalam 3 shade :\r\n\r\n#L1 - LIGHT\r\nWarna beige muda dengan hasil akhir dewy yang cocok untuk undertone dingin\r\n\r\n#M1 - MEDIUM\r\nWarm Beige dengan soft golden undertone\r\n\r\n#D1 - DEEP\r\nYang terbaik untuk medium dark skintone,  dengan peachy undertone'),
('PR068', 'Good Skin Day Tinted Serum', 'Secondate', 129000.00, 'CT001', 'upload/product/wer343566.png', 'the good skin day tinted serum is a silky, breathable formula that effortlessly syncs to your skin, providing a ‘good skin’ coverage in seconds that feels weightless. our skin tint moves with you, blending seamlessly while boosting your skin with deep hydration that adapts and enhances it—giving you that coveted fresh-faced complexion you\'ve always desired. available in four flexible shades designed to match various skin tones, ensuring you look and feel like the best version of yourself, all day, every day.'),
('PR069', 'Colorfit Velvet Powder Foundation', 'Wardah', 99000.00, 'CT001', 'upload/product/wrq36363.png', 'Kombinasi foundation dan bedak yang mampu menyamarkan pori pada wajah sehingga wajah terlihat mulus dan pori-pori tersamarkan. Diformulasikan dengan Matte Micropowder untuk memberikan matte finish serta mampu menahan minyak secara tahan lama hingga 12 jam. Dilengkapi SkinMatch Technology sehingga warnanya dapat menyatu sempurna dengan warna kulit serta SPF 20 PA+++ yang dapat melindungi kulit dari sinar UV.'),
('PR070', 'Instaperfect Refill Matte Fit Powder Foundation', 'Instaperfect', 105000.00, 'CT001', 'upload/product/ewrw4633.jpeg', 'Instaperfect Refill Matte Fit Powder Foundation adalah kemasan ulang bedak atau powder foundation dari Instaperfect dengan formula yang lebih baik dari sebelumnya dan hadir dengan kemasan baru yang lebih cantik. Powder Foundation yang halal dalam kemasan refill yang dapat memberikan keunggulan yang paling diinginkan dari makeup setter, yaitu Real-Skin Cover Setter. Mengunci lapisan makeup dengan medium coverage untuk menyamarkan noda hitam bekas jerawat dan kemerahan, namun tetap terasa seperti kulit asli. Menjaga makeup tetap on sepanjang hari dengan tampilan Smooth Matte Finish. Tidak perlu khawatir pada crack, patch, dan kilap. Diformulasikan dengan SPF 20 PA+++ & Ectoin sebagai Urban Skin Veil yang melindungi kulit dari UV-A, UV-B, dan hamrful urban environment dan menjadi protective veil untuk memperkuat skin barrier dalam penggunaan jangka panjang. Cocok untuk semua jenis kulit, dermatologically tested, non acnegenic, non comedogenic, dan hypoallergenic.\r\n\r\nKeunggulan:\r\n- Real Skin Cover Setter\r\n- Smooth Matte Finish\r\n- Urban Skin Veil infused with Ectoin and SPF 20 PA+++\r\n- No Crack, Patch, and Shine'),
('PR071', 'The Realest Lightweight Powder Foundation', 'Rose All Day', 139000.00, 'CT001', 'upload/product/wrqrq56363.png', 'Foundation padat dengan formula Pore-Blurring dan non-drying Matte-finish hingga 12 jam. Diinovasikan dengan Teknologi BI-COAT™ yang efektif untuk menciptakan hasil riasan yang menempel lebih lama & tampak lebih halus seperti tanpa pori-pori. Dilengkapi dengan puff dua sisi untuk mengatur tingkat Medium-to-Full coverage.'),
('PR072', 'Infallible 24H Fresh Wear Powder Foundation', 'Loreal Paris', 159000.00, 'CT001', 'upload/product/ewqe2334232.jpg', 'Temukan Bedak yang Viral di TIKTOK, L’Oreal Infallible 24H Fresh Wear Powder Foundation yang memberikan High Coverage in 1 Swipe.\r\n\r\nFormula Foundation Liquid dalam Bedak : Powder Foundation ini memberikan High Coverage seperti Liquid Foundation dan memberikan finish matte seperti bedak.\r\nHigh Coverage\r\nFresh, Matte Finish, tidak cakey\r\n24H Transferproof\r\nSweat proof\r\nWaterproof\r\nTahan terhadap cuaca yang panas dan lembab'),
('PR073', 'Bare With Me Mineral Loose Powder', 'Emina', 61500.00, 'CT001', 'upload/product/werwq53234.jpg', 'Salah satu bedak untuk kulit berminyak produksi lokal adalah Emina Bare With Me Mineral Loose Powder yaitu bedak tabur yang memiliki kandungan Lauroyl lisine, mica dan oil absorbing powder yang bekerja secara sinergis untuk memberikan hasil yang halus, natural, dan bebas kilap sepanjang hari.\r\n\r\nDengan bahan yang aman digunakan, Bare With Me Mineral memberikan hasil akhir sutra dan alami yang aman untuk semua jenis kulit. Melengkapi dengan bahan-bahan penyerap minyak, memberikan kilau setiap hari dan dengan tekstur bedak yang halus hasil make up akan terlihat ringan.\r\n\r\nTersedia dalam 4 warna (Fair, Light Beige, Amber, Ebony)'),
('PR074', 'Powerstay Mattifying Transparent Powder', 'Make Over', 159000.00, 'CT001', 'upload/product/ewtw22434.jpg', 'Loose Powder yang memberikan hasil akhir matte dan tahan 4 jam lebih lama!\r\n\r\nInovasi baru loose powder Make Over Powerstay Mattifying Transparent Powder.\r\nBedak tabur yang menghasilkan tampilan wajah matte dengan Optical Blur-Translucent Technology yang mampu memberikan efek soft focus sehingga wajah terlihat lebih halus.\r\n\r\nTransparent Powder ini cocok untuk semua warna kulit karena tidak memiliki warna dan langsung menyatu dengan kulit. Dilengkapi fungsi Oil Control untuk menyerap minyak berlebih pada wajah serta mengunci makeup sehingga bertahan 4 jam lebih lama.'),
('PR075', 'Colorfit Mattifying Powder', 'Wardah', 99000.00, 'CT001', 'upload/product/wrewr214145.jpeg', 'Bedak tabur dengan UV A/B Protection yang halus untuk wajah bebas kilap dan hasil akhir matte. Diformulasikan khusus dengan SkinMatch Technology untuk dapat menyatu sempurna dengan warna natural kulitmu dan Matte Micropowder untuk memberikan efek oil control pada wajah. Size: 15 gr'),
('PR076', 'Setting Powder', 'Foccalure', 39000.00, 'CT001', 'upload/product/qew1343432.jpg', 'Bedak tabur.\r\nDapatkan hasil makeup yang sempurna dan glowing dengan bedak tabur ini! Bedak dengan formula revolusi terbaru yang dapat meminimalisasi tanda-tanda penuaan. Teknologi Halo’s Hydration yang telah dipatenkan ini dapar membantu menciptakan kulit yang bercahaya dan sehat. Cukup dengan memutar bagian atas kemasan dan menaburkannya sesuai dengan yang kamu inginkan tanpa perlu merasa khawatir bahwa riasakan kamu akan terlihat berlebihan. Bedak ini dapat digunakan sebagai finishing powder ataupun dapat digunakan sehari-hari.'),
('PR077', 'Silky Blur Powder', 'Secondate', 149000.00, 'CT001', 'upload/product/rtrytrwer4235424.png', 'meet Silky Blur Powder, the magical beauty essential that will leave an angel-like finish on your skin. its hazy pore effect effortlessly blurs imperfections, giving you a dreamy, cloudy-skin complexion. with its microscopic feather-like particles, this powder creates a soft-focus airbrushed look, making your skin appear flawlessly radiant. embrace the benefits of its oil-absorbing properties, ensuring your makeup stays fresh and shine-free all day long.'),
('PR078', 'Luxcrime Second Skin Loose Powder', 'Luxcrime', 139000.00, 'CT001', 'upload/product/fhfg5464646.png', 'Claim:\r\n- No White Cast/Flashback\r\n- Smooth skin texture\r\n- Oil Control\r\n- Natural looks\r\n\r\nSecond Skin Loose Powder locks in makeup, absorbs oil and reduces shine all day, creating a flawless, natural finish with no white cast or flashback in photos. These universal shades work on all skin tones, and create a smoothing effect to subtly blur skin texture, fine lines and imperfections.\r\n\r\nShades:\r\n1. Banana – for light to deep skin tones with yellow or olive undertones\r\n2. Translucent Light - for very fair to medium skintones\r\n3. Translucent Deep - for medium to deep skintones'),
('PR079', 'Flawless Powder Foundation', 'ESQA', 139000.00, 'CT001', 'upload/product/trtwt24144.jpeg', 'A long-wearing powder foundation that gives you a flawless and smooth skin with matte finish! It has medium to full buildable coverage that will control your shine throughout the day. Comes in a velvety texture that will blend seamlessly with your makeup without that tight-feeling dryness. Say hi to non-caking, non-creasing and non-fading makeup all day!'),
('PR080', 'Everyday Perfect Blurring Compact Powder', 'Buttonscarves', 425000.00, 'CT001', 'upload/product/twret5464567.jpeg', 'Buttonscarves Beauty Everyday Perfect Blurring Compact adalah bedak padat yang dibuat untuk menyempurnakan riasan wajah. Diformulasikan dengan campuran foundation yang cukup, sehingga memberikan efek blurring (meratakan warna dan tekstur) pada wajah namun masih ringan. Mengontrol minyak untuk pemakaian sehari-hari. Dilengkapi dengan UV Protection melindungi wajah dari sinar UVA & UVB. Compact powder ini dilengkapi dengan cermin & spons aplikator. Sempurna untuk digunakan sehari-hari dan nyaman untuk dibawa kemana-mana. #FlawlessOnTheGo'),
('PR081', 'Blush On', 'Wardah', 48000.00, 'CT001', 'upload/product/jgh657646.jpg', 'The Perfect Blush is what you need. Kombinasi dua pigmen warna pilihan yang memiliki kandungan Microcoated Particle membuat pipi merona sempurna dan lebih berseri. Tersedia dalam 4 kombinasi warna yang cantik dan natural sehingga cocok untuk semua warna kulit.'),
('PR082', 'Intensive Nourishing Eye Cream Alpha Arbutin + Squalane + Kojic Acid + Retinol + Peptide + Edelweiss Extract', 'Avoskin', 159000.00, 'CT002', 'upload/product/vbnnv5634633.jpg', 'Intensive Nourishing Eye Cream kini hadir dengan formula baru yang lebih efektif untuk merawat kulit di sekitar area mata. Krim mata ini memiliki kandungan utama yaitu Squalane, Alpha Arbutin, Kojic Acid, Sodium Hyaluronate, Ekstrak Edelweiss, Peptide, Retinol, Ekstrak DNA, dan vitamin E. Perpaduan kandungan tersebut berfungsi untuk membantu mencerahkan kulit di sekitar area mata, menyamarkan lingkaran hitam, menyamarkan garis halus, menyamarkan kantung mata, serta menjaga area kontur mata agar tetap sehat dan lembap. Saatnya tampil percaya diri dengan mata yang lebih cerah, segar, dan terawat!');
INSERT INTO `product` (`product_id`, `product_name`, `brand`, `price`, `cat_id`, `product_img`, `product_desc`) VALUES
('PR083', 'Advance Action Eye Ampoule', 'Avoskin', 225000.00, 'CT002', 'upload/product/fgjvbn546736.jpeg', 'Perpaduan kandungan peptide, niacinamide, dan ekstrak natural lainnya membuat Avoskin Advance Eye Ampoule bisa menjadi pilihanmu untuk merawat kulit sekitar mata dengan lebih optimal. Produk ini akan menghasilkan efek yang signifikan dengan pemakaian rutin pada pagi dan malam hari. Hasil akan terlihat semakin nyata setelah pemakaian 28 hari.'),
('PR084', 'Water Bank Blue Hyaluronic Eye Cream', 'Laniege', 600000.00, 'CT002', 'upload/product/fdrg3466366.jpg', 'Krim mata ini berguna untuk mengencangkan kulit dan membantu menyamarkan lingkar hitam pada kulit di sekitar mata serta mengurangi tampilan kantung mata dengan kandungan Blue Hyaluronic Acid, berukuran 1/2000 dari ukuran normalnya\r\n\r\nBlue Hyaluronic Acid yang kaya akan kelembapan, dengan kandungan niacinamide dan kafein untuk mencerahkan dan menyegarkan area bawah mata! Blue Hyaluronic Acid, difermentasi dengan ganggang laut dalam dan proses mikrofiltrasi 10 langkah, langsung menyerap untuk hidrasi yang dalam dan tahan lama.\r\n\r\n- Terlihat mencerahkan lingkaran hitam\r\n\r\n- Memperbaiki tampilan kerutan dan bengkak\r\n\r\n- Efek pendinginan instan'),
('PR085', 'Matcha Biome Hydrogel Eye Patch', 'Heimish', 290000.00, 'CT002', 'upload/product/ry657775.jpeg', 'Membantu menyamarkan kerutan dan garis-garis halus,Dilengkapi dengan kandungan bahan alami, produk ini mudah larut dalam air, Tidak hanya dapat digunakan pada area bawah mata, dapat juga digunakan di area wajah lain yang dirasa membutuhkan,Melekat dengan baik dan mengandung essence yang mudah diserap oleh kulit.'),
('PR086', 'Lip balm Nutrition', 'Make Over', 57000.00, 'CT002', 'upload/product/fd7866867.jpg', 'Lip Balm Lip Nutrition adalah pelembap bibir dan produk ini menjadi pilihan tepat untuk digunakan sebagai produk perawatan utama untuk bibir kering dan pecah-pecah. Kandungannya kaya moisturizer dan kaya vitamin, berfungsi untuk menjaga kelembaban bibir, mencegah hilangnya kadar air dan melindungi bibir sensitif. Tersedia dengan aroma buah, lip balm ini penting untuk digunakan setiap harinya.'),
('PR087', 'Nourishing Care Lip Sleeping Pack', 'Klavuu', 225000.00, 'CT002', 'upload/product/gfhdd675765.jpeg', 'Sleeping pack untuk bibir dengan formula baru yang dikembangkan dengan konsep Cleanical,, gabungan teknologi (TECHNICAL) High Fix Polymer dan bahan yang alami (CLEAN) minyak tumbuhan yang kaya nutrisi. Teknologi High Fix Polymer dan tekstur balm dari produk ini membentuk lapisan pelindung pada kulit bibir sehingga bibir tetap lembab sepanjang malam. Kulit kering yang mudah terkelupas berkurang, bibir terasa segar, kenyal dan lembut saat disentuh di pagi hari.'),
('PR088', 'Lip Scrub Green Te', 'Liplapin', 42000.00, 'CT002', 'upload/product/hjghjgk787878678.png', 'Notes : Jar dan inner pack nya bisa dipasang dan dilepas, jadi kamu bisa gunakan lagi untuk organizer ketika scrub sudah habis.\r\n\r\nLip treatment dengan wangi green tea yang manis, membantu mengangkat sel kulit mati pada bibir pecah dan kusam sehingga bibir menjadi lebih halus dan lembut serta melemebabkan dan mencerahkan bibir..'),
('PR089', 'Natural Lip Serum', 'Jiera', 45000.00, 'CT002', 'upload/product/ew1434141.png', 'Jiera Natural Lip Serum terbuat dari kombinasi Olive Oil dan Macadamia Oil sebagai duo pelembap alami yang menjaga kelembapan kulit bibir dan mencegah bibir pecah-pecah dan diperkaya dengan Vitamin E yang menutrisi dan menjaga kesehatan kulit bibir dan Saffron Oil sebagai antioxidant yang dapat melindungi bibir dari kerusakan akibat radikal bebas.\r\n\r\nJiera Natural Lip Serum tidak hanya berfungsi sebagai lip care, namun juga dapat digunakan sebagai Lip Cosmetics Base dan Remover\r\n\r\nJiera Lip Serum Roll On 5ml adalah produk Jiera Lip Serum dengan size dan packaging baru yang lebih travel friendly'),
('PR090', 'Acne Care Kit', 'Derma Angel', 60000.00, 'CT002', 'upload/product/hdtfdtg53436435435.jpg', '-Acne Patch Derma Angel merupakan stiker jerawat yang dapat menyamarkan, menyembuhkan dan melindungi jerawat dari debu, polusi, dan kotoran\r\n-Solusi perawatan lengkap untuk pagi hingga malam hari\r\n-Solusi anti jerawat untuk wajah cantik dan cerah serta mencegah timbulnya bekas jerawat\r\n-Tipis 0.01 cm & transparan, waterproof, dan make-up friendly\r\n-Menyerap jerawat hanya dalam 18 jam'),
('PR091', 'Tea Tree Acne Treatment Cream', 'Breylee', 80000.00, 'CT002', 'upload/product/fhgf6454e.jpg', 'Formula ringan dan kaya dengan kandungan tea tree oil dan bahan alami lainnya. Membantu mempercepat proses pemulihan, meredakan dan merawat kerusakan pada kulit wajah yang disebab- kan oleh jerawat.\r\n\r\nCocok untuk semua kulit termasuk kulit sensitif.'),
('PR092', 'Acnederm Pore Refining Toner', 'Wardah', 35000.00, 'CT002', 'upload/product/fyhjg674647.jpg', 'Toner yang diformulasikan khusus untuk kulit berminyak dan berjerawat. Dengan kombinasi Derma Tret Actives dengan Witch Hazel dan Aloevera Extract. Mampu membantu meringkas pori-pori yang telah dibersihkan dari kotoran dan debu yang menyumbat. Membantu mengontrol kelebihan minyak diwajah, mengurangi kemerahan akibat iritasi, menyeimbangkan kelembapan kulit. Cocok untuk kulit berjerawat sebelum menggunakan pelembab.'),
('PR093', 'Snail Bee High Content Essence', 'BENTON', 320000.00, 'CT002', 'upload/product/wqdq312341.jpeg', 'Snail Bee High Content Essence adalah essence yang mengandung Snail Secretion Filtrate dan Racun Lebah yang baik untuk regenerasi sel, melembabkan, merawat elastisitas kulit, dan mengurangi radang. Selain itu, essence ini juga mengandung Niacinamide yang dapat mencerahkan dan meratakan warna kulit, serta membantu untuk menyamarkan noda hitam pada kulit. Kandungan Adenosine pada essence ini juga baik untuk membantu menyamarkan tanda penuaan dan menyamarkan gari-garis halus pada wajah. Direkomendasikan untuk kulit yang berjerawat, kusam, dan warna kulit yang tidak rata.'),
('PR094', 'Lightening Serum Ampoule', 'Wardah', 32000.00, 'CT002', 'upload/product/FSDDG23234.png', 'Lightening Facial Serum bekerja secara intensif untuk mencerahkan kulit wajah sekaligus melembabkannya.\r\n\r\n\r\n\r\nSerum wajah dengan manfaat vitamin B3 untuk mencerahkan kulit wajah yang kusam. Dilengkapi dengan Vitamin E sebagai antioksidan yang membantu merawat kulit dari kerusakan akibat radikal bebas. Untuk kulit tampak lebih cerah.\r\n\r\n\r\n\r\nUntuk kulit tampak cerah, cocok untuk semua jenis kulit.\r\n\r\n\r\n\r\nMengandung konsentrat Vitamin B3 yang akan membantu mencerahkan kulit wajah dan mengurangi noda hitam.\r\n\r\nKandungan lain : Vitamin E sebagai antioksidan, Extra Aloe Vera dan Hyaluronic Acid yang berfungsi untuk melembabkan wajah dan menjaga kelembaban kulit.'),
('PR095', 'YOU 8× SymWhite 377 Radiance Up! Brightening Serum', 'YOU Beauty', 139000.00, 'CT002', 'upload/product/twswser32525.jpg', 'Antioxidant Serum diformulasikan dengan Powerful Brightening System, Korean Camellia Extract, dan Carnosine yang membantu mengurangi kekusaman dan tampilan noda hitam pada kulit akibat radikal bebas dan glikasi untuk kulit yang cerah.\r\n\r\nBenefits:\r\n- POWERFUL BRIGHTENING SYSTEM\r\nSymWhite377, Niacinamide (B3), Vitamin C, dan Licorice Extract bekerja secara bersinergi dalam membantu mengurangi kulit kusam dan noda hitam untuk kulit yang cerah berseri.\r\n\r\n- FREE RADICAL SHIELD\r\nKorean Camellia Extract kaya akan antioksidan untuk melindungi kulit dari radikal bebas.\r\n\r\n- ANTI-GLYCATION SUPPORT\r\nCarnosine membantu mengurangi kerusakan kolagen dan elastin yang disebabkan oleh glikasi untuk kulit yang lebih cerah berseri.\r\n\r\nUSP:\r\nPowerful Brightening System\r\nFree Radical Shield\r\nAnti-glycation Support\r\n\r\nKemasan yang akan dikirimkan random tergantung ketersediaan.'),
('PR096', 'SKIN1004 Madagascar Centella Ampoule', 'SKIN1004', 714000.00, 'CT002', 'upload/product/FASEFSE3254324.jpeg', 'Main Ingredients Centella Asiatica Extract Product Introduction SKIN1004\'s Best Seller „Calming Ampoule‟- a bottle filled with Madagascar‟s unsullied Centella Asiatica Product Characteristics Instantly soothes sensitive skin and provides ample hydration to damaged skin for a dewy looking skin How to Use After cleansing, apply to face and let it absorb into skin. Proceed with lotion and cream after'),
('PR097', 'Pig-nose Clear Black Head Perfect Sticker', 'Holika Holika', 11000.00, 'CT002', 'upload/product/FHFHG354354.png', 'Stiker untuk mengangkat komedo secara efektif dengan pink clay dan ektrak lemon.\r\n\r\nPig Nose Clear Blackhead Perfect Sticker menempel di hidung dan menyerap semua kotoran dan komedo dari pori-pori dengan kandungan pink clay. Dengan pemakaian teratur dapat menghilangkan kotoran dari pori-pori wajah anda yang membuat kulit ada menjadi bersih dan lembut.'),
('PR098', 'Gentle Skin Cleanser', 'Chetaphil', 139000.00, 'CT002', 'upload/product/gffd64354.jpg', 'Pembersih wajah dan tubuh yang lembut, mampu menenangkan dan membersihkan kulit tanpa menyebabkan iritasi.\r\n\r\n\r\n\r\nFormulanya yang bebas sabun telah memenangkan banyak penghargaan dari orang-orang dalam industri kecantikan dan komunitas perawatan kesehatan. Sifatnya yang lembut dan tidak menyebabkan iritasi menenangkan kulit Anda saat membersihkan. Cetaphil Gentle Skin Cleanser diformulasikan untuk bekerja pada semua jenis kulit, bahkan untuk bayi.\r\n\r\n\r\n\r\nCocok untuk semua jenis kulit Ideal untuk wajah dan tubuh. Bekerja tanpa menyebabkan iritasi kulit, formulasi pH non-sabun yang seimbang. Dapat digunakan dengan atau tanpa air.'),
('PR099', 'Purifying Barrier Ice Cream Cleansing Balm', 'SKINTIFIC', 159000.00, 'CT002', 'upload/product/fdgft354354.png', 'Cleansing balm dengan tekstur selembut ice cream, meleleh dengan mudah untuk membersihkan secara mendalam dan mengurangi tampilan komedo (effortless). Diformulasikan untuk meluruhkan makeup waterproof dan kotoran dengan cepat, hanya dalam 10 detik, dan tidak meninggalkan residu setelah pembilasan. Kandungan Ceramide dan Vitamin E menjadikan kulit halus, lembap, tidak kering setelah pemakaian, serta menjaga barrier kulit tetap sehat. Memiliki aroma berry yang segar dan menenangkan kulit, serta formula yang aman dan tidak perih di mata.'),
('PR100', 'SKIN1004 Madagascar Centella Light Cleansing Oil', 'SKIN1004', 225000.00, 'CT002', 'upload/product/rtrrrt54456.jpg', 'A cleansing oil, made with a blend of Centella Oil from Madagascar, the untouched nature, and 6 different plant based oils, melts away surface impurities and makeup, and cleanses skin with a lightweight formula, leaving skin purified and refreshed.\r\n\r\n⭐SKIN1004 Madagascar Centella Light Cleansing Oil 30ml⭐\r\n\r\n> Masa penyimpanan: 12 bulan setelah dibuka / 36 bulan setelah diproduksi\r\n\r\n🍀TIDAK ada lagi yang namanya memencet jerawat! Hilangkan sebum kamu dengan minyak\r\n\r\n> Bersihkan dengan lembut dengan minyak botanical yang mirip dengan sebum kamu untuk membersihkan pori-pori secara mendalam\r\n\r\n🍀 Membersihkan dengan Kuat & Hasil Akhir yang Segar\r\n\r\n> Centella Asiatica Ekstrak tipe minyak\r\n\r\n> Partikel Micellar yang disatukan dengan kekuatan pembersihan untuk membersihkan makeup tebal dalam sekali usap!\r\n\r\n> Perawatan sebum yang hipoalergenik\r\n\r\n> Hasil akhir yang menyegarkan\r\n\r\n🍀Selected Raw Materials & Ingredients\r\n\r\n[Menenangkan kulit] : SKIN1004 memproduksi sendiri Ekstrak Centella Asiatica Bertipe minyak\r\n\r\n[Perawatan Sebum] : Helianthus Annuus (Bunga Matahari) Seed Oil, Olea Europaea (Zaitun) Fruit Oil\r\n\r\n[Memberikan Kelembaban] : Citrus Aurantium Bergamia (Bergamot) Fruit Oil, Simmondsia Chinensis (Jojoba) Seed Oil\r\n\r\n💟BEAUTY TIP!\r\n\r\n⭐⭐3 Langkah Pembersihan Profesional⭐⭐\r\n\r\n#1 Centella Ampoule Remover : Untuk yang sering menggunakan makeup tebal\r\n\r\n#2 Centella Light Cleansing Oil : Untuk yang memakai makeup setiap hari\r\n\r\n#3 Centella Ampoule Foam : Untuk yang menyukai pembersihan yang hipoalergenik\r\n\r\n✔ Ingredients List\r\n\r\nEthylhexyl stearate, cetyl ethylhexanoate, sorveth-30 tetraoleate, centella extract, sunflower seed oil, bergamot oil, olive oil,\r\n\r\njojoba seed oil, ethylhexylglycerin, scented geranium flower oil, damask rose flower oil'),
('PR101', 'All Clean Balm', 'Heimish', 159000.00, 'CT002', 'upload/product/FSDSDFS3324.jpg', 'Pembersih Serba Guna untuk makeup waterproof, kotoran, dan komedo - Cepat larut menjadi minyak saat bersentuhan dengan kulit dan membersihkan semua residu.\r\n\r\nTidak Mengiritasi Mata - Tidak perih ketika secara tidak sengaja masuk ke mata saat membersihkan.\r\n\r\nRendah Iritasi dan Vegan - Untuk ibu hamil dan/atau yang memiliki kulit sensitif dan berjerawat.\r\n\r\nAmbil dengan Spatula - Spatula mini yang nyaman termasuk dalam produk.\r\n\r\nPengalaman Seperti Spa - Mengandung wewangian herbal ringan yang tidak melekat di kulit.'),
('PR102', 'Make Up Remover Cleansing Oil Sheet', 'Biore', 115000.00, 'CT002', 'upload/product/dfgdfg64456.jpg', 'Make Up Remover Cleansing Oil Sheet pembersih make up siap pakai yang inovatif dari Biore ini mengandung bahan Cleansing Oil yang ringan dan lembut, sehingga tidak berbahaya bagi kulit wajah.\r\n\r\nFormulanya mampu membersihkan riasan yang melapisi kulit Anda, dan mengangkatnya secara total, bahkan area mata yang seringkali menggunakan riasan lebih tebal dari bagian wajah lainnya. Tidak perlu khawatir jika Anda menggunakan eyeliner atau maskara waterproof, karena pembersih ini bisa mengangkatnya juga.\r\n\r\nTidak menggunakan kandungan alkohol sama sekali, pembersih riasan ini aman digunakan untuk kulit apapun. Formula yang bebas alkohol ini juga memungkinkannya untuk menjaga kelembapan alami kulit sehingga tidak menjadi kering.\r\n\r\nSEE LESS'),
('PR103', 'Sekkisei Clear Wellness Milk Cleanser', 'KOSE', 300000.00, 'CT002', 'upload/product/gfddgf53w34w.jpeg', 'A milk cleanser containing soft konjac scrub that is gentle on skin.\r\n\r\nBanishes makeup and dullness*, for ultra clear skin.\r\n\r\n・Created with the concentrated natural goodness of our beautiful Earth, this milk-type cleanser leaves skin smooth and with deep clarity.\r\n\r\n・Gently softens skin prone to stiffening from dryness like an emulsion, while removing makeup without stressing skin\r\n\r\n・With soft scrub made of konjac beads, can be used daily without stressing skin. Has a pleasantly gooey texture to thoroughly remove makeup, dullness*, and dirt embedded deep in pores.\r\n\r\n・Formulated with original ingredient ITOWA, born from Japan’s nature. Luxuriously packed with Asian herbs and other botanical ingredients, it improves the quality and capacity of the moisture barrier to prevent roughness, and leave skin healthy and resistant to environmental stressors.\r\n\r\n・Formulated with Clarity Boost Complex to accelerate clarity.\r\n\r\n・Clean fragrance that expresses the refreshing scent of nature\r\n\r\n･Colorant Free'),
('PR104', 'Naufa Pure Olive Oil Bar Soap', 'Avoskin', 23000.00, 'CT002', 'upload/product/FSDFDS43235.jpg', 'Naufa Pure Olive Oil Bar Soap adalah produk pembersih wajah berbentuk sabun batang. Mengandung olive oil, goat milk, dan madu. Sabun wajah ini tak hanya berfungsi untuk membersihkan, namun juga melawan jerawat dan minyak berlebih. Hasilnya, kulit tampak lebih segar, lembut, dan cerah dari waktu ke waktu.\r\n\r\n\r\n\r\nCara Penggunaan :\r\nUsapkan sabun pada telapak tangan yang basah hingga berbusa. Lalu usapkan pada wajah dengan pijatan ringan kemudian bilas dengan air hingga bersih. Hindari kontak dengan mata.'),
('PR105', 'Cica Clear Pad', 'NPURE', 99000.00, 'CT002', 'upload/product/ESRSDFFS324.png', 'N\'PURE CICA CLEAR PAD is an easy to use soft exfoliation pad to effectively clean dead skin cells, improve skin dullness and make your skin softer and brighter. Its exoliating content is very mild and balanced with soothing ingredients, making it safe for all type of skin, including sensitive skin\r\n\r\nSuitable for all skin types & sensitive skin Pregnant & breastfeeding friendly Hypoallergenic & dermatologically tested Halal No alcohol No fragrance No paraben No animal testing USA Formulated\r\n\r\nActive Ingridients: New Advanced Formula with ORGANIC Cica Complex AHA, BHA, PHA\r\n\r\nProduct packaging might differ. Subject to availability\r\n\r\nKemasan yang akan dikirimkan random tergantung ketersediaan.'),
('PR106', 'Bioderma Sebium H2O - Oil Rebalancing Micellar Water', 'Bioderma', 300000.00, 'CT002', 'upload/product/eqwewq324.jpeg', 'SEBIUM H2O MICELLAR WATER - OIL REBALANCING MICELLAR WATER\r\n Pembersih wajah non bilas yang efeketif mengangkat makeup, debu, pollutant untuk kulit kombinasi berminyak cenderung berjerawat\r\n \r\n MANFAAT:\r\n 1. Membersihkan wajah dari kotoran, debu, dan makeup tanpa membuat kulit kering\r\n 2. Mengurangi produksi sebum berlebih pada wajah\r\n 3. Membersihkan kulit dengan lembut hingga 95%* tanpa rasa kering ketarik\r\n 4. Mengangkat debu & polutant hingga 93%**\r\n \r\n *Usage test on 20 volunteers aged 19 to 46, with combination or oily skin, for 7 days.\r\n **Study on 33 volunteers aged 18 to 67, with normal skin.\r\n\r\nKemasan yang akan dikirimkan random tergantung ketersediaan.'),
('PR107', 'HAMIGAKI NADESHIKO Baking Soda Glossy Toothpaste', 'Keana Nadeshiko', 139000.00, 'CT008', 'upload/product/asAsddq23.jpg', 'Pasta gigi yang membantu mengurangi noda kekuningan pada gigi dan memiliki aroma peppermint yang menyegarkan.\r\n\r\nGigi menguning disebabkan oleh warna yang terkandung dalam teh atau kopi, kemudian bercampur dengan protein pada gigi.\r\n\r\nKandungan bahan Baking Soda membantu menguraikan protein pada gigi, dan efek menyikat gigi dengan lembut akan menghilangkan noda kuning dari gigi dan menjadikan gigi tampak putih alami.\r\n\r\nTerbuat dari 100% bahan alami.\r\n\r\nDirekomendasikan untuk yang mencemaskan kekuningan gigi. Ingin bisa tertawa dengan percaya diri dan memiliki wajah tersenyum dengan gigi putih bersinar.'),
('PR109', 'Natural Toothpaste Whitening + Sensitive Protection', 'CLICK', 45000.00, 'CT008', 'upload/product/DSFSDERW34232.png', 'Click Natural Toothpaste Whitening + Sensitive Protection diformulasikan secara khusus dengan kandungan natural himalayan pink salt sebagai bahan aktif alami serta bahan aktif unggulan lainnya yang dapat membantu memutihkan gigi serta membantu meredakan sensitivitas pada gigi sensitive.\r\nDengan rasa watermelon mint yang unik dan menyegarkan.'),
('PR110', 'Natural Toothpaste Whitening + Strong Enamel Protection', 'CLICK', 45000.00, 'CT008', 'upload/product/FASDFSD3423.png', 'Click Natural Toothpaste Whitening + Strong Enamel Protection diformulasikan secara khusus dengan kandungan natural himalayan pink salt sebagai bahan aktif alami serta bahan aktif unggulan lainnya yang dapat membantu memutihkan gigi, serta membantu memperkuat enamel dan mencegah gigi berlubang.\r\n Dengan rasa apple mint yang unik dan menyegarkan.'),
('PR111', 'Natural Toothpaste Whitening + Cavity Protection', 'CLICK', 45000.00, 'CT008', 'upload/product/TREYT6547.png', 'Click Natural Toothpaste Whitening + Cavity Protection diformulasikan secara khusus dengan kandungan natural himalayan pink salt sebagai bahan aktif alami serta bahan aktif unggulan lainnya yang dapat membantu memutihkan gigi, serta membantu mencegah gigi berlubang.\r\nDengan rasa blackberry mint yang unik dan menyegarkan.'),
('PR112', 'Natural Toothpaste Whitening + Gum Health Protection', 'CLICK', 45000.00, 'CT008', 'upload/product/ERRWTE6546.png', 'Click Natural Toothpaste Whitening + Gum Health Protection diformulasikan secara khusus dengan kandungan natural himalayan pink salt sebagai bahan aktif alami serta bahan aktif unggulan lainnya yang dapat membantu memutihkan gigi, serta membantu memberikan perlindungan ekstra untuk menjaga kesehatan gigi dan gusi.\r\nDengan rasa strawberry mint yang unik dan menyegarkan.'),
('PR113', 'Natural Toothpaste Whitening + Bacteria Fighter', 'CLICK', 45000.00, 'CT008', 'upload/product/SERWER4Q412.png', 'Click Natural Toothpaste Whitening + Bacteria Fighter diformulasikan secara khusus dengan kandungan natural himalayan pink salt sebagai bahan aktif alami serta bahan aktif unggulan lainnya yang dapat membantu memutihkan gigi serta membantu melawan bakteri penyebab masalah mulut seperti bau mulut hingga gigi berlubang.\r\nDengan rasa passion fruit yang unik dan menyegarkan.'),
('PR114', 'Natural Toothpaste Whitening + All Out Protection (Citrus Mint)', 'CLICK', 45000.00, 'CT008', 'upload/product/SDRFWSD32423.png', 'Click Natural Toothpaste Whitening + All Out Protection diformulasikan secara khusus dengan kandungan natural himalayan pink salt sebagai bahan aktif alami serta bahan aktif unggulan lainnya yang dapat memberi proteksi total untuk gigi dan gusi, seperti membantu memutihkan gigi, mencegah gigi berlubang, mencegah bau mulut, serta merawat kesehatan gusi.\r\nDengan rasa citrus mint yang unik dan menyegarkan.'),
('PR115', 'Natural Toothpaste Whitening + All Out Protection (Peach Mint)', 'CLICK', 45000.00, 'CT008', 'upload/product/FGDFDG54345.png', 'Click Natural Toothpaste Whitening + All Out Protection diformulasikan secara khusus dengan kandungan natural himalayan pink salt sebagai bahan aktif alami serta bahan aktif unggulan lainnya yang dapat memberi proteksi total untuk gigi dan gusi, seperti membantu memutihkan gigi, mencegah gigi berlubang, mencegah bau mulut, serta merawat kesehatan gusi.\r\nDengan rasa peach mint yang unik dan menyegarkan.'),
('PR116', 'Natural Toothpaste Whitening + Fresh Breath', 'CLICK', 45000.00, 'CT008', 'upload/product/FSDSFD4323.png', 'Click Natural Toothpaste Whitening + Fresh Breath diformulasikan secara khusus dengan kandungan natural himalayan pink salt sebagai bahan aktif alami serta bahan aktif unggulan lainnya yang dapat membantu memutihkan gigi, serta membantu mengurangi bau mulut dan memberikan kesegaran ekstra untuk nafas.\r\nDengan rasa barleymint yang unik dan menyegarkan.'),
('PR117', 'HAMIGAKI NADESHIKO Baking Soda Fresh Mouthwash', 'Keana Nadeshiko', 259000.00, 'CT008', 'upload/product/FSRRFTET3545.png', 'Mouthwash (obat kumur) dengan kandungan Baking Soda dan Tea leaf extract membantu melawan bakteri penyebab bau mulut dan memberikan nafas yang segar.\r\n\r\nApproximately 99% naturally-derived ingredients.\r\n\r\nDirekomendasikan untuk yang mengurangi bau mulut meskipun telah menyikat gigi.'),
('PR118', 'Peach Teeth Brightening Powder 30G', 'Breylee', 39000.00, 'CT008', 'upload/product/fsdfds3434.png', 'Breylee Teeth whitening powder merupakan powder yang berguna untuk membuat gigi tampak putih serta membersihkan gigi.\r\n\r\nMembuat senyum lebih indah, mencerahkan dan memutihkan gigi sekaligus melindungi gusi dan email dan menjaga mulut dengan nafas yang segar. Mudah, nyaman digunakan. Ujung sikat lembut melapisi permukaan gigi secara merata. Pemutihan gigi, menghilangkan noda gigi dan memperbaiki gigi kuning, merawat gusi dan menyegarkan napas, Tidak sakit, aman, menyehatkan, dan cepat memutihkan gigi.'),
('PR119', 'Lime Teeth Brightening Powder 30G', 'Breylee', 45000.00, 'CT008', 'upload/product/dgrdgr534354.png', 'Breylee Teeth whitening powder merupakan powder yang berguna untuk membuat gigi tampak putih serta membersihkan gigi. Cara penggunaan tuangkan powder pada sikat gigi secukupnya lalu gosok gigi seperti biasa kemudian bilas dengan air.'),
('PR120', 'Scentsation Eau De Toilette', 'Wardah', 60000.00, 'CT005', 'upload/product/pf2.png', 'EDT terbaru dari Wardah dengan formula baru dan free alcohol. Diformulasikan dengan aroma natural tanpa pewarna sehingga tidak menimbulkan noda pada bagian tubuh maupun baju.'),
('PR121', 'Eau De Toilette', 'Mineral Botanica', 85000.00, 'CT005', 'upload/product/pf3.jpg', 'Mineral Botanica Eau De Toilette membuat anda merasa segar sepanjang hari, EDT kami memiliki wangi yang tahan lama, terdiri dari berbagai macam rangkaian rempah, bunga dan buah-buahan.\r\n\r\nBahan-bahan: Alcohol, Aqua, Fragrance, PEG-40 Hydrogenated Castor Oil, Hexamethylindanopyran, DMDM Hydantoin.\r\n\r\n*Alcohol yang digunakan bukan dari Industri minuman keras (Khamr) dan sudah disetujui LPPOM MUI, sehingga produk kami bisa disertifikasi halal.'),
('PR122', 'Cascavel - Extrait De Parfum', 'Saff & Co', 249000.00, 'CT005', 'upload/product/pf4.png', 'Sweet & Aromatic | Sexy & Intriguing\r\n\r\nKami bertujuan untuk memberikan pengalaman penciuman yang luar biasa bagi semua orang yang ingin menemukan aroma khas mereka sendiri.'),
('PR123', 'Bilbao Eau De Perfume', 'Buttonscarves Beauty', 675000.00, 'CT005', 'upload/product/pf5.png', 'Imagine the sophistication of swilling a cup of coffee from the comfort of a worn armchair. That’s the feeling this scent evokes. The feel-good scent that you feel a personal connection to. It could really be anything that makes you feel chic and a little bit more polished. It feels light and floral and soft and voluptuous at the same time.\r\n\r\nImpression: Elegant, Classic, Simple\r\nThe Notes:\r\nTop: Perm Ambrette, Calone\r\nMiddle: Jasmine, Ylang, Narcissus, Maltol\r\nDry-down: Patchouly, Vetyver, Soft Amber'),
('PR124', 'Clean EDT 5ml', 'Careso', 48000.00, 'CT005', 'upload/product/pf6.png', 'Ketika anda lebih suka menggoda daripada berkomitmen. Travel Size 5 ml ini adalah pilihan yang tepat. Aroma unisex ini memiliki kesegaran lapang yang menyerupai mawar yang lembut. jika kesegaran, kebersihan dan kenyaman adalah hal yang kamu sukai, maka ini adalah parfum yang cocok sekali.\r\n\r\n– Halal\r\n– Cruelty Free\r\n-Vegan\r\n– Long Lasting Fragrance\r\n– BPOM Certified'),
('PR125', 'Cairo Eau De Perfume', 'Buttonscarves Beauty', 675000.00, 'CT005', 'upload/product/pf8.png', 'Wangi yang lebih hangat dengan sentuhan rempah yang menonjol memberikan sensasi misterius. Sebuah perpaduan yang unik yang memberikan impresi lebih bernuansa. Memberikan pengalaman baru di penciuman anda dengan esensi pedas dari pink peppercorn dipadukan dengan wangi bunga bunga magnolia dan sentuhan kesegaran angin di laut.\r\n\r\nImpressions: Bold, Elegant, and Mysterious (Berani, Elegan, Misterius)\r\nThe Notes:\r\nTop: Pink Peppercorn, Marine, Magnolia\r\nMiddle: Rose, Jasmine/white florals\r\nDry-down: Patchouli, vanilla, musk'),
('PR126', 'Essence of The Sun', 'Hmns', 369000.00, 'CT005', 'upload/product/pf9.png', 'EoS dibuka dengan top notes all natural bergamot, coriander seeds, pink pepper. Masuk ke middle notes dari perpaduan bunga tropis: Indian Jasmine Sambac (natural), Turkish Rose (natural), Tiare Flower, dan solar accord. Notes vanilla, absolute tonka bean (natural), ambrette, dan cedarwood pada base memberikan kesan creamy dan warm yang tahan lama.  Longevity: 7 hours Sillage: Moderate to heavy Projection: 2 meters Type: EDP Fragrance Group: Oriental Floral '),
('PR127', 'Easy Life', 'Mother Of Pearl', 390000.00, 'CT005', 'upload/product/pf10.png', 'Inspired by the ambiance at the sea, splashing waves arouse smells SulfurMaking Algae. Mother of Pearl Easy Life is a versatile soft fragrance that tells a story, very romantic and joyful because in the middle notes it contains Bulgarian rose and marine combination. The fragrance that everyone in the whole world needs right now. '),
('PR128', '02 Pink Laundry Eau De Parfum', 'Alchemist Fragrance', 229000.00, 'CT005', 'upload/product/pf11.png', 'Pink Laundry is weightless yet carries a lot of character. After some time, you will be greeted with a blend of airy florals and aldehyde that will remind you of your favorite clean scent that feels luxurious and cozy at the same time. Pink Laundry is heavenly feminine, welcoming, with just a touch of otherworldly charm.'),
('PR129', 'Atlantis', 'Fordive', 249000.00, 'CT005', 'upload/product/pf12.png', 'Fordive Atlantis adalah parfum yang menyegarkan dan menawan yang cocok bagi mereka yang ingin membuat kesan yang alami, segar, dan menawan. Rasakan keharuman dari laut yang menyegarkan dan manis dari not-not dasar ini dan jelajahi dunia dengan aroma yang menyenangkan!\r\n\r\n- Top Notes : Grapefruit, Black Currant, Sea Salt\r\n\r\n- Middle Notes : Lily of the Valley, Pine, Jasmine\r\n\r\n- Base Notes : Amber, Praline Type : EDP (eau de parfum)\r\n\r\nLongevity: 6-8 jam di kulit\r\n\r\nSillage & Projection = Moderate\r\n\r\nCharacter : Fresh, Woody, Luxury\r\n\r\nOccasion : Daily'),
('PR130', 'The Perfection', 'Hmns', 398000.00, 'CT005', 'upload/product/pf13.png', 'Unlock a new level of perfection with HMNS Perfection, designed to accompany you on your journey towards your ideal self. Embrace the possibilities of life while elevating your senses with its luxurious and clean scent.\r\n\r\nThe Perfection EDP is a perfume designed to help you achieve your full potential. Its character remains unique thanks to its secret composition. Developed by HMNS and Christian Sugiono, this spicy-fougere fragrance offers a luxurious and clean sensation that is perfect for any important event or as your signature scent.'),
('PR131', 'Unrosed', 'Hmns', 374000.00, 'CT005', 'upload/product/pf14.png', 'A creation made with a technique known as Soliflore. An art of constructing the smell of a single flower, but not from the flower itself. Extracted from the indigenous plant of Indonesia called Palmarosa and other blends to complete the beauty of roses. So that you can smell like your favourite scent of rose, differently. Unrosed spreads the sensuality of a floral accent. Balanced with the extremely grounding Earthy scent & enhanced with the musky notes to unfurl a noble trail.\r\n\r\nType: Gen XX (Feminine)\r\nSize: 100 ml\r\nLongevity: 5 - 7 hours\r\nSillage: Medium\r\nProjection: 1 - 1.5 meters'),
('PR132', 'Sweet Pea Fragrance Mist', 'Beauty Secrets', 200000.00, 'CT005', 'upload/product/pf15.png', 'Fragrance mist ini mampu memberikan wangi yang manis dan menyegarkan pada tubuh Anda. Cocok untuk digunakan sehari-hari.Rasakan kemewahan wewangian, campuran formula yang menyegarkan dari Sweet Pea, Watery Pear, Logan Berry, Rhubarb Cyclamen, Freesia, dan Raspberry Musk. Semprotkan untuk sentuhan aroma yang seksi.'),
('PR133', 'Project 1945 Waters of Maluku Perfume | EDP Parfum Unisex', 'Project 1945', 295000.00, 'CT005', 'upload/product/pf16.png', 'WATERS OF MALUKU EDP\r\nBPOM: NA18220603248\r\nTerinspirasi dari elok bahari Maluku, diawali dengan segar teduh padu wangi Green Tea & Grapefruit beriringan dengan lembut heningnya Cinnamon, Lotus & Peony ditutup dengan hangatnya Clove, Incense & Musk.\r\n\r\nSemua merangkum nuansa kepulauan eksotis yang dipeluk pantai-pantai nan indah dan melahirkan budaya serta spirit bahu membahu.\r\n\r\n\r\nTipe: Eau De Parfum (EDP)\r\n\r\nWoody, White Floral, Spicy, Amber\r\n\r\nParfum Notes\r\nTop: Grapefruit, Carrot, Green Tea\r\nMid: Lotus, Peony, Cinnamon\r\nBase: Clove, Cistus, Incense, Musk'),
('PR134', 'Green Tea Teeth Brightening Powder 30G', 'Breylee', 45000.00, 'CT008', 'upload/product/fsdhjshjb56474r367t.png', 'Breylee Teeth whitening powder merupakan powder yang berguna untuk membuat gigi tampak putih serta membersihkan gigi. Cara penggunaan tuangkan powder pada sikat gigi secukupnya lalu gosok gigi seperti biasa kemudian bilas dengan air.'),
('PR135', 'Blank Space Eau De Parfum', 'Jarte Beauty', 225000.00, 'CT005', 'upload/product/pf17.png', 'This scent would bring you to another world of delicacy. Starting off with a more citrusy orange blossom which then goes to the back along with shy jasmine and undetectable tuberose. Beyond the freshness of the scent, you\'ll also get treated to vanilla as the sweetener of the parfume that would slowly make everyone turn heads on you.\r\n\r\nFragrance notes\r\n\r\nTop : Mandarin, Blackcurrant, Orange Blossom\r\n\r\nMiddle : Pear, Tuberose, Jasmine\r\n\r\nBase : Musk, Ceddarwood, Vanilla\r\n\r\nFragrance Oil From France\r\n\r\nLongetivity 6-8 hours'),
('PR136', 'Ethereal', 'Mine.', 390000.00, 'CT005', 'upload/product/pf18.png', 'Ethereal mempunyai wangi bagaikan langit yg cerah, aroma clean seperti wangi bayi, campuran dari almond, bergamot, vanilla. Wangi yang lembut dan sangat innocent dan memorable. Cocok untuk kamu yang penasaran dengan wangi vanilla yang tidak terlalu manis (almost powdery), karena kandungan vanilla fragrance ini adalah natural aphrodisiac yang membuat orang-orang jadi ingin lebih menempel ke kamu.'),
('PR137', 'Darker Shade of Orgsm', 'Hmns', 380000.00, 'CT005', 'upload/product/pf19.png', 'Darker Shade of Orgsm is the more smoky version of HMNS Orgsm. With its captivating blend of top notes such as Orange Blossom, Apple, and Pepper, this scent is sure to invigorate your senses. The heart of the fragrance is composed of rich and warm middle notes of Cypriol, Caramel, and Patchouli, creating a sensuous and alluring aroma. The base notes of Vanilla Beans, Cedarwood, Amber, and Vetiver add a touch of elegance and sophistication, rounded out this exquisite fragrance. Its smoky and mysterious character makes it a unique and unforgettable fragrance, perfect for those who want to stand out from the crowd.\r\n\r\nLongevity        : 5 - 6 hours\r\nSillage             : medium\r\nProjection        : 1.5 meter'),
('PR138', 'Loss of Innocence Extrait De Parfum', 'Lilith And Eve', 217800.00, 'CT005', 'upload/product/pf20.png', 'Parfum Loss of Innocence ini masuk ke dalam kategori Extrait De Parfum. Extrait de parfum adalah bentuk parfum yang paling murni dari segala jenis wewangian. Jenis parfum ini secara general memiliki konsentrasi wewangian tertinggi yaitu sekitar 20 hingga 30 persen, dan wanginya akan bertahan sampai dengan 8 jam.\r\n\r\n\r\n\r\nTop Notes: Blackberry, Neroli, Tangerine and Strawberry\r\n\r\nHeart Notes: Tuberose, Orange Blossom dan Jasmine\r\n\r\nBase Notes: Vanilla Patchouli'),
('PR139', 'Solaris - Extrait De Parfum Mini Size', 'Saff & Co', 89000.00, 'CT005', 'upload/product/pf21.png', 'A seductive vapor that captures your wildest dreams. Blending the warmth of exotic amber, ethereal Haitian Vetiver and the mystery of sunset in its rich spicy notes, Solaris ignites the fire that lives within you. Bold with a dark twist, Solaris is intensely alluring and irresistibly addictive. Solaris teaches you the ways of the sun, it does not resist, it simply shines. Now, embrace Solaris’ flames.'),
('PR140', 'Teeth Whitening Pen', 'Breylee', 45000.00, 'CT008', 'upload/product/4tertrte425.png', 'Membuat senyum lebih indah, mencerahkan gigi sekaligus melindungi gusi dan email dan menjaga mulut dengan nafas yang segar. Mudah, nyaman digunakan. Ujung sikat lembut melapisi permukaan gigi secara merata. Membantu merawat warna putih alami gigi, mengurangi noda pada gigi , merawat gusi dan menyegarkan nafas, Tidak sakit, aman, menyehatkan, dan Mengembalikan warna putih alami gigi.\r\n\r\nHanya untuk penggunaan luar. Jika ada ketidaknyamanan terjadi, hentikan penggunaan segera, jauhkan dari jangkauan anak-anak.\r\n\r\n1. Jangan gunakan produk ini jika menderita tukak gigi, gusi pecah, atau setelah operasi mulut.\r\n\r\n2. Pengguna dengan gigi sensitif harus mengurangi waktu aplikasi atau menggunanakannya dibawah bimbingan dokter gigi.\r\n\r\n3. Tidak untuk orang dibawah usia 16 tahun dan wanita hamil.\r\n\r\n4. Hentikan penggunaan jika merasa tidak enak badan.'),
('PR141', 'Teeth Whitening Powder', 'Breylee', 45000.00, 'CT008', 'upload/product/ter4334.png', 'Membuat senyum lebih indah, mencerahkan dan memutihkan gigi sekaligus melindungi gusi dan email dan menjaga mulut dengan nafas yang segar. Mudah, nyaman digunakan. Ujung sikat lembut melapisi permukaan gigi secara merata. Pemutihan gigi, menghilangkan noda gigi dan memperbaiki gigi kuning, merawat gusi dan menyegarkan nafas, Tidak sakit, aman, menyehatkan, dan cepat memutihkan gigi.'),
('PR142', 'Flora\'s Whisper Body Perfume', 'Lavojoy', 89000.00, 'CT005', 'upload/product/pf22.png', 'A refreshing and uplifting mist with floral scent. Spray the mist all over your skin and take a moment to enjoy the fragrance.\r\n\r\nHighlights:\r\n1. Premium fragrance\r\n2. Gentle on the skin\r\n3. Sweat defender/Sweat-repelling formula'),
('PR143', 'Freezing Mint Teeth Brightening Powder 30G', 'Breylee', 45000.00, 'CT008', 'upload/product/errt34535.png', 'Breylee Teeth whitening powder merupakan powder yang berguna untuk membuat gigi tampak putih serta membersihkan gigi. Cara penggunaan tuangkan powder pada sikat gigi secukupnya lalu gosok gigi seperti biasa kemudian bilas dengan air.'),
('PR144', 'Date Night extrait de Perfume', 'Kitschy', 298000.00, 'CT005', 'upload/product/pf23.png', 'Kitschy Feels Date Night Extrait de Parfum.\r\n\r\nApa itu\r\nParfume yang menonjolkan perasaan cinta Anda dengan perpaduan menawan antara Bulgarian Rose dan Fresh Mint. -\r\n\r\nApa yang membuatnya istimewa (apa yang kami sukai)\r\nPowderry, tapi sekaligus segar.\r\nWewangian yang memberi Anda pengalaman sepanjang hari, dirancang untuk mengering dengan mulus.\r\nBaunya seperti cinta baru: segar—namun sangat memesona, meninggalkan jejak rasa ingin tahu.\r\n\r\nKey Notes: Bulgarian Rose & Mint\r\n\r\nTop Notes: Calabrian Bergamot, California Orange, Mint\r\nMiddle Notes: Magnolia, Grasse Rose, Violet\r\nBase Notes: Musk, Cedar, Bulgarian Rose'),
('PR145', 'Cielo Eau De Parfum 50 ml', 'Satellite Of Grow', 209000.00, 'CT005', 'upload/product/pf24.png', 'Cielo Eau De Parfum 50 ml merupakan parfum yang diformulasikan untuk mengharumkan badan dengan wangi fresh citrusy. Sehingga membuat aroma badan lebih segar.\r\n\r\nTop Notes      : Lavender, Mandarin, Orange, Bergamot\r\n\r\nMiddle notes  : Orange Blossom, Jasmine, Sambac, Orchid\r\n\r\nBottom notes : Madagascar Vanilla, Tonka Bean, Ambergis, Vetiver'),
('PR146', 'Daisy Eau De Parfum', 'Lilith And Eve', 85800.00, 'CT005', 'upload/product/pf25.png', 'Parfum yang memiliki wewangian yang terinspirasi dari parfum branded/high end Marc Jacobs Daisy ini masuk ke dalam kategori Eau De Parfum. Eau De Parfum secara general memiliki konsentrasi parfum antara 15% sampai 20%. Rata-rata, wangi Eau De Parfum akan bertahan selama kurang lebih 4 - 5 jam.\r\n\r\n\r\n\r\nTop Notes: Strawberry, Violet Leaf dan Ruby Red Grapefruit\r\n\r\nHeart Notes: Gardenia, Violet Petals dan Jasmine\r\n\r\nBase Notes: Musk, White Woods dan Vanilla'),
('PR147', 'Applicator Tampon Regular', 'Natracare', 131535.00, 'CT006', 'upload/product/s1.png', 'NATRACARE Organic Cotton Regular Tampons with Applicator 16s\r\n\r\n-100% organic cotton  tampon\r\n- isi 16 pcs tampon organik dan applicatornya\r\n- Panjang tampon 6cm, Absorbency: 6-9g\r\n- Memiliki daya serap yang lebih banyak\r\n- Menjaga permukaan tetap kering\r\n- Pembalut ini ramah lingkungan, tanpa bahan kimia dan dibuat dari bahan-bahan organic\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Cocok untuk wanita yang beraktifitas tinggi\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR148', 'Ultra EXTRA Pads Long', 'Natracare', 106116.00, 'CT006', 'upload/product/s2.png', 'NATRACARE Ultra Extra Pads Wings Long 8s\r\n\r\n- Panjang pads 31,5cm, 8 pcs pads\r\n- Pembalut 100% bahan organic\r\n- Pembalut ini ramah lingkungan, tanpa bahan kimia\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR149', 'Maxi Pads Non Wings Reguler 14s', 'Natracare', 99345.00, 'CT006', 'upload/product/s3.png', 'NATRACARE Maxi Pads Non Wings Reguler 14s\r\n\r\n- Panjang pads 27cm, 14 pcs pads\r\n- Pembalut tanpa sayap\r\n- Pembalut 100% bahan organic\r\n- Pembalut ini ramah lingkungan, tanpa bahan kimia\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR150', 'Maxi Pads Non Wings Super 12s', 'Natracare', 100455.00, 'CT006', 'upload/product/s4.png', 'NATRACARE Maxi Pads Non Wings Super 12s\r\n\r\n- Panjang pads 27cm, 12 pcs pads\r\n- Pembalut tanpa sayap\r\n- Pembalut 100% bahan organic\r\n- Pembalut ini ramah lingkungan, tanpa bahan kimia\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR151', 'Applicator Tampons Extra/ Super', 'Natracare', 137085.00, 'CT006', 'upload/product/s5.png', 'NATRACARE Applicator Cotton Tampon Super 16s:\r\n\r\n-100% organic cotton  tampon\r\n- isi 16 pcs tampon organik dan applicatornya\r\n- Panjang tampon 6cm, Absorbency: 9-12g\r\n- Memiliki daya serap yang lebih banyak dibandingkan tampon regular\r\n- Menjaga permukaan tetap kering\r\n- Pembalut ini ramah lingkungan, tanpa bahan kimia dan dibuat dari bahan-bahan organic\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Cocok untuk wanita yang beraktifitas tinggi\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR152', 'Digital Tampons Super 10', 'Natracare', 83028.00, 'CT006', 'upload/product/s6.png', 'NATRACARE Digital/Non Applicator Cotton Super Tampon 10s:\r\n\r\n-100% organic cotton  tampon\r\n- isi 10 pcs tampon organik\r\n- Panjang tampon 6cm, Absorbency: 9-12g\r\n- Memiliki daya serap yang lebih banyak dibandingkan tampon regular\r\n- Menjaga permukaan tetap kering\r\n- Pembalut ini ramah lingkungan, tanpa bahan kimia dan dibuat dari bahan-bahan organic\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Cocok untuk wanita yang beraktifitas tinggi\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR153', 'Ultra Pads Super with Wings', 'Natracare', 106116.00, 'CT006', 'upload/product/s7.png', 'NATRACARE Ultra Pads Wings Super 12s\r\n\r\n- Panjang pads 25,8cm, 12 pcs pads\r\n- Pembalut 100% bahan organic\r\n- Pembalut ini ramah lingkungan, tanpa bahan kimia\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR154', 'Maternity Pads NON Wings 10s', 'Natracare', 106005.00, 'CT006', 'upload/product/s8.png', 'NATRACARE Maternity Pads Non Wings 10s\r\n\r\nNatracare Maternity Pads sangat ideal untuk kenyamanan dan keamanan total pada hari-hari setelah melahirkan ketika kulit halus perlu dilindungi dari bahan sintetis yang mengiritasi. Maternity Pads yang ekstra lembut, ekstra-panjang, dan bernapas ini dibuat menggunakan kapas organik yang lembut dan bahan-bahan alami yang diambil dengan hati-hati yang lembut pada kulit Anda dan lingkungan. Mereka direkomendasikan dan dicintai oleh bidan dan ibu.\r\n\r\nDeskripsi Produk :\r\n- Size Super 42cm, 10 pcs\r\n- Pembalut 100% bahan organic\r\n- Didesain slim, sehingga aman digunakan\r\n- Pembalut ini ramah lingkungan, tanpa bahan kimia\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR155', 'Panty liner Normal Wrapped', 'Natracare', 85470.00, 'CT006', 'upload/product/s9.png', 'NATRACARE Panty Liners Normal 18s\r\n- Panjang 15cm, 18 pcs\r\n- Panty liner 100% bahan organic\r\n- Panty liner ini ramah lingkungan, tanpa bahan kimia\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR156', 'Panty liner Long Wrapped', 'Natracare', 85470.00, 'CT006', 'upload/product/s10.png', 'NATRACARE Panty Liners Long 16s\r\n- Panjang 17,5cm, 16 pcs\r\n- Panty liner 100% bahan organic\r\n- Panty liner ini ramah lingkungan, tanpa bahan kimia\r\n- Tidak mengandung pemutih klorin dan bebas dari plastik rayon\r\n- Sangat dianjurkan bagi para wanita dengan kulit sensitif\r\n- Made in UK - Inggris'),
('PR157', 'Day Pads', 'Yoona', 34800.00, 'CT006', 'upload/product/s11.png', 'Pembalut sekali pakai dengan teknologi Anion Strip with nano silver. Desain tipis, aman dan nyaman untuk digunakan di siang hari saat beraktivitas. Terbuat dari 100% katun organik dengan daya serap super yang dapat mencegah bocor dan mengunci cairan sehingga permukaan tetap kering dan nyaman. Material ramah lingkungan generasi terbaru.\r\n— Suitable for light to medium flow / day use\r\n\r\nDetails\r\nLapisan atas dan inti terbuat dari 100% katun organik\r\nTeknologi Anion Strip with nano silver yang dapat menghilangkan bakteri dan jamur penyebab infeksi, iritasi dan bau\r\nDesain pembalut yang ideal, pas dan nyaman saat digunakan\r\nTepi pembalut lembut dan fleksibel, anti lecet\r\nPerekat berbahan dasar foodgrade yang aman bagi kesehatan dan anti geser\r\nHipoalergenik\r\n\r\nIzin dan Sertifikasi\r\nKEMENKES RI AKL 11104220023'),
('PR158', 'Night Pads', 'Yoona', 34800.00, 'CT006', 'upload/product/s12.png', 'Pembalut sekali pakai yang dilengkapi dengan double wings dan pelindung belakang yang lebih lebar. Mencegah bocor, cocok digunakan saat sedang heavy flow bahkan malam hari.\r\nTerbuat dari 100% katun organik dan material ramah lingkungan generasi terbaru. Dengan teknologi Anion Strip with nano silver serta lapisan daya serap super yang dapat mencegah bocor dan mengunci cairan sehingga permukaan tetap kering dan nyaman.\r\n— Suitable for heavy flow / overnight use\r\n\r\nDetails\r\nLapisan atas dan inti terbuat dari 100% katun organik\r\nTeknologi Anion Strip with nano silver yang dapat menghilangkan bakteri dan jamur penyebab infeksi, iritasi dan bau\r\nDesain pembalut yang ideal, pas dan nyaman saat digunakan\r\nTepi pembalut lembut dan fleksibel, anti lecet\r\nPerekat berbahan dasar foodgrade yang aman bagi kesehatan dan anti geser\r\nHipoalergenik\r\n\r\nIzin dan Sertifikasi\r\nKEMENKES RI AKL 11104220024'),
('PR159', 'Panty Liners', 'Yoona', 29800.00, 'CT006', 'upload/product/s13.png', 'Panty liners sekali pakai yang terbuat dari material ramah lingkungan generasi terbaru. Terbuat dari 100% katun organik, sehingga tetap bersih dan kering sepanjang hari.\r\nDilengkapi dengan teknologi Anion Strip with nano silver serta lapisan daya serap super yang dapat menyerap keputihan, dan mencegah bau tidak sedap.\r\n— Suitable for everyday use\r\n\r\nDetails \r\nLapisan atas dan inti terbuat dari 100% katun organik\r\nTeknologi Anion Strip with nano silver yang dapat menghilangkan bakteri dan jamur penyebab infeksi, iritasi dan bau\r\nDesain pembalut yang ideal, pas dan nyaman saat digunakan\r\nTepi pembalut lembut dan fleksibel, anti lecet\r\nPerekat berbahan dasar foodgrade yang aman bagi kesehatan dan anti geser\r\nHipoalergenik\r\n\r\nIzin dan Sertifikasi\r\nKEMENKES RI AKL 11104220026'),
('PR160', 'Blood 25cm Corn Pad 14s', 'Blood', 49800.00, 'CT006', 'upload/product/s14.png', 'Pembalut yang dibuat dengan 100% lembaran atas jagung, super tipis namun kuat.\r\n\r\nPertama di dunia, pembalut ini memiliki lapisan atas jagung yang secara alami hipoalergenik dan bebas dari bahan kimia keras, membuat kamu tetap nyaman bahkan di area paling sensitif Anda.\r\nDengan daya serap super dari Jepang, dapat mengunci darah dengan cepat dan mencegah kebocoran.\r\nSangat lembut pada kulit sensitif\r\nSuper tipis\r\n3X lebih kering dari kapas\r\nLayer atas yang dapat terurai secara biodegradable & ramah untuk bumi.'),
('PR161', 'Blood 33cm Corn Pad 10s', 'Blood', 49800.00, 'CT006', 'upload/product/s15.png', 'Pembalut yang dibuat dengan 100% lembaran atas jagung, super tipis namun kuat.\r\n\r\nPertama di dunia, pembalut ini memiliki lapisan atas jagung yang secara alami hipoalergenik dan bebas dari bahan kimia keras, membuat kamu tetap nyaman bahkan di area paling sensitif Anda.\r\nDengan daya serap super dari Jepang, dapat mengunci darah dengan cepat dan mencegah kebocoran.\r\nSangat lembut pada kulit sensitif\r\nSuper tipis\r\n3X lebih kering dari kapas\r\nLayer atas yang dapat terurai secara biodegradable & ramah untuk bumi.'),
('PR162', 'Blood 50cm Corn Panty Pad Size', 'Blood', 59800.00, 'CT006', 'upload/product/s16.png', 'Pembalut celana yang dibuat dengan 100% lembaran atas jagung, super tipis namun kuat.\r\n\r\nPertama di dunia, ramah di kulit, pembalut celana kami menggunakan lapisan jagung yang bebas dari bahan kimia,\r\nsehingga aman untuk dipakai sehari-hari.\r\nDengan desain lebar anti kerut yang tetap di tempatnya, pembalut celana ini memberikan perlindungan dan keamanan yang lebih baik sehingga kamu merasa terlindungi khususnya di malam hari.\r\nDesain anti-bunching atau scrunching\r\nSangat lembut pada kulit sensitif\r\nLayer atas yang dapat terurai secara biodegradable & ramah untuk bumi.'),
('PR163', 'Organic & Compostable Regular Pads 24cm (Travel Pack 3pcs)', 'Uma Women', 18900.00, 'CT006', 'upload/product/s17.png', 'Pembalut sekali pakai dengan lapisan kapas 100% organik untuk pemakaian di siang hari.\r\n\r\n- Cocok untuk light to medium flow\r\n- Desain compact yang aman dan nyaman untuk dipakai saat beraktivitas\r\n- Dilengkapi penyerap superabsorbent polymer buatan Jepang yang mampu menampung cairan hingga 60ml\r\n- Panjang pads: 24cm'),
('PR164', 'Intimate Wash', 'Nona Woman', 99200.00, 'CT006', 'upload/product/s18.png', 'Bersihkan dan segarkan area intim kamu secara lembut dengan Nona Intimate Wash. Diformulasikan dengan bahan-bahan alami dan organik untuk menjaga tingkat pH alami area intim kamu sekaligus melindungi dan membersihkannya. Setiap botol berisi 250 ml.\r\nDibuat tanpa bahan kimia keras yang mengiritasi area intim atau mengganggu hormon kamu.\r\nMempertahankan tingkat pH yang seimbang.\r\nMemberikan sifat antiseptik alami.'),
('PR165', 'Organic Pads 28 cm', 'Nona Woman', 47600.00, 'CT006', 'upload/product/s19.png', 'Dibuat dengan lapisan katun organik dan inti yang mudah menyerap untuk membuat kamu tetap kering dan nyaman selama menstruasi. Tersedia dalam ukuran 28,5 cm (panjang) untuk menstruasi yang deras. Setiap kotak berisi 12 pads.\r\nDibuat tanpa bahan kimia keras yang mengiritasi area intim atau mengganggu hormon kamu.\r\nTeknologi anti bocor untuk membuat kamu bebas khawatir sepanjang hari.');
INSERT INTO `product` (`product_id`, `product_name`, `brand`, `price`, `cat_id`, `product_img`, `product_desc`) VALUES
('PR166', 'Organic Pads 24 cm', 'Nona Woman', 44900.00, 'CT006', 'upload/product/s20.png', 'Dibuat dengan lapisan katun organik dan inti yang sangat menyerap untuk membuat kamu tetap kering dan nyaman selama menstruasi. Tersedia dalam ukuran 24.5 cm (panjang) untuk hari-hari dengan menstruasi yang lebih deras. Setiap kotak berisi 12 pads.\r\nDibuat tanpa bahan kimia keras yang mengiritasi area intim atau mengganggu hormon kamu.\r\nTeknologi anti bocor untuk membuat kamu bebas khawatir sepanjang hari.'),
('PR167', 'Intimate Hygiene Spray', 'Nosuku', 59000.00, 'CT006', 'upload/product/s21.png', 'Nosuku Intimate Hygiene Spray mengandung Allantoin, Centella Asiatica,\r\nProbiotic, Manjakani, dan Sirih yang berguna untuk menjaga PH area organ\r\nintim, membersihkan, melembabkan kulit dan juga anti - bacterial. Nosuku\r\nIntimate Hygiene Spray adalah cairan pembersih organ intim yang bisa\r\ndigunakan oleh pria dan wanita.'),
('PR168', 'Precious Skin Thailand Feminine Soft Whipp Cleanser', 'Precious Skin', 120000.00, 'CT006', 'upload/product/s22.png', 'Pembersih Miss V Kelembapan Alami: Ekstrak aloevera membantu menjaga kelembapan alami kulit di sekitar area Miss V, mencegah rasa kering dan ketidaknyamanan Aloe vera memiliki sifat antiinflamasi dan antioksidan, membantu melindungi kulit dari iritasi dan peradangan ringan. Kesejukan dan Kesegaran: Kandungan aloevera memberikan sensasi kesegaran yang menyegarkan saat digunakan, memberikan perasaan kenyamanan sepanjang hari.pH Seimbang: Produk ini dirancang khusus untuk menjaga pH alami daerah intim wanita, yang penting untuk menjaga\r\nkeseimbangan flora bakteri sehat dan mencegah masalah kesehatan.Bebas dari Bahan Berbahaya: Pembersih vagina ini tidak mengandung bahan berbahaya seperti pewangi kuat atau bahan kimia yang dapat mengganggu keseimbangan alami tubuh.'),
('PR169', 'MenstruHeat Menstrual Cramp Relief 1s', 'Blood', 21000.00, 'CT006', 'upload/product/s23.png', 'MenstruHeat merupakan metode terapi panas yang terbukti secara klinis untuk mengendurkan kram otot rahim di perut, sehingga meredakan kram menstruasi. Formulasi eksklusif kami memungkinkan panas dilepaskan dengan cepat dan stabil selama 12 jam, sehingga Anda bisa mendapatkan kenyamanan dan kelegaan sepanjang hari. MenstruHeat sederhana dan sangat nyaman digunakan. MenstruHeat juga didesain ulang agar mudah ditekuk di seluruh perut Anda untuk cakupan yang lebih luas dan kenyamanan maksimal, namun cukup bijaksana untuk digunakan di bawah pakaian Anda. MenstruHeat juga tidak berbau sehingga Anda tidak perlu khawatir semua orang tahu Anda menggunakan tambalan. MenstruHeat menggunakan perekat kelas medis dari Jepang yang memungkinkan pengulangan beberapa kali, sekaligus lembut pada kulit Anda. Memanas dengan cepat untuk bantuan cepat dan efektif untuk meredakan kram perut saat menstruasi. Non-obat tanpa efek samping dan aman untuk kulit. Menghasilkan panas terus menerus yang tahan lama hingga 12 jam. Desain ergonomis agar sesuai dengan perut Anda dengan nyaman. Sangat praktis untuk dibawa kemana pun anda bepergian dan dapat digunakan dibawah pakaian dengan nyaman.'),
('PR170', 'BackHeat Back Pain Relief 1s', 'Blood', 21000.00, 'CT006', 'upload/product/s24.png', 'BackHeat adalah koyo atau kompres penghangat pereda nyeri pinggang yang memiliki kandungan besi, karbon aktif, air dan garam.\r\n\r\nMembantu meredakan nyeri / pegal dengan hangat yang pas.\r\n\r\nDengan bahan perekat dari Jepang bisa dilepas dan direkatkan kembali berkali-kali.\r\n\r\nDesain BackHeat dirancang untuk dapat menekuk sesuai dengan kontur punggung dengan distribusi panas yang diperluas di seluruh sayapnya sehingga memberikan kenyamanan optimal.'),
('PR171', 'NeckHeat Neck & Shoulder Pain Relief 1s', 'Blood', 21000.00, 'CT006', 'upload/product/s25.png', 'Patch penghangat untuk kram saat haid.\r\n- Praktis & panas tahan lama hingga 12 jam.\r\n- Tidak ada obat atau efek samping\r\n- Tidak berbau dan bijaksana\r\n- Nyaman & mudah digunakan\r\n- Lembut di kulit & pas ergonomis'),
('PR172', 'Ultra Light Serum Sunscreen', 'Skintific', 109480.00, 'CT002', 'upload/product/skintificdc8d34b4d1.jpg', 'Tabir surya dengan SPF 50+ PA++++ melindungi kulit dari UVA & UVB. Dilengkapi dengan Vitamin C dan Ferulic Acid sebagai antioksidan terbaik untuk mencegah penuaan dan menghaluskan kulit. Cocok untuk kulit berminyak dan berjerawat.'),
('PR173', '5X Ceramide Soothing Toner', 'Skintific', 128800.00, 'CT002', 'upload/product/72647h0d3ad2b91c-.png', 'Toner yang dapat digunakan sehari-hari untuk menenangkan kulit saat skin barrier sedang terganggu, membantu proses perbaikan skin barrier dan menjaga kulit agar tetap sehat.\r\nMemiliki kandungan 5 jenis Ceramide yang berbeda yang baik untuk menjaga barier kulit, ditambah kandungan probiotik kompleks yang dapat meningkatkan sel mikrobioma kulit untuk mengurangi permasalahan kulit, dan juga kandungan Calendula yang memiliki fungsi anti inflamasi, dan antibakteri sehingga bisa melindungi collagen alami kulit agar kulit terlihat lebih kenyal dan sehat '),
('PR174', 'Acne set', 'Skintific', 455685.00, 'CT002', 'upload/product/skintific603418e43cd9-.png', 'Bundle berisi :\r\n1 pcs 5X Ceramide Low pH Cleanser (80ml)\r\n1 pcs 5X Ceramide Soothing Toner (80ml)        \r\n1 pcs 2% salicylic acid anti acne serum (20ml)\r\n1 pcs 5X Ceramide Barrier Repair Moisturizer gel (30gr)'),
('PR175', 'Mugwort Acne Clay Stick', 'Skintific', 98800.00, 'CT002', 'upload/product/73104df6-9f29-40ac-.png', 'Diformulasikan dengan Mugwort, ingredients yang populer di Korea untuk mengobati jerawat. Dilengkapi dengan Niacinamide, Salicylic Acid, dan juga Centella yang dapat mengontrol produksi minyak, membersihkan pori-pori secara mendalam, membersihkan komedo, dan menenangkan kulit yang sedang meradang. Mudah digunakan dengan bentuk stick, berfokus untuk menenangkan kulit dan meredakan kemerahan, membersihkan pori dan merawat kulit berjerawat, mengontrol minyak dan menjaga skin barrier. Coverage yang baik, dengan 1 usapan dapat menutup satu area pada wajah. Hasil penggunaan bruntusan berkurang, pori-pori mengecil, warna kulit lebih cerah dan merata.'),
('PR176', 'Advanced Snail 92 All in One Cream', 'COSRX', 279650.00, 'CT002', 'upload/product/21005-large_default.jpg', 'COSRX Advanced Snail 92 All in One Cream from Korea is a Moisturizer enriched with 92% of snail mucin to give skin nourishment\r\n\r\nAn all-in-one solution cream that repairs and soothes irritated, sensitized skin after breakouts. A rich gel-type cream absorbs instantly into the skin with a full of nourishment while leaving your skin feeling fresh and comfortable.'),
('PR177', 'Low pH Good Morning Cleanser', 'COSRX', 131750.00, 'CT002', 'upload/product/cf014562.jpg', 'COSRX Low pH Good Morning Cleanser adalah produk asal Korea Selatan yang menggunakan bahan-bahan alami.\r\n\r\nPembersih wajah dengan formula lembut yang bagus digunakan pada pagi dan malam hari. Mampu membersihkan kulit sensitif sekalipun dengan lembut berkat kandungannya yang memiliki kadar acid yang mirip dengan kadar pH kulit. Gel cleanser ini mampu menenangkan, mengeksfoliasi, melembapkan sekaligus membersihkan kulit wajah. Pembersih wajah ini juga mampu mengangkat sel-sel kulit mati dan minyak berlebih yang muncul selama tidur sehingga wajah menjadi bersih dan segar.'),
('PR178', 'Deep Tanning Oil SPF2', 'BANANA BOAT', 139000.00, 'CT004', 'upload/product/58c623c0-9d94-41a8-9457-902277fac4d', 'Cokelat yang bersinar dimulai dengan Banana Boat ™ Deep Tanning Oil: Aroma yang lezat, ekstrak pisang dan wortel yang kaya minyak kelapa membantu kulit terasa lembut. Tanning Oil kami mempromosikan cahaya matahari yang mendalam dengan warna yang bertahan lama.\r\n\r\nCara Pemakaian : Gunakan pada kulit secara sering sesuai yang diinginkan'),
('PR179', 'Skin Relief Moisturizing Lotion', 'AVEENO', 159000.00, 'CT004', 'upload/product/5754391f-a2d2-49e2-920d-a228b818b7d', 'Pelembab yang bekerja secara cepat. Membantu melembabkan, melegakan, dan menenangkan kulit. Direkomendasikan untuk kulit ekstra kering dan sensitive.\r\n\r\nDiformulasikan dengan ACTIVE NATURALS Triple Oat Complex, Oat Oil, dan Shea Butter Alami untuk melindungi kelembapan kulit dan menjaga kulit tetap lembut dan sehat\r\n\r\nLotion yang menenangkan 4 gejala kulit sensitif (seperti kering, gatal karena kekeringan, mengelupas, kasar) dalam 24 jam\r\n\r\nTerbukti secara klinis untuk melembabkan dan menenangkan kulit sejak hari 1 sambil melindunginya dari kekeringan. Mengandung oatmeal yang digiling halus, oat oil, oat essence dan shea butter.'),
('PR180', 'Daily Moisturising Body Wash', 'AVEENO', 159000.00, 'CT004', 'upload/product/e36ccea8-f6d9-44dd-9e6e-ce0542816f8', 'Membersihkan dan melembabkan kulit setelah beraktivitas sehari-hari. Diformulasikan khusus dengan kandungan colloidal oatmeal untuk menjaga kelembaban dan kelembutan kulit.\r\n\r\nDengan colloidal oatmeal yang mampu melembapkan, menyejukkan dan melindungi, menjaga keseimbangan pH kulit serta membersihkan kulit. Skincare AVEENO menjanjikan memberikan kelembapan yang tahan lama agar kulit tetap sehat alami. '),
('PR181', 'Soft Jar', 'NIVEA', 45000.00, 'CT004', 'upload/product/image-0-1604472975577.png', 'NIVEA Soft adalan krim pelembab yang intensif dan efektif untuk digunakan sehari-hari. Formulanya yang ringan dengan Vitamin E dan Jojoba Oil sangat mudah terserap dan menyegarkan. \r\nDetail:\r\n- Efektif dalam memberikan kelembapan kulit wajah dan tubuh\r\n- Ringan, cepat menyerap dan menyegarkan kulit\r\n- Cocok untuk digunakan sehari-hari untuk memenuhi nutrisi kulit'),
('PR182', 'Dry Skin Gel 100ml', 'BIO OIL', 159999.00, 'CT004', 'upload/product/31070-large_default.jpg', 'Bio Oil Gel Kulit Kering berfungsi untuk mengisi kembali lapisan kulit dan melembabkan, serta mengembalikan kulit kering dalam keadaan terhidrasi yang optimal​. Tekstur gel ke minyak yang unik menyerap dengan mudah dan menciptakan lapisan pelindung untuk menahan kelembaban.\r\n\r\n\r\nNon Comedogenic\r\nLembut digunakan untuk kulit sensitive\r\n\r\n\r\nGel dengan komposisi yang baik untuk perawatan kulit kering dibandingkan dengan cream , oil , butter yang memiliki kadar air yang tinggi sehingga air akan menguap apabila diaplikasikan ke kulit.'),
('PR183', 'Coffee & Coconut Scrub Travel Size BAG', 'C KAB & CO', 160000.00, 'CT004', 'upload/product/7840410128-1583836079556.png', 'Body scrub yang terbuat dari biji kopi Arabika dan bahan alami pilihan.\r\n\r\nMembantu mengangkat sel-sel kulit mati, mencerahkan kulit, serta membantu menyamarkan selulit/stretch marks dengan aroma kopi yang segar.\r\n\r\nDiperkaya dengan vit. E organik, sea salt, dan natural essential oil.'),
('PR185', 'Sunblock SPF 30', 'VASELINE', 44000.00, 'CT004', 'upload/product/image-1-1595501513312.png', 'Tubuhmu memproduksi melanin akibat paparan sinar UV yang dapat membuat kulit tampak lebih gelap dan warna kulit tidak merata.\r\nVaseline® Healthy Sunblock melembabkan dan mencegah pembentukan melanin akibat paparan sinar UVA dan UVB dengan perlindungan SPF 30, Broad Spectrum Sunscreen PA++, Yogurt Protein, dan Aloe Vera Extract. Hasilnya adalah sunblock dengan formula water resistant yang tidak lengket di kulit untuk memberikan kelembaban, memperbaiki kulit kering, dan membuatnya lebih sehat terlindungi.'),
('PR187', 'Clothing Care Kit', 'DR SOAP', 214000.00, 'CT004', 'upload/product/49956575725-1595997847088.png', 'Clothing Care Kit Set\r\n1. Fabric Care Wash 500 ml - 1 Pcs\r\n2. Fabric Mist 100 ml - 1 Pcs\r\n\r\n1. Dr soap Fabric Care Wash adalah deterjen pembersih khusus untuk mencuci pakaian. Mengandung bahan surfaktan yang berasal dari tumbuhan, membuat formula ini dapat mengurangi risiko pakaian luntur (anti-luntur) dan warna pakaian menjadi tidak mudah pudar. Wangi dari parfum aromatik Iris Green memberikan nuansa segar setelah kita menggunakannya. Dan secara aman dapat menghilangkan noda darah, bintik-bintik, dan noda membandel. Ramah lingkungan.\r\n2. Semprotan penyegar anti bakteri yang dirancang khusus untuk kain; digunakan untuk menyegarkan, membersihkan, dan melembutkan kain dengan aroma Urban Shee.\r\n'),
('PR188', 'Clothing Care Kit', 'DR SOAP', 214000.00, 'CT004', 'upload/product/49956575725-1595997847088.png', 'Clothing Care Kit Set\r\n1. Fabric Care Wash 500 ml - 1 Pcs\r\n2. Fabric Mist 100 ml - 1 Pcs\r\n\r\n1. Dr soap Fabric Care Wash adalah deterjen pembersih khusus untuk mencuci pakaian. Mengandung bahan surfaktan yang berasal dari tumbuhan, membuat formula ini dapat mengurangi risiko pakaian luntur (anti-luntur) dan warna pakaian menjadi tidak mudah pudar. Wangi dari parfum aromatik Iris Green memberikan nuansa segar setelah kita menggunakannya. Dan secara aman dapat menghilangkan noda darah, bintik-bintik, dan noda membandel. Ramah lingkungan.\r\n2. Semprotan penyegar anti bakteri yang dirancang khusus untuk kain; digunakan untuk menyegarkan, membersihkan, dan melembutkan kain dengan aroma Urban Shee.\r\n'),
('PR189', 'Top to Toe Pack of Two', 'LIKE IM FIVE', 214000.00, 'CT004', 'upload/product/81183121216-1596614098875.png', 'This bundle consists of:\r\n- Like I\'m 5 Top to Toe Foaming Wash (2pcs)'),
('PR194', 'Scarlett Whitening Shower Scrub - Pomegranate', 'SCARLETT WHITENING', 63000.00, 'CT004', 'upload/product/33434-large_default.jpg', 'Dibuat khusus untuk kamu yang ingin mencerahkan kulit tubuh, mengandung Glutathione dan butiran Vitamin E. Dan juga, terdapat butiran scrub yang mampu mengangkat sel kulit mati dan kotoran yang menumpuk di kulit tubuhmu.\r\n\r\nSCARLETT Whitening Shower Scrub Pomegrante di buat khusus untuk kamu yang ingin mencerahkan kulit tubuh, mengandung Glutathione (vitamin pencerah kulit paling cepat di dunia) dan butiran Vitamin E. Juga terdapat butiran scrub yang mampu mengangkat sel kulit mati dan kotoran yang menumpuk di kulit tubuh dan membantu meregenerasi, melembabkan serta mencerahkan kulit tubuh secara lebih maksimal.'),
('PR196', 'Scarlett Whitening Shower Scrub - Cucumber', 'SCARLETT WHITENING', 63000.00, 'CT004', 'upload/product/33440-large_default.jpg', 'Dibuat khusus untuk kamu yang ingin mencerahkan kulit tubuh, mengandung Glutathione (vitamin pencerah kulit paling cepat di dunia) dan butiran Vitamin E. Juga terdapat butiran scrub yang mampu mengangkat sel kulit mati dan kotoran yang menumpuk di kulit tubuhmu.\r\n\r\nAroma --> Fresh (Cucumber, Muguet)\r\n\r\nKandungan :\r\n\r\n✨Gluthatione\r\n\r\n- Mencerahkan dan meratakan warna kulit.\r\n\r\n- Menjaga kelembapan dan kulit.\r\n\r\n- Merawat kulit agar tetap halus, lembut dan tidak kering.\r\n\r\n✨Vitamin E\r\n\r\n- Merawat kekencangan dan elastisitas kulit\r\n\r\n- Membantu menjaga kelembapan kulit\r\n\r\n✨HYDROLIZED COLLAGEN\r\n\r\n- Merawat kekencangan kulit.\r\n\r\n- Meningkatkan kelembapan dan elastisitas kulit.\r\n\r\n- Mencegah kerusakan kulit.');

--
-- Triggers `product`
--
DELIMITER $$
CREATE TRIGGER `id_for_product` BEFORE INSERT ON `product` FOR EACH ROW BEGIN
    DECLARE new_id VARCHAR(5);
    DECLARE prefix VARCHAR(2) DEFAULT 'PR';
    DECLARE number_part INT;

    -- Mengambil nilai ID terakhir dan memisahkan bagian angka
    SELECT IFNULL(MAX(CAST(SUBSTRING(product_id, 3, 3) AS UNSIGNED)), 0) + 1 INTO number_part
    FROM product
    WHERE product_id LIKE CONCAT(prefix, '%');

    -- Membuat ID baru
    SET new_id = CONCAT(prefix, LPAD(number_part, 3, '0'));

    -- Mengatur nilai admin_id baru
    SET NEW.product_id = new_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `store_id` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `open_hours` time NOT NULL COMMENT 'ini salah tipe datanya',
  `close_hours` time NOT NULL,
  `days` varchar(8) NOT NULL,
  `address` longtext NOT NULL,
  `maps_link` longtext NOT NULL,
  `admin_id` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`store_id`, `name`, `open_hours`, `close_hours`, `days`, `address`, `maps_link`, `admin_id`) VALUES
('ST001', 'Kinaras Plaza Ambarrukmo Yogyakarta', '00:10:00', '00:22:00', 'All days', 'Kinaras Plaza Ambarrukmo Lt.1 Laksda Adisucipto No.80, Kec. Depok, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55281', 'https://maps.app.goo.gl/CZDXTHfhZuNVrTYJA	', 'AD001');

--
-- Triggers `store`
--
DELIMITER $$
CREATE TRIGGER `id_for_store` BEFORE INSERT ON `store` FOR EACH ROW BEGIN
    DECLARE new_id VARCHAR(5);
    DECLARE prefix VARCHAR(2) DEFAULT 'ST';
    DECLARE number_part INT;

    -- Mengambil nilai ID terakhir dan memisahkan bagian angka
    SELECT IFNULL(MAX(CAST(SUBSTRING(store_id, 3, 3) AS UNSIGNED)), 0) + 1 INTO number_part
    FROM store
    WHERE store_id LIKE CONCAT(prefix, '%');

    -- Membuat ID baru
    SET new_id = CONCAT(prefix, LPAD(number_part, 3, '0'));

    -- Mengatur nilai ID baru
    SET NEW.store_id = new_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `trans_id` varchar(5) NOT NULL,
  `user_id` varchar(5) NOT NULL,
  `product_id` varchar(5) NOT NULL,
  `trans_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `transaction`
--
DELIMITER $$
CREATE TRIGGER `id_for_trans` BEFORE INSERT ON `transaction` FOR EACH ROW BEGIN
    DECLARE new_id VARCHAR(5);
    DECLARE prefix VARCHAR(2) DEFAULT 'TR';
    DECLARE number_part INT;

    -- Mengambil nilai ID terakhir dan memisahkan bagian angka
    SELECT IFNULL(MAX(CAST(SUBSTRING(trans_id, 3, 3) AS UNSIGNED)), 0) + 1 INTO number_part
    FROM transaction
    WHERE trans_id LIKE CONCAT(prefix, '%');

    -- Membuat ID baru
    SET new_id = CONCAT(prefix, LPAD(number_part, 3, '0'));

    -- Mengatur nilai trans_id baru
    SET NEW.trans_id = new_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` varchar(5) NOT NULL,
  `user_fullname` varchar(255) NOT NULL,
  `user_nickname` varchar(20) NOT NULL,
  `user_pass` varchar(16) NOT NULL,
  `user_nohp` varchar(20) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_address` text NOT NULL,
  `user_img` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_fullname`, `user_nickname`, `user_pass`, `user_nohp`, `user_email`, `user_address`, `user_img`) VALUES
('UR001', 'Eunique Lydia Stephany', 'Puni', 'Pun10', '082250194039', 'elydiastephany@students.amikom.ac.id', 'Jl. Teratai 1 No. 1', 'upload/admin/uni.png'),
('UR002', 'Zefantio', 'zefan', 'tio', '08231613', 'zefantio@kinaras.com', 'JL.purwomartani', 'upload/admin/fan2.jpeg'),
('UR003', 'Guruh Jodi Saputra', 'Jodi', 'jodi123', '0851427462735', 'guruhjodisaputra@gmail.com', 'Jl. Godean', 'upload/admin/jo.png'),
('UR004', 'Eby', 'Eby', 'qwer', '089630070653', 'nggfebry199@gmail.com', '', NULL),
('UR005', 'chanyeol gf', 'pocimochi', 'kucing', '082134226799', '1234@gmail.com', '', NULL),
('UR006', 'joo', 'jyoo', '123joo', '081227467648', 'jo@gmail.com', '', NULL);

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `id_for_user` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    DECLARE new_id VARCHAR(5);
    DECLARE prefix VARCHAR(2) DEFAULT 'UR';
    DECLARE number_part INT;

    -- Mengambil nilai ID terakhir dan memisahkan bagian angka
    SELECT IFNULL(MAX(CAST(SUBSTRING(user_id, 3, 3) AS UNSIGNED)), 0) + 1 INTO number_part
    FROM user
    WHERE user_id LIKE CONCAT(prefix, '%');

    -- Membuat ID baru
    SET new_id = CONCAT(prefix, LPAD(number_part, 3, '0'));

    -- Mengatur nilai user_id baru
    SET NEW.user_id = new_id;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `bag`
--
ALTER TABLE `bag`
  ADD PRIMARY KEY (`bag_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`store_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`trans_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bag`
--
ALTER TABLE `bag`
  ADD CONSTRAINT `bag_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `bag_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`cat_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
