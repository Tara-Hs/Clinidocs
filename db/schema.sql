CREATE DATABASE clinidocs;


CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    password_digest TEXT
);



CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name TEXT,
    surname TEXT,
    contact_details TEXT,
    address TEXT,
    medicare_number TEXT, 
    date_of_birth TEXT,
    height TEXT,
    weight TEXT,
    blood_type TEXT
);


CREATE TABLE treatment_notes (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER,
    medication_history TEXT,
    medical_history TEXT,
    images TEXT,
    results TEXT
);


INSERT INTO doctors(name, email, user_id) VALUES ('David Johnson', 'david@clinidocs.co', 1);

INSERT INTO patients(name,surname, contact_details, address, medicare_number, date_of_birth, height, weight, blood_type) VALUES('John', 'Doe', 0398765436, '12 Hexagon Ave Kew VIC 3101', 1234567891, '15 March 1976', '150.8', '78 Kg', 'O +');

INSERT INTO patients(name,surname, contact_details, address, medicare_number, date_of_birth, height, weight, blood_type) VALUES('Kale', 'Adams', 0397453432, '48 neda Ave Kew VIC 3101', 1264354367, '09 June 1982', '167', '83 Kg', 'AB+');

INSERT INTO treatment_notes(patient_id, medication_history, medical_history, images, results) VALUES(1, 'INSULIN ISOPHANE - 100 units/ml', 'hypoglycemia', 'https://prod-images-static.radiopaedia.org/images/4994041/0f72dc013b907685ea274b9d756886_gallery.jpg', 'Medication has been working. Improvement.');

INSERT INTO treatment_notes(patient_id, medication_history, medical_history, images, results) VALUES(2, 'FRUSEMIDE 40mg TABLETS(UREMIDE) - 100', 'edema in kidney disease', 'https://prod-images-static.radiopaedia.org/images/19063571/177ea73ccff7d53ca0357fcf309a38_gallery.jpeg', 'Edema been persistent, another repeat has been prescribed.');

INSERT INTO treatment_notes(patient_id, medication_history, medical_history, images, results) VALUES(3, 'ALLOPURINOL 100mg TABLETS (PROGOUT 100) - 200', 'kidney stones', 'https://www.uofmhealth.org/sites/default/files/styles/large/public/CT%20scans%20showing%20right%20ureteral%20stones2.jpg?itok=SQtcSjgw', 'High salt diet. Patient been adviced to change diet. Another dose will be priscribed after current dose.');

ALTER TABLE doctors ADD COLUMN password_digest TEXT;
-- UPDATE TABLE basic_info pt_info; how to rename table?

ALTER TABLE treatment_notes ADD COLUMN patient_id INTEGER;
INSERT INTO treatment_notes(patient_id) VALUES(1)