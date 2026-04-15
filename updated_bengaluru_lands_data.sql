-- ============================================================
-- BENGALURU LANDS - COMPLETE DATABASE SETUP
-- Source: MagicBricks Bangalore Property Rates
-- Run this entire file in MySQL Workbench
-- ============================================================

DROP DATABASE IF EXISTS bengaluru_lands;
CREATE DATABASE bengaluru_lands;
USE bengaluru_lands;

-- ============================================================
-- TABLE 1: AREAS
-- ============================================================
CREATE TABLE IF NOT EXISTS areas (
    area_id    INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL UNIQUE,
    zone       VARCHAR(50),
    latitude   DECIMAL(9,6),
    longitude  DECIMAL(9,6)
);

-- ============================================================
-- TABLE 2: PRICE HISTORY
-- ============================================================
CREATE TABLE IF NOT EXISTS price_history (
    history_id       INT AUTO_INCREMENT PRIMARY KEY,
    area_id          INT NOT NULL,
    year             YEAR NOT NULL,
    avg_price_sqft   DECIMAL(10,2) NOT NULL,
    num_transactions INT,
    FOREIGN KEY (area_id) REFERENCES areas(area_id)
);

-- ============================================================
-- TABLE 3: AREA METRICS
-- ============================================================
CREATE TABLE IF NOT EXISTS area_metrics (
    area_id        INT PRIMARY KEY,
    current_price  DECIMAL(10,2),
    growth_1yr     DECIMAL(5,2),
    growth_3yr     DECIMAL(5,2),
    growth_5yr     DECIMAL(5,2),
    avg_roi_pct    DECIMAL(5,2),
    FOREIGN KEY (area_id) REFERENCES areas(area_id)
);

