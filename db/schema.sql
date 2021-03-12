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

INSERT INTO treatment_notes(patient_id, medication_history, medical_history, images, results) VALUES(10, 'DULOXETINE 60mg capsules(cymbalta) - 28 0xRpt', 'Depression', 'https://images.theconversation.com/files/163092/original/image-20170329-1642-1xokfii.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1000&fit=clip', 'Medication has been working. Still complaining of sadness, but it can be only mental status and not physical. Consulting sessions been adviced.');

INSERT INTO treatment_notes(patient_id, medication_history, medical_history, images, results) VALUES(9, 'ASPIRIN 100mg TABLETS(MAYNE PHARMA ASPIRIN) 112 0xRpt', 'Cardiovascular disease & Blood flow problem', 'https://www.msdmanuals.com/-/media/manual/professional/images/m5600594-chest-xray-prosthetic-heart-valve-science-photo-library-high.jpg?thn=0&sc_lang=en', 'low-dose aspirin has stoped platelets clumping together to form unwanted blood clots - and prevented heart attack and stroke.');

INSERT INTO treatment_notes(patient_id, medication_history, medical_history, images, results) VALUES(6, 'ENALAPRIL 10mg TABLETS(ACETEC) 30 0xRpt', 'High blood pressure', 'https://s3.amazonaws.com/static.wd7.us/a/a9/Diastolic_MR_Due_to_AS.jpg', 'Decrease the salt in your diet. Aim to limit sodium to less than 2,300 milligrams (mg) a day or less. Reduce stress.');

INSERT INTO treatment_notes(patient_id, medication_history, medical_history, images, results) VALUES(1, 'TEMAZEPAM 10mg TABLETS(TEMTABS) 25 0xRpt', 'Anxiety from robbery', 'https://images.squarespace-cdn.com/content/v1/57b5e6e0ebbd1ad42af1f8b6/1501535081833-MEV3CFWTU46AA4DUKV38/ke17ZwdGBToddI8pDm48kCBWOpyjM22gkD4qx8ZMUfdZw-zPPgdn4jUwVcJE1ZvWEtT5uBSRWt4vQZAgTJucoTqqXjS3CfNDSuuf31e0tVEHc7QQu2rGLrZ-5EYUsBwSarrxkPwiV0mIz0Nq9qM0-WrU1y4wb4jWGGUEMfc78qA/image-asset.jpeg', 'Patient is having trouble sleeping from axiety. Alow done of temaz been priscribed and will see the results in next check up.');

ALTER TABLE doctors ADD COLUMN password_digest TEXT;
-- UPDATE TABLE basic_info pt_info; how to rename table?

ALTER TABLE treatment_notes ADD COLUMN patient_id INTEGER;
INSERT INTO treatment_notes(patient_id) VALUES(1)