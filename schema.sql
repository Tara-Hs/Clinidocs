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
    contact_details INTEGER,
    address TEXT,
    medicare_number INTEGER, 
    date_of_birth TEXT,
    height TEXT,
    weight TEXT,
    blood_type TEXT
);


CREATE TABLE treatment_notes (
    id SERIAL PRIMARY KEY,
    medication_history TEXT,
    medical_history TEXT,
    correspondence TEXT,
    results TEXT, 
    case_notes TEXT
);


INSERT INTO doctors(name, email, user_id) VALUES ('David Johnson', 'david@clinidocs.co', 1);

INSERT INTO patients(name,surname, contact_details, address, medicare_number, date_of_birth, height, weight, blood_type) VALUES('John', 'Doe', 0398765436, '12 Hexagon Ave Kew VIC 3101', 1234567891, '15 March 1976', '150.8', '78 Kg', 'O +');

INSERT INTO patients(name,surname, contact_details, address, medicare_number, date_of_birth, height, weight, blood_type) VALUES('Kale', 'Adams', 0397453432, '48 neda Ave Kew VIC 3101', 1264354367, '09 June 1982', '167', '83 Kg', 'AB+');

ALTER TABLE doctors ADD COLUMN password_digest TEXT;
-- UPDATE TABLE basic_info pt_info; how to rename table?