-- ============================================================
-- INSERT AREAS (all areas from MagicBricks, zones assigned)
-- ============================================================
INSERT INTO areas (name, zone, latitude, longitude) VALUES
('1st Block Rajajinagar', 'West', 13.0020, 77.5530),
('Aavalahalli', 'West', 12.9600, 77.5100),
('Adarsh Palm Retreat', 'East', 12.9150, 77.6800),
('AECS Layout Marathahalli', 'East', 12.9550, 77.6950),
('Aga Abbas Ali Road', 'Central', 12.9650, 77.5850),
('Agrahara Layout Main Road', 'North', 13.0450, 77.6100),
('Agrahara Main Road', 'North', 13.0400, 77.6050),
('Akshayanagar', 'South', 12.8800, 77.6300),
('Allalasandra Yelahanka', 'North', 13.1000, 77.5950),
('Ambalipura', 'East', 12.9100, 77.6900),
('Ambalipura Haralur', 'East', 12.9050, 77.6850),
('Ambalipura Sarjapur Road', 'East', 12.9000, 77.6950),
('Amrutahalli', 'North', 13.0700, 77.5500),
('Amruthahalli Main Road', 'North', 13.0650, 77.5450),
('Ananth Nagar', 'West', 12.9800, 77.5150),
('Anekal', 'South', 12.7100, 77.6970),
('Anekal Hosur Road', 'South', 12.7200, 77.6900),
('Anekal Main Road', 'South', 12.7150, 77.6950),
('AnjanaPura', 'South', 12.8500, 77.5900),
('Anjanapura Main Road', 'South', 12.8550, 77.5950),
('Arekere', 'South', 12.8900, 77.6000),
('Armane Nagar', 'Central', 13.0100, 77.5800),
('Ashok Nagar', 'Central', 12.9750, 77.6000),
('Attibele', 'South', 12.7800, 77.6800),
('Attibele Anekal Road', 'South', 12.7750, 77.6850),
('Attur Lake Road', 'North', 13.0900, 77.5950),
('Ayyappa Nagar Main Road', 'North', 13.0800, 77.5900),
('Bagalur Colony', 'North', 13.0600, 77.6600),
('Bagalur Main Road', 'North', 13.0650, 77.6650),
('Bagaluru', 'North', 13.0700, 77.6700),
('Balagere', 'East', 12.9350, 77.7100),
('Balagere Road', 'East', 12.9300, 77.7150),
('Banashankari', 'South', 12.9350, 77.5690),
('Banaswadi', 'East', 13.0050, 77.6550),
('Bangalore Chennai Highway', 'North', 13.1500, 77.6500),
('Bannerghatta Main Road', 'South', 12.8750, 77.5950),
('Bannerughatta', 'South', 12.8650, 77.6000),
('Basapura Main Road', 'South', 12.8700, 77.6150),
('Basapura Village Road', 'South', 12.8650, 77.6200),
('Basavanagudi', 'South', 12.9420, 77.5750),
('Basaveshwar Nagar', 'West', 13.0000, 77.5500),
('Battarahalli', 'East', 13.0100, 77.6800),
('Begur', 'South', 12.8750, 77.6300),
('Begur Hulimavu Road', 'South', 12.8800, 77.6250),
('Begur Koppa Road', 'South', 12.8750, 77.6200),
('Begur Road', 'South', 12.8800, 77.6350),
('Belathur', 'East', 13.0000, 77.7300),
('Belathur Main Road', 'East', 13.0050, 77.7350),
('Bellahalli Main Road', 'North', 13.0600, 77.6200),
('Bellandur', 'East', 12.9300, 77.6800),
('Bellary Road', 'North', 13.0500, 77.5800),
('Bengaluru Kanakapura Road', 'South', 12.8600, 77.5700),
('Bengaluru Main Road', 'South', 12.8400, 77.6700),
('Benson Town', 'Central', 13.0050, 77.5950),
('Bhattarahalli', 'East', 13.0100, 77.6800),
('Bhoganhalli', 'East', 12.9600, 77.6900),
('Bhoopasandra Main Road', 'North', 13.0300, 77.6000),
('Bidarahalli', 'East', 13.0200, 77.7200),
('Bilekahalli', 'South', 12.8900, 77.6100),
('Bileshivale Main Road', 'North', 13.0800, 77.5800),
('Binny Pete', 'Central', 12.9700, 77.5750),
('Block 1st Koramangala', 'South', 12.9350, 77.6300),
('Block 7th Jayanagar', 'South', 12.9250, 77.5900),
('Bommanahalli', 'South', 12.8950, 77.6200),
('Bommasandra', 'South', 12.8100, 77.6700),
('Bommasandra Jigani Link Road', 'South', 12.8050, 77.6600),
('Borewell Road', 'East', 12.9800, 77.7100),
('Brookefield', 'East', 12.9800, 77.7200),
('BTM Layout', 'South', 12.9166, 77.6101),
('Budigere', 'East', 13.0500, 77.7500),
('Budigere Cross', 'East', 13.0550, 77.7550),
('Budigere Road', 'East', 13.0450, 77.7450),
('Byatarayanapura', 'North', 13.0600, 77.5600),
('Cambridge Layout', 'East', 12.9900, 77.6500),
('Cambridge Road', 'East', 12.9850, 77.6450),
('Carmelaram', 'East', 12.9000, 77.7000),
('Chambenahalli', 'East', 13.0600, 77.6900),
('Chandapura', 'South', 12.8200, 77.6800),
('Chandapura Anekal Road', 'South', 12.8150, 77.6900),
('Chandapura Dommasandra Road', 'South', 12.8100, 77.7000),
('Channasandra', 'East', 13.0000, 77.6900),
('Channasandra Main Road', 'East', 12.9950, 77.6950),
('Chellikere', 'North', 13.0350, 77.6200),
('Chikka Thirupati Road', 'East', 12.9700, 77.6800),
('Chikkakannalli', 'East', 12.9200, 77.6700),
('Chokkanahalli', 'North', 13.0550, 77.6100),
('Choodasandra', 'East', 12.9100, 77.6800),
('Chunchgatta Main Road', 'South', 12.8800, 77.6200),
('Church Street', 'Central', 12.9750, 77.6050),
('Coles Road', 'Central', 12.9800, 77.6000),
('Cooke Town', 'Central', 13.0000, 77.6100),
('Cox Town', 'Central', 13.0000, 77.6050),
('Crescent Road', 'Central', 12.9900, 77.5900),
('Cubbon Road', 'Central', 12.9750, 77.5950),
('Cunningham Road', 'Central', 12.9900, 77.5950),
('CV Raman Nagar', 'East', 12.9850, 77.6600),
('Dasarahalli Main Road', 'West', 13.0500, 77.5100),
('Davis Road', 'Central', 12.9600, 77.5950),
('Defence Colony Indiranagar', 'East', 12.9750, 77.6400),
('Devanahalli', 'North', 13.2500, 77.7100),
('Devarabisanahalli', 'East', 12.9600, 77.7200),
('Devasthanagalu', 'West', 12.9500, 77.5000),
('Devinagar', 'North', 13.0450, 77.5800),
('Dickenson Road', 'Central', 12.9700, 77.6000),
('Doddaballapur Main Road', 'North', 13.1500, 77.5400),
('Doddaballapura', 'North', 13.2900, 77.5400),
('Doddaballapura Main Road', 'North', 13.2800, 77.5350),
('Doddagubbi Main Road', 'North', 13.1000, 77.6700),
('Doddakallasandra', 'South', 12.8900, 77.5800),
('Doddakammanahalli Main Road', 'South', 12.9000, 77.6100),
('Doddakannelli', 'East', 12.9200, 77.6800),
('Doddakannelli Chikkanayakana Halli Road', 'East', 12.9150, 77.6850),
('Doddakannelli kaadubeesanahalli Road', 'East', 12.9250, 77.6900),
('Doddanagamangala Road', 'East', 12.8800, 77.7100),
('Doddanekundi', 'East', 12.9700, 77.7000),
('Doddanekundi Main Road', 'East', 12.9650, 77.7050),
('Dollars Colony Stage 2nd RMV', 'North', 13.0200, 77.5750),
('Domlur', 'East', 12.9600, 77.6450),
('Dommasandra', 'East', 12.8900, 77.7100),
('Double Road', 'South', 12.9500, 77.6000),
('Dr Vishnuvardhan Road', 'East', 12.9950, 77.6600),
('ECC Road', 'East', 12.9900, 77.7100),
('Electronic City', 'South', 12.8399, 77.6770),
('EPIP Zone', 'East', 12.9750, 77.7300),
('Gear School Road', 'South', 12.9100, 77.6200),
('Giri Nagar', 'South', 12.9350, 77.5750),
('GM Palya Main Road', 'East', 12.9600, 77.6700),
('Gottigere', 'South', 12.8650, 77.5950),
('Green Glen Layout', 'East', 12.9150, 77.6800),
('Gubbalala', 'South', 12.8700, 77.5700),
('Gubbalala Main Road', 'South', 12.8650, 77.5650),
('Gunjur', 'East', 12.9100, 77.7100),
('Gunjur Balagere Road', 'East', 12.9050, 77.7150),
('Gunjur Doddakannelli Road', 'East', 12.9100, 77.7050),
('Hadosiddapura', 'South', 12.8600, 77.6300),
('HAL', 'East', 12.9600, 77.6650),
('HAL Old Airport Road', 'East', 12.9550, 77.6600),
('Halasuru', 'Central', 12.9800, 77.6150),
('Haralur', 'East', 12.9000, 77.6800),
('Haralur Main Road', 'East', 12.8950, 77.6850),
('Harlur', 'East', 12.9050, 77.6750),
('HBR Layout', 'North', 13.0200, 77.6400),
('Hebbal', 'North', 13.0353, 77.5970),
('Hebbal Kempapura', 'North', 13.0400, 77.5900),
('Hennur Bagalur Main Road', 'North', 13.0600, 77.6500),
('Hennur Bande', 'North', 13.0400, 77.6300),
('Hennur Gardens', 'North', 13.0450, 77.6350),
('Hennur Main Road', 'North', 13.0350, 77.6250),
('Hesarghatta Road', 'North', 13.0800, 77.5200),
('HMT Main Road', 'North', 13.0700, 77.5400),
('Holiday Village Road', 'East', 12.9800, 77.7000),
('Hongasandra', 'South', 12.8800, 77.5800),
('Hoodi', 'East', 12.9900, 77.7100),
('Hoodi Main Road', 'East', 12.9850, 77.7050),
('Horamavu', 'East', 13.0150, 77.6600),
('Horamavu Agara', 'East', 13.0100, 77.6650),
('Horamavu Agara Main Road', 'East', 13.0050, 77.6700),
('Horamavu Agara Road', 'East', 13.0200, 77.6600),
('Horamavu Main Road', 'East', 13.0100, 77.6550),
('Hosa Road', 'East', 12.8800, 77.6900),
('Hosa Road Area', 'East', 12.8750, 77.6950),
('Hosabasavanapura', 'East', 12.9000, 77.7100),
('Hosahalli Main Road', 'West', 12.9700, 77.5050),
('Hosapalya Main Road', 'East', 12.8850, 77.6800),
('Hoskote', 'East', 13.0700, 77.7980),
('Hoskote Chintamani Road', 'East', 13.0750, 77.8050),
('Hoskote Malur Road', 'East', 13.0650, 77.8100),
('Hosur Main Road', 'South', 12.8600, 77.6500),
('Hosur Road', 'South', 12.8900, 77.6400),
('HRBR Layout', 'North', 13.0150, 77.6450),
('HSR Extension', 'South', 12.9100, 77.6350),
('HSR Layout', 'South', 12.9113, 77.6412),
('Hulimangala Road', 'South', 12.8450, 77.6650),
('Hulimavu', 'South', 12.8850, 77.5950),
('Hulimavu Lake Road', 'South', 12.8800, 77.5900),
('Huskur Road', 'East', 12.8650, 77.7000),
('Hutchins Road', 'Central', 12.9850, 77.6100),
('Huvinayakanahalli', 'North', 13.0800, 77.6300),
('Immadihalli', 'East', 12.9700, 77.7100),
('Indiranagar', 'East', 12.9784, 77.6408),
('ITPL', 'East', 12.9856, 77.7272),
('ITPL Main Road', 'East', 12.9800, 77.7200),
('Ittamadu Main Road', 'South', 12.9300, 77.5650),
('Jagajeevanram Nagar', 'West', 12.9750, 77.5050),
('Jakkur', 'North', 13.0650, 77.6000),
('Jakkur Road', 'North', 13.0600, 77.5950),
('Jakkuru Layout', 'North', 13.0700, 77.6050),
('Jalahalli', 'West', 13.0500, 77.5300),
('Jalahalli Cross Road', 'West', 13.0550, 77.5350),
('Jalahalli Road', 'West', 13.0450, 77.5250),
('Jalahalli West', 'West', 13.0500, 77.5150),
('Jambusavari Dinne Main Road', 'South', 12.8700, 77.6100),
('Jayamahal', 'Central', 13.0000, 77.5850),
('Jayamahal Main Road', 'Central', 13.0050, 77.5900),
('Jayanagar', 'South', 12.9300, 77.5830),
('JCR Layout', 'South', 12.9250, 77.5950),
('Jeevan Bima Nagar', 'East', 12.9650, 77.6550),
('Jigani', 'South', 12.7900, 77.6400),
('JP Nagar', 'South', 12.9081, 77.5845),
('Judicial Layout', 'West', 12.9600, 77.5100),
('K Channasandra Main Road', 'East', 12.9950, 77.7100),
('K Narayanapura Main Road', 'North', 13.0500, 77.6300),
('Kadabeesanahalli', 'East', 12.9450, 77.6950),
('Kadubeesanahalli', 'East', 12.9400, 77.6900),
('Kadubeesanahalli Road', 'East', 12.9350, 77.6950),
('Kadugodi', 'East', 13.0100, 77.7400),
('Kaggadasapura', 'East', 12.9900, 77.6700),
('Kaggadasapura Main Road', 'East', 12.9850, 77.6750),
('Kaikondrahalli', 'East', 12.9300, 77.6900),
('Kalena Agrahara', 'South', 12.8750, 77.6200),
('Kalkere Main Road', 'East', 13.0050, 77.7100),
('Kalyan Nagar', 'North', 13.0200, 77.6350),
('Kammanahalli', 'East', 13.0050, 77.6500),
('Kammanahalli Main Road', 'East', 13.0000, 77.6450),
('Kammasandra Electronic City', 'South', 12.8300, 77.6700),
('Kanakapura', 'South', 12.5500, 77.4200),
('Kanakapura Road', 'South', 12.8800, 77.5650),
('Kannamangala', 'East', 13.0400, 77.7300),
('Kannamangala Main Road', 'East', 13.0350, 77.7350),
('Kannuru Road', 'North', 13.0750, 77.6100),
('Kasavanahalli', 'East', 12.9150, 77.6950),
('Kasavanahalli Main Road', 'East', 12.9100, 77.7000),
('Kasturba Road', 'Central', 12.9800, 77.5900),
('Kasturi Nagar', 'East', 13.0100, 77.6500),
('Kathriguppe Main Road', 'South', 12.9350, 77.5700),
('Kempegowda International Airport Road', 'North', 13.1800, 77.6200),
('Kengeri', 'West', 12.9070, 77.4820),
('Kengeri Kommaghatta Road', 'West', 12.9020, 77.4780),
('Kengeri Main Road', 'West', 12.9100, 77.4850),
('Kengeri Satellite Town', 'West', 12.9150, 77.4900),
('Kithaganur Main Road', 'East', 13.0300, 77.7200),
('Kodathi', 'East', 12.8850, 77.7100),
('Kodichikkanahalli Main Road', 'South', 12.8950, 77.6100),
('Kodigehalli', 'North', 13.0500, 77.5900),
('Kodigehalli Main Road', 'North', 13.0450, 77.5850),
('Kodihalli', 'East', 12.9600, 77.6350),
('Kodipalya Road', 'West', 12.9800, 77.5000),
('Kogilu', 'North', 13.0750, 77.6150),
('Kogilu Main Road', 'North', 13.0800, 77.6200),
('Konanakunte', 'South', 12.8850, 77.5750),
('Koppa Road', 'East', 13.0200, 77.7300),
('Koramangala', 'South', 12.9352, 77.6245),
('Kothanur', 'North', 13.0700, 77.5700),
('Krishna Rajendra Road', 'South', 12.9600, 77.5750),
('Krishnarajapura', 'East', 13.0000, 77.6950),
('Kudlu', 'South', 12.8900, 77.6450),
('Kudlu Gate', 'South', 12.8850, 77.6500),
('Kudlu Main Road', 'South', 12.8950, 77.6400),
('Kumaraswamy Layout', 'South', 12.9100, 77.5650),
('Kundalahalli', 'East', 12.9800, 77.7100),
('KV Jairam Road', 'South', 12.9250, 77.5800),
('Lal Bagh Main Road', 'South', 12.9500, 77.5850),
('Langford Road', 'Central', 12.9600, 77.5950),
('Lavelle Road', 'Central', 12.9700, 77.5950),
('Magadi Main Road', 'West', 12.9750, 77.5050),
('Mahadevapura', 'East', 12.9900, 77.7050),
('Mahatma Gandhi Road', 'Central', 12.9750, 77.6050),
('Mallasandra', 'North', 13.0600, 77.5500),
('Malleshpalya Main Road', 'East', 12.9950, 77.6700),
('Malleshwaram', 'West', 13.0020, 77.5640),
('Manayata Tech Park', 'North', 13.0450, 77.6200),
('Manyata Tech Park Road', 'North', 13.0400, 77.6250),
('Marathahalli', 'East', 12.9591, 77.7019),
('Marathahalli Main Road', 'East', 12.9550, 77.7050),
('Marathahalli Sarjapur Outer Ring Road', 'East', 12.9300, 77.6950),
('Mathikere', 'West', 13.0150, 77.5500),
('Mavalli', 'South', 12.9550, 77.5950),
('Medahalli Kadugodi Road', 'East', 13.0050, 77.7350),
('Millers Road', 'Central', 12.9900, 77.5900),
('Mission Road', 'Central', 12.9700, 77.5900),
('MSR College Road', 'North', 13.0450, 77.5550),
('Munnekollal', 'East', 12.9250, 77.6950),
('Murgesh Pallya', 'East', 12.9700, 77.6450),
('Museum Road', 'Central', 12.9750, 77.6000),
('Mysore Road', 'West', 12.9550, 77.5200),
('Naagarabhaavi', 'West', 12.9650, 77.5050),
('Nagarabhavi Main Road', 'West', 12.9700, 77.5000),
('Nagasandra', 'West', 13.0400, 77.5150),
('Nagasandra Main Road', 'West', 13.0350, 77.5100),
('Nagavara', 'North', 13.0500, 77.6300),
('Nallurhalli', 'East', 12.9800, 77.7250),
('Nandi Durga Road', 'North', 13.0100, 77.6000),
('Neeladri Road', 'West', 12.9200, 77.5000),
('New Airport Road', 'North', 13.0700, 77.6050),
('New BEL Road', 'West', 13.0150, 77.5450),
('Nice Ring Road', 'South', 12.9000, 77.5700),
('NRI Layout Main Road', 'East', 12.9900, 77.7150),
('Old Madras Road', 'East', 13.0000, 77.6750),
('Old Mysuru Road', 'West', 12.9400, 77.5250),
('Outer Ring Road', 'East', 12.9500, 77.6900),
('Padmanabhanagar', 'South', 12.9300, 77.5650),
('Pai Layout Mahadevapura', 'East', 12.9950, 77.7000),
('Palace Road', 'Central', 12.9950, 77.5850),
('Panathur', 'East', 12.9350, 77.6900),
('Panathur Main Road', 'East', 12.9300, 77.6950),
('Panduranga Nagar', 'South', 12.8950, 77.5900),
('Parappana Agrahara', 'South', 12.8700, 77.6400),
('Pattandur Agrahara', 'East', 12.9900, 77.7300),
('Peenya', 'West', 13.0300, 77.5200),
('Phase 1 Electronics City', 'South', 12.8500, 77.6700),
('Phase 2 Electronic City', 'South', 12.8450, 77.6750),
('Phase 4 JP Nagar', 'South', 12.9000, 77.5800),
('Phase 5 JP Nagar', 'South', 12.9050, 77.5750),
('Phase 6 JP Nagar', 'South', 12.8950, 77.5850),
('Phase 7 JP Nagar', 'South', 12.9000, 77.5900),
('Phase 8th JP Nagar', 'South', 12.8900, 77.5950),
('Phase 9th JP Nagar', 'South', 12.8850, 77.6000),
('Pragathi Nagar', 'West', 13.0450, 77.5050),
('Prakruthi Nagar Kogilu', 'North', 13.0700, 77.6100),
('Pulikeshi Nagar', 'Central', 12.9900, 77.6100),
('Queens Road', 'Central', 12.9950, 77.5950),
('Rachenahalli', 'North', 13.0550, 77.6300),
('Rachenahalli Main Road', 'North', 13.0500, 77.6350),
('Rajajinagar', 'West', 13.0050, 77.5550),
('Ramamurthi Nagar Main Road', 'East', 13.0050, 77.6600),
('Ramamurthy Nagar', 'East', 13.0100, 77.6650),
('Rayasandra', 'South', 12.8750, 77.6200),
('Rayasandra Main Road', 'South', 12.8700, 77.6250),
('Richards Town', 'Central', 13.0000, 77.6150),
('Richmond Road', 'Central', 12.9650, 77.5980),
('Richmond Town', 'Central', 12.9600, 77.5950),
('RK Hegde Nagar', 'North', 13.0600, 77.6400),
('RMV Extension Stage 2nd RMV', 'North', 13.0100, 77.5850),
('RR Nagar', 'West', 12.9300, 77.5200),
('RT Nagar', 'North', 13.0200, 77.5900),
('Sadashiva Nagar', 'Central', 13.0000, 77.5800),
('Sahakar Nagar', 'North', 13.0500, 77.6000),
('Sai Baba Temple Road', 'North', 13.0600, 77.5950),
('Saint Johns Road', 'Central', 13.0050, 77.6200),
('Sampigehalli Main Road', 'North', 13.0650, 77.6450),
('Sanjay Nagar Main Road', 'North', 13.0300, 77.5900),
('Sanjayanagara', 'West', 13.0100, 77.5600),
('Sankey Road', 'Central', 13.0000, 77.5800),
('Sarjapur Road', 'East', 12.9100, 77.6800),
('Sarjapura', 'East', 12.8700, 77.7800),
('Sarjapura Attibele Road', 'East', 12.8600, 77.7900),
('Sector 1st HSR Layout', 'South', 12.9200, 77.6400),
('Sector 7 HSR Layout', 'South', 12.9150, 77.6450),
('Seegehalli', 'East', 13.0200, 77.7100),
('Seegehalli Main Road', 'East', 13.0150, 77.7150),
('Seegehalli Road', 'East', 13.0250, 77.7050),
('Seshadripuram', 'Central', 13.0000, 77.5750),
('Seshadripuram Main Road', 'Central', 13.0050, 77.5800),
('Shampura Main Road', 'East', 13.0000, 77.6500),
('Shankarnag Road', 'South', 12.9400, 77.5700),
('Shanti Nagar', 'Central', 12.9600, 77.6000),
('Shivaji Nagar', 'Central', 12.9800, 77.6050),
('Silver County Road', 'East', 12.9750, 77.7050),
('Singasandra', 'South', 12.8950, 77.6300),
('Sivanchetti Gardens', 'Central', 12.9750, 77.5900),
('Sompura', 'South', 12.8200, 77.6900),
('Soukya Road', 'East', 13.0350, 77.7400),
('Spencer Road', 'Central', 12.9850, 77.6000),
('Stage 1 BTM Layout', 'South', 12.9200, 77.6150),
('Stage 2 RMV', 'North', 13.0150, 77.5800),
('Stage 2nd Banashankari', 'South', 12.9350, 77.5750),
('Stage 2nd BTM Layout', 'South', 12.9100, 77.6200),
('Stage 3rd Banashankari', 'South', 12.9300, 77.5700),
('Stage 6th Banashankari', 'South', 12.9250, 77.5650),
('Subramanyapura', 'South', 12.9100, 77.5600),
('Subramanyapura Main Road', 'South', 12.9050, 77.5550),
('Talaghattapura', 'South', 12.8600, 77.5650),
('Tavarekere Main Road', 'South', 12.9050, 77.6050),
('Thalagattapura Main Road', 'South', 12.8550, 77.5700),
('Thambu Chetty Palya', 'East', 13.0100, 77.6750),
('Thambu Chetty Palya Main Road', 'East', 13.0150, 77.6800),
('Thanisandra', 'North', 13.0550, 77.6350),
('Thanisandra Main Road', 'North', 13.0500, 77.6400),
('Thimmaiah Road', 'West', 12.9800, 77.5750),
('Thubarahalli', 'East', 12.9750, 77.7200),
('Thurahalli', 'South', 12.9000, 77.5500),
('Tumkur Road', 'West', 13.0600, 77.5000),
('Ulsoor Road', 'Central', 12.9800, 77.6200),
('Uttarahalli Hobli', 'South', 12.8950, 77.5500),
('Uttarahalli Main Road', 'South', 12.9000, 77.5550),
('Vajarahalli', 'South', 12.8800, 77.5600),
('Varthur', 'East', 12.9400, 77.7400),
('Varthur Road', 'East', 12.9350, 77.7350),
('Vasanth Nagar', 'Central', 12.9900, 77.5850),
('Veerasagara Main Road', 'South', 12.8850, 77.5650),
('Vidyaranyapura', 'North', 13.0650, 77.5600),
('Vidyaranyapura Main Road', 'North', 13.0700, 77.5650),
('Vignan Nagar', 'East', 13.0050, 77.6550),
('Vijaya Bank Layout Bommanahalli', 'South', 12.8950, 77.6150),
('Vijayanagar', 'West', 12.9700, 77.5350),
('Vittal Mallya Road', 'Central', 12.9700, 77.5950),
('Viviani Road', 'Central', 12.9650, 77.6000),
('Wheeler Road', 'Central', 12.9750, 77.6100),
('Whitefield', 'East', 12.9698, 77.7500),
('Whitefield Hoskote Road', 'East', 12.9800, 77.7700),
('Whitefield Main Road', 'East', 12.9750, 77.7400),
('Wilson Garden', 'South', 12.9500, 77.6050),
('Wind Tunnel Road', 'East', 13.0200, 77.6800),
('Yamare', 'East', 12.9400, 77.7500),
('Yamare Village', 'East', 12.9350, 77.7550),
('Yelahanka', 'North', 13.1007, 77.5963),
('Yelahanka Airforce Base', 'North', 13.1100, 77.6050),
('Yelahanka New Town', 'North', 13.1050, 77.6000),
('Yelahanka Road', 'North', 13.0900, 77.5900),
('Yelenahalli Main Road', 'South', 12.8950, 77.5700),
('Yemalur', 'East', 12.9550, 77.6800),
('Yemalur Main Road', 'East', 12.9500, 77.6750),
('Yeswanthpur', 'West', 13.0200, 77.5400);

-- ============================================================
-- INSERT AREA METRICS (current price + growth from MagicBricks)
-- growth_1yr = QoQ * 4 (quarterly annualized approximation)
-- growth_3yr and growth_5yr = estimated from current trends
-- avg_roi_pct = annualized 5yr return estimate
-- ============================================================
INSERT INTO area_metrics (area_id, current_price, growth_1yr, growth_3yr, growth_5yr, avg_roi_pct)
SELECT area_id, current_price, growth_1yr,
       ROUND(growth_1yr * 2.8, 2) AS growth_3yr,
       ROUND(growth_1yr * 4.5, 2) AS growth_5yr,
       ROUND(growth_1yr * 0.85, 2) AS avg_roi_pct
FROM (
SELECT a.area_id, v.current_price, v.growth_1yr
FROM areas a
JOIN (
  SELECT '1st Block Rajajinagar' AS name, 25200 AS current_price, 24.00 AS growth_1yr UNION ALL
  SELECT 'Aavalahalli', 11554, 4.00 UNION ALL
  SELECT 'Adarsh Palm Retreat', 18758, 2.00 UNION ALL
  SELECT 'AECS Layout Marathahalli', 12519, 176.00 UNION ALL
  SELECT 'Aga Abbas Ali Road', 16912, -4.00 UNION ALL
  SELECT 'Agrahara Layout Main Road', 10412, -16.00 UNION ALL
  SELECT 'Agrahara Main Road', 10409, 4.00 UNION ALL
  SELECT 'Akshayanagar', 10712, 1.60 UNION ALL
  SELECT 'Allalasandra Yelahanka', 10648, -24.00 UNION ALL
  SELECT 'Ambalipura', 11682, 28.00 UNION ALL
  SELECT 'Ambalipura Haralur', 14407, 20.00 UNION ALL
  SELECT 'Ambalipura Sarjapur Road', 11885, 4.00 UNION ALL
  SELECT 'Amrutahalli', 7874, -1.20 UNION ALL
  SELECT 'Amruthahalli Main Road', 8894, -4.00 UNION ALL
  SELECT 'Ananth Nagar', 6050, -4.00 UNION ALL
  SELECT 'Anekal', 12703, 20.00 UNION ALL
  SELECT 'Anekal Hosur Road', 12672, 20.00 UNION ALL
  SELECT 'Anekal Main Road', 7406, 48.00 UNION ALL
  SELECT 'AnjanaPura', 6991, 24.00 UNION ALL
  SELECT 'Anjanapura Main Road', 9492, 0.00 UNION ALL
  SELECT 'Arekere', 8368, -4.00 UNION ALL
  SELECT 'Armane Nagar', 23451, 0.00 UNION ALL
  SELECT 'Ashok Nagar', 27944, 12.00 UNION ALL
  SELECT 'Attibele', 6775, 24.00 UNION ALL
  SELECT 'Attibele Anekal Road', 6881, -28.00 UNION ALL
  SELECT 'Attur Lake Road', 9463, 28.00 UNION ALL
  SELECT 'Ayyappa Nagar Main Road', 9441, -4.00 UNION ALL
  SELECT 'Bagalur Colony', 9962, 4.00 UNION ALL
  SELECT 'Bagalur Main Road', 10372, 16.00 UNION ALL
  SELECT 'Bagaluru', 10151, 12.00 UNION ALL
  SELECT 'Balagere', 12284, -0.40 UNION ALL
  SELECT 'Balagere Road', 13074, 16.00 UNION ALL
  SELECT 'Banashankari', 10948, 24.00 UNION ALL
  SELECT 'Banaswadi', 8920, 4.00 UNION ALL
  SELECT 'Bangalore Chennai Highway', 8705, 20.00 UNION ALL
  SELECT 'Bannerghatta Main Road', 10024, 4.00 UNION ALL
  SELECT 'Bannerughatta', 12891, 12.00 UNION ALL
  SELECT 'Basapura Main Road', 10415, 36.00 UNION ALL
  SELECT 'Basapura Village Road', 10483, 16.00 UNION ALL
  SELECT 'Basavanagudi', 14896, 4.00 UNION ALL
  SELECT 'Basaveshwar Nagar', 10949, 84.00 UNION ALL
  SELECT 'Battarahalli', 7446, -68.00 UNION ALL
  SELECT 'Begur', 10508, 40.00 UNION ALL
  SELECT 'Begur Hulimavu Road', 9286, 116.00 UNION ALL
  SELECT 'Begur Koppa Road', 9234, 60.00 UNION ALL
  SELECT 'Begur Road', 9669, 20.00 UNION ALL
  SELECT 'Belathur', 8853, 8.00 UNION ALL
  SELECT 'Belathur Main Road', 9972, 52.00 UNION ALL
  SELECT 'Bellahalli Main Road', 10691, 4.00 UNION ALL
  SELECT 'Bellandur', 15106, 4.00 UNION ALL
  SELECT 'Bellary Road', 9911, 4.00 UNION ALL
  SELECT 'Bengaluru Kanakapura Road', 10135, 4.00 UNION ALL
  SELECT 'Bengaluru Main Road', 6775, 24.00 UNION ALL
  SELECT 'Benson Town', 13503, 4.00 UNION ALL
  SELECT 'Bhattarahalli', 10470, 24.00 UNION ALL
  SELECT 'Bhoganhalli', 16095, 16.00 UNION ALL
  SELECT 'Bhoopasandra Main Road', 10133, 0.00 UNION ALL
  SELECT 'Bidarahalli', 10601, 1.20 UNION ALL
  SELECT 'Bilekahalli', 7873, 8.00 UNION ALL
  SELECT 'Bileshivale Main Road', 10379, 4.00 UNION ALL
  SELECT 'Binny Pete', 14379, 8.00 UNION ALL
  SELECT 'Block 1st Koramangala', 19019, 0.00 UNION ALL
  SELECT 'Block 7th Jayanagar', 16583, 16.00 UNION ALL
  SELECT 'Bommanahalli', 7433, 16.00 UNION ALL
  SELECT 'Bommasandra', 7534, 40.00 UNION ALL
  SELECT 'Bommasandra Jigani Link Road', 7208, 48.00 UNION ALL
  SELECT 'Borewell Road', 12780, 8.00 UNION ALL
  SELECT 'Brookefield', 11118, 16.00 UNION ALL
  SELECT 'BTM Layout', 10086, 20.00 UNION ALL
  SELECT 'Budigere', 10956, 8.00 UNION ALL
  SELECT 'Budigere Cross', 11815, 32.00 UNION ALL
  SELECT 'Budigere Road', 11495, 1.20 UNION ALL
  SELECT 'Byatarayanapura', 16155, 72.00 UNION ALL
  SELECT 'Cambridge Layout', 16596, 1.60 UNION ALL
  SELECT 'Cambridge Road', 16840, 0.00 UNION ALL
  SELECT 'Carmelaram', 11806, 20.00 UNION ALL
  SELECT 'Chambenahalli', 8864, 12.00 UNION ALL
  SELECT 'Chandapura', 6496, 20.00 UNION ALL
  SELECT 'Chandapura Anekal Road', 7671, 32.00 UNION ALL
  SELECT 'Chandapura Dommasandra Road', 7560, 0.00 UNION ALL
  SELECT 'Channasandra', 10867, 44.00 UNION ALL
  SELECT 'Channasandra Main Road', 10373, 12.00 UNION ALL
  SELECT 'Chellikere', 11464, 12.00 UNION ALL
  SELECT 'Chikka Thirupati Road', 12145, 4.00 UNION ALL
  SELECT 'Chikkakannalli', 12832, 1.20 UNION ALL
  SELECT 'Chokkanahalli', 10671, 0.80 UNION ALL
  SELECT 'Choodasandra', 10377, 8.00 UNION ALL
  SELECT 'Chunchgatta Main Road', 15309, 0.00 UNION ALL
  SELECT 'Church Street', 26949, 36.00 UNION ALL
  SELECT 'Coles Road', 11535, 0.00 UNION ALL
  SELECT 'Cooke Town', 12970, 0.00 UNION ALL
  SELECT 'Cox Town', 10074, 8.00 UNION ALL
  SELECT 'Crescent Road', 13573, 0.00 UNION ALL
  SELECT 'Cubbon Road', 13877, 12.00 UNION ALL
  SELECT 'Cunningham Road', 18530, 8.00 UNION ALL
  SELECT 'CV Raman Nagar', 9044, 12.00 UNION ALL
  SELECT 'Dasarahalli Main Road', 11542, 4.00 UNION ALL
  SELECT 'Davis Road', 13684, 4.00 UNION ALL
  SELECT 'Defence Colony Indiranagar', 23284, 0.80 UNION ALL
  SELECT 'Devanahalli', 9568, 16.00 UNION ALL
  SELECT 'Devarabisanahalli', 16444, 0.00 UNION ALL
  SELECT 'Devasthanagalu', 13436, 8.00 UNION ALL
  SELECT 'Devinagar', 9100, 8.00 UNION ALL
  SELECT 'Dickenson Road', 17373, 16.00 UNION ALL
  SELECT 'Doddaballapur Main Road', 10042, 8.00 UNION ALL
  SELECT 'Doddaballapura', 11564, 0.00 UNION ALL
  SELECT 'Doddaballapura Main Road', 10037, 8.00 UNION ALL
  SELECT 'Doddagubbi Main Road', 10394, 0.00 UNION ALL
  SELECT 'Doddakallasandra', 9307, 16.00 UNION ALL
  SELECT 'Doddakammanahalli Main Road', 11092, 32.00 UNION ALL
  SELECT 'Doddakannelli', 12133, 16.00 UNION ALL
  SELECT 'Doddakannelli Chikkanayakana Halli Road', 11836, 20.00 UNION ALL
  SELECT 'Doddakannelli kaadubeesanahalli Road', 17967, 4.00 UNION ALL
  SELECT 'Doddanagamangala Road', 9568, 0.00 UNION ALL
  SELECT 'Doddanekundi', 6994, 12.00 UNION ALL
  SELECT 'Doddanekundi Main Road', 7034, 12.00 UNION ALL
  SELECT 'Dollars Colony Stage 2nd RMV', 13352, 56.00 UNION ALL
  SELECT 'Domlur', 12247, 0.80 UNION ALL
  SELECT 'Dommasandra', 10940, 0.40 UNION ALL
  SELECT 'Double Road', 14455, 36.00 UNION ALL
  SELECT 'Dr Vishnuvardhan Road', 8109, 8.00 UNION ALL
  SELECT 'ECC Road', 15378, 1.60 UNION ALL
  SELECT 'Electronic City', 8879, 24.00 UNION ALL
  SELECT 'EPIP Zone', 16859, 4.00 UNION ALL
  SELECT 'Gear School Road', 15423, 16.00 UNION ALL
  SELECT 'Giri Nagar', 8615, 0.80 UNION ALL
  SELECT 'GM Palya Main Road', 8280, 44.00 UNION ALL
  SELECT 'Gottigere', 8923, 44.00 UNION ALL
  SELECT 'Green Glen Layout', 15058, 12.00 UNION ALL
  SELECT 'Gubbalala', 8490, 12.00 UNION ALL
  SELECT 'Gubbalala Main Road', 8418, 16.00 UNION ALL
  SELECT 'Gunjur', 10991, 8.00 UNION ALL
  SELECT 'Gunjur Balagere Road', 10830, 0.00 UNION ALL
  SELECT 'Gunjur Doddakannelli Road', 10480, 0.00 UNION ALL
  SELECT 'Hadosiddapura', 14559, 4.00 UNION ALL
  SELECT 'HAL', 15471, 0.80 UNION ALL
  SELECT 'HAL Old Airport Road', 13580, 44.00 UNION ALL
  SELECT 'Halasuru', 16977, 4.00 UNION ALL
  SELECT 'Haralur', 13398, 12.00 UNION ALL
  SELECT 'Haralur Main Road', 12633, 4.00 UNION ALL
  SELECT 'Harlur', 12164, 36.00 UNION ALL
  SELECT 'HBR Layout', 8273, 16.00 UNION ALL
  SELECT 'Hebbal', 16337, 8.00 UNION ALL
  SELECT 'Hebbal Kempapura', 9389, 8.00 UNION ALL
  SELECT 'Hennur Bagalur Main Road', 9783, 4.00 UNION ALL
  SELECT 'Hennur Bande', 11500, 12.00 UNION ALL
  SELECT 'Hennur Gardens', 9986, 4.00 UNION ALL
  SELECT 'Hennur Main Road', 10261, 1.60 UNION ALL
  SELECT 'Hesarghatta Road', 10687, 8.00 UNION ALL
  SELECT 'HMT Main Road', 10000, 0.80 UNION ALL
  SELECT 'Holiday Village Road', 10491, 1.60 UNION ALL
  SELECT 'Hongasandra', 6472, 0.00 UNION ALL
  SELECT 'Hoodi', 9916, 1.20 UNION ALL
  SELECT 'Hoodi Main Road', 9902, 16.00 UNION ALL
  SELECT 'Horamavu', 7143, 16.00 UNION ALL
  SELECT 'Horamavu Agara', 7258, 12.00 UNION ALL
  SELECT 'Horamavu Agara Main Road', 7091, 16.00 UNION ALL
  SELECT 'Horamavu Agara Road', 9975, 4.00 UNION ALL
  SELECT 'Horamavu Main Road', 6995, 20.00 UNION ALL
  SELECT 'Hosa Road', 10196, 16.00 UNION ALL
  SELECT 'Hosa Road Area', 10720, 12.00 UNION ALL
  SELECT 'Hosabasavanapura', 10391, 0.00 UNION ALL
  SELECT 'Hosahalli Main Road', 14358, 8.00 UNION ALL
  SELECT 'Hosapalya Main Road', 9403, 0.00 UNION ALL
  SELECT 'Hoskote', 6944, 64.00 UNION ALL
  SELECT 'Hoskote Chintamani Road', 7060, 72.00 UNION ALL
  SELECT 'Hoskote Malur Road', 6781, 0.00 UNION ALL
  SELECT 'Hosur Main Road', 16204, 4.00 UNION ALL
  SELECT 'Hosur Road', 9178, 16.00 UNION ALL
  SELECT 'HRBR Layout', 13259, 8.00 UNION ALL
  SELECT 'HSR Extension', 9631, 4.00 UNION ALL
  SELECT 'HSR Layout', 9363, 0.80 UNION ALL
  SELECT 'Hulimangala Road', 8077, 0.00 UNION ALL
  SELECT 'Hulimavu', 12598, 24.00 UNION ALL
  SELECT 'Hulimavu Lake Road', 12608, 32.00 UNION ALL
  SELECT 'Huskur Road', 7574, 60.00 UNION ALL
  SELECT 'Hutchins Road', 12900, 4.00 UNION ALL
  SELECT 'Huvinayakanahalli', 8776, 48.00 UNION ALL
  SELECT 'Immadihalli', 9094, 44.00 UNION ALL
  SELECT 'Indiranagar', 18773, 1.20 UNION ALL
  SELECT 'ITPL', 15167, 56.00 UNION ALL
  SELECT 'ITPL Main Road', 10187, 8.00 UNION ALL
  SELECT 'Ittamadu Main Road', 10324, 20.00 UNION ALL
  SELECT 'Jagajeevanram Nagar', 14425, 8.00 UNION ALL
  SELECT 'Jakkur', 10907, 4.00 UNION ALL
  SELECT 'Jakkur Road', 7937, 4.00 UNION ALL
  SELECT 'Jakkuru Layout', 13692, 72.00 UNION ALL
  SELECT 'Jalahalli', 8565, 0.80 UNION ALL
  SELECT 'Jalahalli Cross Road', 10146, 0.00 UNION ALL
  SELECT 'Jalahalli Road', 8491, 4.00 UNION ALL
  SELECT 'Jalahalli West', 8387, 12.00 UNION ALL
  SELECT 'Jambusavari Dinne Main Road', 9882, 8.00 UNION ALL
  SELECT 'Jayamahal', 15534, 4.00 UNION ALL
  SELECT 'Jayamahal Main Road', 15024, 1.20 UNION ALL
  SELECT 'Jayanagar', 14290, 12.00 UNION ALL
  SELECT 'JCR Layout', 14823, 24.00 UNION ALL
  SELECT 'Jeevan Bima Nagar', 7850, 84.00 UNION ALL
  SELECT 'Jigani', 5495, 20.00 UNION ALL
  SELECT 'JP Nagar', 9893, 8.00 UNION ALL
  SELECT 'Judicial Layout', 14004, 48.00 UNION ALL
  SELECT 'K Channasandra Main Road', 6253, 0.00 UNION ALL
  SELECT 'K Narayanapura Main Road', 10631, 12.00 UNION ALL
  SELECT 'Kadabeesanahalli', 15937, 4.00 UNION ALL
  SELECT 'Kadubeesanahalli', 11389, 36.00 UNION ALL
  SELECT 'Kadubeesanahalli Road', 14250, 24.00 UNION ALL
  SELECT 'Kadugodi', 9582, 4.00 UNION ALL
  SELECT 'Kaggadasapura', 7032, 52.00 UNION ALL
  SELECT 'Kaggadasapura Main Road', 8288, 36.00 UNION ALL
  SELECT 'Kaikondrahalli', 14535, 24.00 UNION ALL
  SELECT 'Kalena Agrahara', 10760, 4.00 UNION ALL
  SELECT 'Kalkere Main Road', 7009, 20.00 UNION ALL
  SELECT 'Kalyan Nagar', 9298, 12.00 UNION ALL
  SELECT 'Kammanahalli', 16675, 4.00 UNION ALL
  SELECT 'Kammanahalli Main Road', 9048, 8.00 UNION ALL
  SELECT 'Kammasandra Electronic City', 6068, 4.00 UNION ALL
  SELECT 'Kanakapura', 12920, 40.00 UNION ALL
  SELECT 'Kanakapura Road', 10494, 8.00 UNION ALL
  SELECT 'Kannamangala', 9824, 2.00 UNION ALL
  SELECT 'Kannamangala Main Road', 10218, 12.00 UNION ALL
  SELECT 'Kannuru Road', 10386, 4.00 UNION ALL
  SELECT 'Kasavanahalli', 9764, 0.00 UNION ALL
  SELECT 'Kasavanahalli Main Road', 12203, 12.00 UNION ALL
  SELECT 'Kasturba Road', 26836, 32.00 UNION ALL
  SELECT 'Kasturi Nagar', 8063, 0.00 UNION ALL
  SELECT 'Kathriguppe Main Road', 13241, 1.20 UNION ALL
  SELECT 'Kempegowda International Airport Road', 11071, 12.00 UNION ALL
  SELECT 'Kengeri', 7480, 28.00 UNION ALL
  SELECT 'Kengeri Kommaghatta Road', 7138, 20.00 UNION ALL
  SELECT 'Kengeri Main Road', 6946, 16.00 UNION ALL
  SELECT 'Kengeri Satellite Town', 7029, 8.00 UNION ALL
  SELECT 'Kithaganur Main Road', 10115, 20.00 UNION ALL
  SELECT 'Kodathi', 10715, 8.00 UNION ALL
  SELECT 'Kodichikkanahalli Main Road', 7683, 4.00 UNION ALL
  SELECT 'Kodigehalli', 6864, 60.00 UNION ALL
  SELECT 'Kodigehalli Main Road', 7798, 20.00 UNION ALL
  SELECT 'Kodihalli', 11694, 0.00 UNION ALL
  SELECT 'Kodipalya Road', 7396, 28.00 UNION ALL
  SELECT 'Kogilu', 10523, 8.00 UNION ALL
  SELECT 'Kogilu Main Road', 10641, 0.80 UNION ALL
  SELECT 'Konanakunte', 15387, 48.00 UNION ALL
  SELECT 'Koppa Road', 10594, 0.80 UNION ALL
  SELECT 'Koramangala', 15587, 4.00 UNION ALL
  SELECT 'Kothanur', 10105, 12.00 UNION ALL
  SELECT 'Krishna Rajendra Road', 12426, 0.00 UNION ALL
  SELECT 'Krishnarajapura', 10558, 12.00 UNION ALL
  SELECT 'Kudlu', 8389, 16.00 UNION ALL
  SELECT 'Kudlu Gate', 13314, 1.20 UNION ALL
  SELECT 'Kudlu Main Road', 11878, 4.00 UNION ALL
  SELECT 'Kumaraswamy Layout', 8267, 24.00 UNION ALL
  SELECT 'Kundalahalli', 10246, 8.00 UNION ALL
  SELECT 'KV Jairam Road', 11583, 12.00 UNION ALL
  SELECT 'Lal Bagh Main Road', 22606, 1.20 UNION ALL
  SELECT 'Langford Road', 17544, 8.00 UNION ALL
  SELECT 'Lavelle Road', 24178, 4.00 UNION ALL
  SELECT 'Magadi Main Road', 12833, 8.00 UNION ALL
  SELECT 'Mahadevapura', 8516, 4.00 UNION ALL
  SELECT 'Mahatma Gandhi Road', 16068, 60.00 UNION ALL
  SELECT 'Mallasandra', 11199, 20.00 UNION ALL
  SELECT 'Malleshpalya Main Road', 8310, 44.00 UNION ALL
  SELECT 'Malleshwaram', 15109, 0.80 UNION ALL
  SELECT 'Manayata Tech Park', 12411, 108.00 UNION ALL
  SELECT 'Manyata Tech Park Road', 11712, 12.00 UNION ALL
  SELECT 'Marathahalli', 9242, 8.00 UNION ALL
  SELECT 'Marathahalli Main Road', 8748, 44.00 UNION ALL
  SELECT 'Marathahalli Sarjapur Outer Ring Road', 15145, 16.00 UNION ALL
  SELECT 'Mathikere', 10124, 16.00 UNION ALL
  SELECT 'Mavalli', 16429, 0.80 UNION ALL
  SELECT 'Medahalli Kadugodi Road', 11651, 8.00 UNION ALL
  SELECT 'Millers Road', 13658, 2.00 UNION ALL
  SELECT 'Mission Road', 14984, 8.00 UNION ALL
  SELECT 'MSR College Road', 10743, 1.60 UNION ALL
  SELECT 'Munnekollal', 7564, 8.00 UNION ALL
  SELECT 'Murgesh Pallya', 7603, 92.00 UNION ALL
  SELECT 'Museum Road', 28255, 16.00 UNION ALL
  SELECT 'Mysore Road', 8249, 1.20 UNION ALL
  SELECT 'Naagarabhaavi', 6887, 12.00 UNION ALL
  SELECT 'Nagarabhavi Main Road', 8217, 16.00 UNION ALL
  SELECT 'Nagasandra', 9695, 16.00 UNION ALL
  SELECT 'Nagasandra Main Road', 10147, 8.00 UNION ALL
  SELECT 'Nagavara', 12167, 16.00 UNION ALL
  SELECT 'Nallurhalli', 12607, 12.00 UNION ALL
  SELECT 'Nandi Durga Road', 13732, 4.00 UNION ALL
  SELECT 'Neeladri Road', 8669, 44.00 UNION ALL
  SELECT 'New Airport Road', 10243, 8.00 UNION ALL
  SELECT 'New BEL Road', 10403, 4.00 UNION ALL
  SELECT 'Nice Ring Road', 9269, 24.00 UNION ALL
  SELECT 'NRI Layout Main Road', 6410, 0.00 UNION ALL
  SELECT 'Old Madras Road', 10714, 8.00 UNION ALL
  SELECT 'Old Mysuru Road', 13279, 0.00 UNION ALL
  SELECT 'Outer Ring Road', 9920, 0.00 UNION ALL
  SELECT 'Padmanabhanagar', 8405, 72.00 UNION ALL
  SELECT 'Pai Layout Mahadevapura', 7040, 1.60 UNION ALL
  SELECT 'Palace Road', 17123, 4.00 UNION ALL
  SELECT 'Panathur', 14536, 24.00 UNION ALL
  SELECT 'Panathur Main Road', 14528, 20.00 UNION ALL
  SELECT 'Panduranga Nagar', 10517, 20.00 UNION ALL
  SELECT 'Parappana Agrahara', 10836, 1.60 UNION ALL
  SELECT 'Pattandur Agrahara', 15511, 0.00 UNION ALL
  SELECT 'Peenya', 10292, 4.00 UNION ALL
  SELECT 'Phase 1 Electronics City', 8770, 12.00 UNION ALL
  SELECT 'Phase 2 Electronic City', 9296, 4.00 UNION ALL
  SELECT 'Phase 4 JP Nagar', 15207, 8.00 UNION ALL
  SELECT 'Phase 5 JP Nagar', 8382, 68.00 UNION ALL
  SELECT 'Phase 6 JP Nagar', 13763, 32.00 UNION ALL
  SELECT 'Phase 7 JP Nagar', 10274, 1.20 UNION ALL
  SELECT 'Phase 8th JP Nagar', 8388, 4.00 UNION ALL
  SELECT 'Phase 9th JP Nagar', 9696, 4.00 UNION ALL
  SELECT 'Pragathi Nagar', 10763, 8.00 UNION ALL
  SELECT 'Prakruthi Nagar Kogilu', 10242, 0.00 UNION ALL
  SELECT 'Pulikeshi Nagar', 11474, 1.60 UNION ALL
  SELECT 'Queens Road', 16096, 12.00 UNION ALL
  SELECT 'Rachenahalli', 11707, 16.00 UNION ALL
  SELECT 'Rachenahalli Main Road', 11878, 20.00 UNION ALL
  SELECT 'Rajajinagar', 23702, 12.00 UNION ALL
  SELECT 'Ramamurthi Nagar Main Road', 9694, 24.00 UNION ALL
  SELECT 'Ramamurthy Nagar', 6684, 28.00 UNION ALL
  SELECT 'Rayasandra', 9449, 32.00 UNION ALL
  SELECT 'Rayasandra Main Road', 9439, 4.00 UNION ALL
  SELECT 'Richards Town', 14985, 4.00 UNION ALL
  SELECT 'Richmond Road', 19076, 4.00 UNION ALL
  SELECT 'Richmond Town', 18090, 4.00 UNION ALL
  SELECT 'RK Hegde Nagar', 11860, 12.00 UNION ALL
  SELECT 'RMV Extension Stage 2nd RMV', 10524, 20.00 UNION ALL
  SELECT 'RR Nagar', 8350, 8.00 UNION ALL
  SELECT 'RT Nagar', 6554, 16.00 UNION ALL
  SELECT 'Sadashiva Nagar', 23716, 0.00 UNION ALL
  SELECT 'Sahakar Nagar', 9334, 24.00 UNION ALL
  SELECT 'Sai Baba Temple Road', 7758, 4.00 UNION ALL
  SELECT 'Saint Johns Road', 17221, 20.00 UNION ALL
  SELECT 'Sampigehalli Main Road', 8880, 0.00 UNION ALL
  SELECT 'Sanjay Nagar Main Road', 10609, 4.00 UNION ALL
  SELECT 'Sanjayanagara', 10152, 4.00 UNION ALL
  SELECT 'Sankey Road', 17463, 24.00 UNION ALL
  SELECT 'Sarjapur Road', 11993, 4.00 UNION ALL
  SELECT 'Sarjapura', 12130, 4.00 UNION ALL
  SELECT 'Sarjapura Attibele Road', 11634, 0.80 UNION ALL
  SELECT 'Sector 1st HSR Layout', 9844, 1.20 UNION ALL
  SELECT 'Sector 7 HSR Layout', 9549, 4.00 UNION ALL
  SELECT 'Seegehalli', 9229, 4.00 UNION ALL
  SELECT 'Seegehalli Main Road', 10696, 8.00 UNION ALL
  SELECT 'Seegehalli Road', 9236, 4.00 UNION ALL
  SELECT 'Seshadripuram', 13425, 4.00 UNION ALL
  SELECT 'Seshadripuram Main Road', 13578, 0.00 UNION ALL
  SELECT 'Shampura Main Road', 6820, 56.00 UNION ALL
  SELECT 'Shankarnag Road', 8834, 0.00 UNION ALL
  SELECT 'Shanti Nagar', 13254, 8.00 UNION ALL
  SELECT 'Shivaji Nagar', 11356, 4.00 UNION ALL
  SELECT 'Silver County Road', 12071, 4.00 UNION ALL
  SELECT 'Singasandra', 11729, 0.00 UNION ALL
  SELECT 'Sivanchetti Gardens', 17373, 16.00 UNION ALL
  SELECT 'Sompura', 9537, 48.00 UNION ALL
  SELECT 'Soukya Road', 9339, 1.60 UNION ALL
  SELECT 'Spencer Road', 11474, 1.60 UNION ALL
  SELECT 'Stage 1 BTM Layout', 13429, 4.00 UNION ALL
  SELECT 'Stage 2 RMV', 10910, 44.00 UNION ALL
  SELECT 'Stage 2nd Banashankari', 16006, 4.00 UNION ALL
  SELECT 'Stage 2nd BTM Layout', 10570, 16.00 UNION ALL
  SELECT 'Stage 3rd Banashankari', 9615, 36.00 UNION ALL
  SELECT 'Stage 6th Banashankari', 11334, 24.00 UNION ALL
  SELECT 'Subramanyapura', 8492, 52.00 UNION ALL
  SELECT 'Subramanyapura Main Road', 8308, 44.00 UNION ALL
  SELECT 'Talaghattapura', 9336, 20.00 UNION ALL
  SELECT 'Tavarekere Main Road', 10204, 0.00 UNION ALL
  SELECT 'Thalagattapura Main Road', 9398, 16.00 UNION ALL
  SELECT 'Thambu Chetty Palya', 6243, 4.00 UNION ALL
  SELECT 'Thambu Chetty Palya Main Road', 9412, 28.00 UNION ALL
  SELECT 'Thanisandra', 11638, 8.00 UNION ALL
  SELECT 'Thanisandra Main Road', 11376, 8.00 UNION ALL
  SELECT 'Thimmaiah Road', 16215, 12.00 UNION ALL
  SELECT 'Thubarahalli', 8037, 12.00 UNION ALL
  SELECT 'Thurahalli', 11256, 0.00 UNION ALL
  SELECT 'Tumkur Road', 12073, 0.80 UNION ALL
  SELECT 'Ulsoor Road', 16806, 4.00 UNION ALL
  SELECT 'Uttarahalli Hobli', 8328, 44.00 UNION ALL
  SELECT 'Uttarahalli Main Road', 9197, 24.00 UNION ALL
  SELECT 'Vajarahalli', 11681, 152.00 UNION ALL
  SELECT 'Varthur', 13213, 4.00 UNION ALL
  SELECT 'Varthur Road', 11305, 24.00 UNION ALL
  SELECT 'Vasanth Nagar', 18104, 8.00 UNION ALL
  SELECT 'Veerasagara Main Road', 9437, 0.00 UNION ALL
  SELECT 'Vidyaranyapura', 6796, 4.00 UNION ALL
  SELECT 'Vidyaranyapura Main Road', 6823, 12.00 UNION ALL
  SELECT 'Vignan Nagar', 6727, 12.00 UNION ALL
  SELECT 'Vijaya Bank Layout Bommanahalli', 7976, 8.00 UNION ALL
  SELECT 'Vijayanagar', 9224, 16.00 UNION ALL
  SELECT 'Vittal Mallya Road', 27642, 16.00 UNION ALL
  SELECT 'Viviani Road', 14903, 0.40 UNION ALL
  SELECT 'Wheeler Road', 11237, 0.80 UNION ALL
  SELECT 'Whitefield', 13206, 8.00 UNION ALL
  SELECT 'Whitefield Hoskote Road', 10215, 16.00 UNION ALL
  SELECT 'Whitefield Main Road', 12522, 8.00 UNION ALL
  SELECT 'Wilson Garden', 10778, 4.00 UNION ALL
  SELECT 'Wind Tunnel Road', 11103, 112.00 UNION ALL
  SELECT 'Yamare', 12103, 8.00 UNION ALL
  SELECT 'Yamare Village', 11789, 16.00 UNION ALL
  SELECT 'Yelahanka', 9997, 8.00 UNION ALL
  SELECT 'Yelahanka Airforce Base', 9891, 20.00 UNION ALL
  SELECT 'Yelahanka New Town', 9447, 28.00 UNION ALL
  SELECT 'Yelahanka Road', 7955, 16.00 UNION ALL
  SELECT 'Yelenahalli Main Road', 10627, 0.00 UNION ALL
  SELECT 'Yemalur', 20174, 24.00 UNION ALL
  SELECT 'Yemalur Main Road', 18263, 8.00 UNION ALL
  SELECT 'Yeswanthpur', 13280, 4.00
) AS v
ON a.name = v.name
) AS computed;

-- ============================================================
-- INSERT PRICE HISTORY (estimated backwards from current price)
-- Formula: previous year = current / (1 + annual_growth/100)
-- Using ~7% average annual growth for estimation
-- ============================================================
INSERT INTO price_history (area_id, year, avg_price_sqft, num_transactions)
SELECT 
    area_id,
    2024 as year,
    current_price,
    FLOOR(50 + RAND() * 200) as num_transactions
FROM area_metrics;

INSERT INTO price_history (area_id, year, avg_price_sqft, num_transactions)
SELECT 
    area_id,
    2023 as year,
    ROUND(current_price / 1.07, 2),
    FLOOR(40 + RAND() * 180)
FROM area_metrics;

INSERT INTO price_history (area_id, year, avg_price_sqft, num_transactions)
SELECT 
    area_id,
    2022 as year,
    ROUND(current_price / (1.07 * 1.07), 2),
    FLOOR(35 + RAND() * 160)
FROM area_metrics;

INSERT INTO price_history (area_id, year, avg_price_sqft, num_transactions)
SELECT 
    area_id,
    2021 as year,
    ROUND(current_price / (1.07 * 1.07 * 1.06), 2),
    FLOOR(30 + RAND() * 150)
FROM area_metrics;

INSERT INTO price_history (area_id, year, avg_price_sqft, num_transactions)
SELECT 
    area_id,
    2020 as year,
    ROUND(current_price / (1.07 * 1.07 * 1.06 * 1.05), 2),
    FLOOR(25 + RAND() * 140)
FROM area_metrics;

INSERT INTO price_history (area_id, year, avg_price_sqft, num_transactions)
SELECT 
    area_id,
    2019 as year,
    ROUND(current_price / (1.07 * 1.07 * 1.06 * 1.05 * 1.06), 2),
    FLOOR(20 + RAND() * 130)
FROM area_metrics;

INSERT INTO price_history (area_id, year, avg_price_sqft, num_transactions)
SELECT 
    area_id,
    2018 as year,
    ROUND(current_price / (1.07 * 1.07 * 1.06 * 1.05 * 1.06 * 1.06), 2),
    FLOOR(15 + RAND() * 120)
FROM area_metrics;

-- ============================================================
-- VIEWS (required for DBMS submission)
-- ============================================================
CREATE OR REPLACE VIEW area_price_overview AS
SELECT a.area_id, a.name, a.zone, m.current_price, m.growth_1yr, m.avg_roi_pct
FROM areas a
JOIN area_metrics m ON a.area_id = m.area_id
ORDER BY m.current_price DESC;

CREATE OR REPLACE VIEW high_growth_areas AS
SELECT a.name, a.zone, m.current_price, m.growth_1yr
FROM areas a
JOIN area_metrics m ON a.area_id = m.area_id
WHERE m.growth_1yr > 20.00
ORDER BY m.growth_1yr DESC;

CREATE OR REPLACE VIEW zone_summary AS
SELECT a.zone,
       COUNT(*) AS total_areas,
       ROUND(AVG(m.current_price), 0) AS avg_price,
       ROUND(MAX(m.current_price), 0) AS max_price,
       ROUND(MIN(m.current_price), 0) AS min_price,
       ROUND(AVG(m.growth_1yr), 2) AS avg_growth
FROM areas a
JOIN area_metrics m ON a.area_id = m.area_id
GROUP BY a.zone;

-- ============================================================
-- STORED PROCEDURES (required for DBMS submission)
-- ============================================================
DELIMITER //
CREATE PROCEDURE GetAreasByZone(IN zone_name VARCHAR(50))
BEGIN
    SELECT a.name, m.current_price, m.growth_1yr, m.avg_roi_pct
    FROM areas a
    JOIN area_metrics m ON a.area_id = m.area_id
    WHERE a.zone = zone_name
    ORDER BY m.current_price DESC;
END //

CREATE PROCEDURE GetPriceHistory(IN input_area_id INT)
BEGIN
    SELECT ph.year, ph.avg_price_sqft
    FROM price_history ph
    WHERE ph.area_id = input_area_id
    ORDER BY ph.year ASC;
END //

CREATE PROCEDURE SearchAreas(IN keyword VARCHAR(100))
BEGIN
    SELECT a.name, a.zone, m.current_price, m.growth_1yr
    FROM areas a
    JOIN area_metrics m ON a.area_id = m.area_id
    WHERE a.name LIKE CONCAT('%', keyword, '%')
    ORDER BY m.current_price DESC;
END //
DELIMITER ;

-- ============================================================
-- TRIGGERS (required for DBMS submission)
-- ============================================================
CREATE TABLE IF NOT EXISTS price_update_log (
    log_id     INT AUTO_INCREMENT PRIMARY KEY,
    area_id    INT,
    year       YEAR,
    new_price  DECIMAL(10,2),
    logged_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER log_price_insert
AFTER INSERT ON price_history
FOR EACH ROW
BEGIN
    INSERT INTO price_update_log (area_id, year, new_price)
    VALUES (NEW.area_id, NEW.year, NEW.avg_price_sqft);
END //

CREATE TRIGGER prevent_negative_price
BEFORE INSERT ON area_metrics
FOR EACH ROW
BEGIN
    IF NEW.current_price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END //
DELIMITER ;

-- ============================================================
-- VERIFICATION QUERIES - run these to check everything worked
-- ============================================================
-- SELECT COUNT(*) AS total_areas FROM areas;
-- SELECT COUNT(*) AS total_metrics FROM area_metrics;
-- SELECT COUNT(*) AS total_history FROM price_history;
-- SELECT * FROM area_price_overview LIMIT 10;
-- SELECT * FROM zone_summary;
-- CALL GetAreasByZone('East');
-- CALL SearchAreas('Whitefield');

